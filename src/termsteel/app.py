# -*- coding: utf-8 -*-
# !/usr/bin/env python3
import argparse
from flask import Flask, render_template, redirect, url_for, request, jsonify, make_response, abort
from flask_socketio import SocketIO
from flask_argon2 import Argon2
from flask_jwt_login import JWT, login_required, get_current_user, process_login
from engineio.payload import Payload
import pty
import os
import subprocess
import select
import termios
import struct
import fcntl
import shlex
import json
import logging
import sys
import platform
import secrets
import socket
import requests
import re

if os.geteuid() == 0:
    pass
else:
    subprocess.call(['sudo', 'python3', *sys.argv])
    sys.exit()

dirpath = os.path.dirname(__file__)
configpath = os.path.join(dirpath, 'config.json')

with open(configpath, 'r+') as f:
    data = json.load(f)

if(len(data['key'])):
    pass
else:
    data['key'] = secrets.token_hex(32)
    with open(configpath, 'w') as f:
        json.dump(data, f)

logging.getLogger("werkzeug").setLevel(logging.ERROR)

__version__ = data['version']

app = Flask(__name__, static_folder="", static_url_path="")
app.config["fd"] = None
app.config["child_pid"] = None
app.config["JWT_COOKIE_NAME"] = data['token_name']
app.config['SECRET_KEY'] = data['key']
app.config["JWT_SECRET_KEY"] = data['key']
app.config["JWT_COOKIE_CSRF_PROTECT"] = data['token_protection']
app.config["JWT_SESSION_COOKIE"] = data['token_session']

Payload.max_decode_packets = data['max_decode_packets']

socketio = SocketIO(app)
argon2 = Argon2(app)
jwt = JWT(app)

latest = True

try:
    latestversion = re.sub(r"\s+", "", requests.get("https://raw.githubusercontent.com/afi-dev/Termsteel/main/VERSION").text)
except:
    print("Failed to fetch latest version from github raw")
    latest = True

if __version__ == latestversion:
    latest = True
else:
    latest = False

def set_winsize(fd, row, col, xpix=0, ypix=0):
    logging.debug("setting window size with termios")
    winsize = struct.pack("HHHH", row, col, xpix, ypix)
    fcntl.ioctl(fd, termios.TIOCSWINSZ, winsize)

def read_and_forward_pty_output():
    max_read_bytes = 2048 * 2048
    while True:
        socketio.sleep(0.01)
        if app.config["fd"]:
            timeout_sec = 0
            (data_ready, _, _) = select.select([app.config["fd"]], [], [], timeout_sec)
            if data_ready:
                output = os.read(app.config["fd"], max_read_bytes).decode("utf-8", "ignore")
                socketio.emit("pty-output", {"output": output}, namespace="/pty")

class User():
    def __init__(self, pw, username):
        self.pw = pw
        self.username = username

    def __repr__(self):
        return "User(password=%s, username=%s)" % (self.pw, self.username)

@app.route("/config.json")
def protect_config():
    return redirect("dashboard")

@app.route("/app.py")
def protect_app():
    return redirect("dashboard")

@app.route("/__init__.py")
def protect_init():
    return redirect("dashboard")

@app.route("/__main__.py")
def protect_main():
    return redirect("dashboard")

@jwt.authentication_handler
def authentication_handler(username, pw):
    if data['username'] == username and argon2.check_password_hash(data['password'],pw) == True:
        return User(data['password'], data['username'])
    return None

@jwt.unauthorized_handler
def unauthorized_handler():
    return redirect("login")

@app.errorhandler(501)
def unauthorized(e):
    abort(501)

@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "GET":
        return render_template("login.html", version = __version__)

    token = process_login(request.form["username"], request.form["pw"])
    if token is not None:
        response = make_response(redirect("dashboard"))
        response.set_cookie(data['token_name'], token)
        return response

    return redirect("login")

@app.route("/logout")
def logout():
    data['key'] = secrets.token_hex(32)
    with open(configpath, 'w') as f:
        json.dump(data, f)
    resp = make_response(redirect("dashboard"))
    resp.set_cookie(data['token_name'], expires=0)
    return resp

@app.route("/")
def default_route():
    return redirect("dashboard")

@app.errorhandler(404)
def page_not_found(e):
    return redirect("/dashboard")

@app.route("/dashboard")
@login_required
def index():
    return render_template("dashboard.html", version = __version__, latest = latest, osname = osname, ostype = ostype)

@app.route('/dashboard', methods=["GET", "POST"])
@login_required
def change_credentials():
    if request.method == "POST":
        data['username'] = request.form.get("username")
        data['password'] = argon2.generate_password_hash(request.form.get("password"))
        data['key'] = secrets.token_hex(32)
        with open(configpath, 'w') as f:
            json.dump(data, f)
        resp = make_response(redirect("dashboard"))
        resp.set_cookie(data['token_name'], expires=0)
    return resp

@socketio.on("pty-input", namespace="/pty")
@login_required
def pty_input(data):
    """write to the child pty. The pty sees this as if you are typing in a real
    terminal.
    """
    if app.config["fd"]:
        logging.debug("received input from browser: %s" % data["input"])
        os.write(app.config["fd"], data["input"].encode())


@socketio.on("resize", namespace="/pty")
@login_required
def resize(data):
    if app.config["fd"]:
        logging.debug(f"Resizing window to {data['rows']}x{data['cols']}")
        set_winsize(app.config["fd"], data["rows"], data["cols"])


@socketio.on("connect", namespace="/pty")
@login_required
def connect():
    """new client connected"""
    logging.info("new client connected")
    if app.config["child_pid"]:
        return

    (child_pid, fd) = pty.fork()
    if child_pid == 0:
        subprocess.run(app.config["cmd"])
    else:
        app.config["fd"] = fd
        app.config["child_pid"] = child_pid
        set_winsize(fd, 50, 50)
        cmd = " ".join(shlex.quote(c) for c in app.config["cmd"])
        socketio.start_background_task(target=read_and_forward_pty_output)

        logging.info("child pid is " + child_pid)
        logging.info(
            f"starting background task with command `{cmd}` to continously read "
            "and forward pty output to client"
        )
        logging.info("task started")


def extract_ip():
    st = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    try:
        st.connect(('10.255.255.255', 1))
        IP = st.getsockname()[0]
    except Exception:
        IP = '127.0.0.1'
    finally:
        st.close()
    return IP

osname = socket.gethostname()
ostype = platform.machine()

def main():
    parser = argparse.ArgumentParser(
        description=(
            "A versatile and sleek web terminal built in python "
        ),
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument("-p", "--port", default=5000, help="port to run server on")
    parser.add_argument(
        "--host",
        default=extract_ip(),
        help="host to run server on (it is highly recommended to use the ip of your machine from your local network)",
    )
    parser.add_argument("--debug", action="store_true", help="debug the server")
    parser.add_argument("--version", action="store_true", help="print version and exit")
    parser.add_argument("-r", "--reset", action="store_true", help="reset Termsteel to default password")
    parser.add_argument(
        "-c", "--command", default="bash", help="Command to run in the terminal, i.e: htop"
    )
    parser.add_argument(
        "--cmd-args",
        default="",
        help="arguments to pass to command (i.e. --cmd-args='arg1 arg2 --flag')",
    )
    args = parser.parse_args()
    if args.version:
        print(__version__)
        exit(0)
    if args.reset:
        confirm_reset = None
        while confirm_reset not in ("yes", "no", "y", "n", "Y", "N", "Yes", "No"):
            confirm_reset = input("Are you sure to reset Termsteel (Y/n): ")
            if confirm_reset == "yes" or confirm_reset == "Yes" or confirm_reset == "Y" or confirm_reset == "y":
                data['username'] = "Admin"
                data['password'] = argon2.generate_password_hash("Termsteel")
                data['key'] = secrets.token_hex(32)
                with open(configpath, 'w') as f:
                    json.dump(data, f)
                print("Reset Succesful")
                exit(0)
            elif confirm_reset == "no" or confirm_reset == "No" or confirm_reset == "N" or confirm_reset == "n":
                print("Cancelled")
                exit(0)
            else:
                pass
    app.config["cmd"] = [args.command] + shlex.split(args.cmd_args)
    log_format = "\033[1m | \033[01\033[90] [\033[01\033[90m%(levelname)s\033[0m\033[01\033[90]]\033[0m (%(funcName)s:%(lineno)s) %(message)s"
    logging.basicConfig(
        format=log_format,
        stream=sys.stdout,
        level=logging.DEBUG if args.debug else logging.INFO,
    )
    version_tooltip = ""
    if __version__ == latestversion:
        pass
    else:
        version_tooltip = "\033[01] [!] The new version \033[33mV" + latestversion + "\033[39m\033[01] is available.\033[0m"
    logging.info(f"""
\033[1m 

                    .::::::.                
                .::^^::::::^^:..            
             .:^^:::::....:::::^::.         
         .::^^::::....::::....::::^^::.     
        :^^:::....::::::::::::....:::^^:    
       ^^::...::::::..::::::::::::...::^^   
      :^::.:::::::..^:.::::::::::::::.::^:  
      :^::.::::...^YY:.::::::::::::::.::^:  
      :^::.:::.:~5&&!^:.:::::::::::::.::^:  
      :^::.:::.^J5@@#J:..........::::.::^:  
      :^::.::::..J#J^..:~!!!!!!!^.:::.::^:  
      :^::.::::.^7:..:.:PGGGGGGG7.:::.::^:  
      :^::.::::::..::::..........::::.::^:  
       ^^::...::::::::::.........:...::^^   
        :^^:::....::::::::::::....:::^^:    
         .::^^::::....::::....::::^^::.     
             .:^^^::::....::::^^^:.         
                .::^^^::::^^^:..            
                    .::::::.                                                                                                                                

                Termsteel \033[01\033[90mV.{__version__}\033[0m
                                     
    {version_tooltip} \033[0m
    """)
    if args.debug == True:
        logging.info(f"Debug mode enabled")

    if data['reset'] == True:
        data['username'] = 'Admin'
        data['password'] = argon2.generate_password_hash('Termsteel')
        with open(configpath, 'w') as f:
            json.dump(data, f)
        data['reset'] = False
        logging.info("Reset successful")

    with open(configpath, 'w') as f:
        json.dump(data, f)
    logging.info(f"Termsteel is available on \033[01\033[90mhttp://{args.host}:{args.port}\033[0m")
    socketio.run(app, debug=args.debug, port=args.port, host=args.host)


if __name__ == "__main__":
    from waitress import serve
    main()