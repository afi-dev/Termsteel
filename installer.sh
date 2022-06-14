#!/bin/bash

# /*!
#  * Termsteel Installer V0.4BETA
#  * (c) 2022 Afi
#  * Released under the MIT License.
#  */

#EXPORT

export NEWT_COLORS='
root=white,gray
window=white,lightgray
border=black,lightgray
shadow=white,black
button=black,green
actbutton=black,red
compactbutton=black,
title=black,
roottext=black,gray
textbox=black,lightgray
acttextbox=gray,white
entry=lightgray,gray
disentry=gray,lightgray
checkbox=black,lightgray
actcheckbox=black,green
emptyscale=,black
fullscale=,red
listbox=black,lightgray
actlistbox=lightgray,gray
actsellistbox=black,green
'

# === FUNCTIONS ===

function Python_check() {

type -P python3 >/dev/null 2>&1 && Python_Installed=yes
if [[ "$Python_Installed" == 'yes' ]]; then
    Wget_check
else
    if whiptail --yesno "Termsteel detects that Python3 is not installed on your machine, but this is necessary in the installation of termsteel.\n\nDo you want Termsteel installer install Python 3 for you ?" 15 50; then
    sudo apt-get install python3 &>/dev/null
    sudo apt install python3-pip &>/dev/null
    Python_check
    else
    exit 1
    fi
fi

}

function Wget_check() {

type -P wget >/dev/null 2>&1 && Wget_Installed=yes
if [[ "$Wget_Installed" == 'yes' ]]; then
    Fastjar_check
else
    if whiptail --yesno "Termsteel detects that Wget is not installed on your machine, but this is necessary in the installation of termsteel.\n\nDo you want Termsteel installer install Wget for you ?" 15 50; then
    apt-get install wget &>/dev/null
    Wget_check
    fi
fi

}

function Fastjar_check() {

type -P fastjar >/dev/null 2>&1 && Fastjar_Installed=yes
if [[ "$Fastjar_Installed" == 'yes' ]]; then
    Termsteel_version
else
    if whiptail --yesno "Termsteel detects that Fastjar is not installed on your machine, but this is necessary in the installation of termsteel.\n\nDo you want Termsteel installer install Fastjar for you ?" 15 50; then
    apt-get install fastjar &>/dev/null
    Termsteel_version
    fi
fi

}

function Menu() {

CHOICE=$(whiptail --menu "Termsteel installer V0.4beta" 18 100 10 \
  "1." "Install Termsteel" \
  "2." "Troubleshooting" \
  "3." "Exit Termsteel installer" 3>&1 1>&2 2>&3)

if [ -z "$CHOICE" ]; then
  exit 1
else
    if [[ "$CHOICE" == '1.' ]]; then
        Python_check
    elif [[ "$CHOICE" == '2.' ]]; then
        Troubleshooting
    elif [[ "$CHOICE" == '3.' ]]; then
        exit 1
    else
        exit 1
    fi
fi

}

function Troubleshooting() {

TRS_CHOICE=$(whiptail --menu --nocancel "Termsteel installer V0.4beta > Troubleshooting" 18 100 10 \
  "1." "Uninstall Termsteel" \
  "2." "Update Termsteel" \
  "3." "Reinstall all Termsteel dependencies" \
  "4." "Back" 3>&1 1>&2 2>&3)

if [ -z "$TRS_CHOICE" ]; then
  exit 1
else
    if [[ "$TRS_CHOICE" == '1.' ]]; then
        Uninstall_Termsteel
    elif [[ "$TRS_CHOICE" == '2.' ]]; then
        whiptail --msgbox --title "Update Termsteel" "This feature is not available in this version of Termsteel installer" 15 50 && Troubleshooting
    elif [[ "$TRS_CHOICE" == '3.' ]]; then
        Reinstall_Termsteel_Deeps
    elif [[ "$TRS_CHOICE" == '4.' ]]; then
        Menu
    else
        exit 1
    fi
fi

}


function Termsteel_version() {
VERSION_CHOICE=$(whiptail --menu --nocancel "Please choose a version of Termsteel" 18 100 10 \
  "1." "TERMSTEEL BETA_V0.0.1" 3>&1 1>&2 2>&3)

if [ -z "$VERSION_CHOICE" ]; then
  exit 1
else
    if [[ "$VERSION_CHOICE" == '1.' ]]; then
        Licensing
    else
        exit
    fi
fi

}

function Licensing() {
LICENSING_URL="https://raw.githubusercontent.com/afi-dev/Termsteel/main/LICENSE"
 wget "$LICENSING_URL" 2>&1 | \
 stdbuf -o0 awk '/[.] +[0-9][0-9]?[0-9]?%/ { print substr($0,63,3) }' | \
 whiptail --title "EULA" --gauge "Downloading EULA from https://raw.githubusercontent.com/afi-dev/Termsteel/main/LICENSE" 10 100 0

if(whiptail --title "Licensing" --textbox "LICENSE" --scrolltext 25 75 --ok-button "Next"); then
    if(whiptail --title "Licensing" --yesno "To install termsteel you must absolutely accept this license. Wishing you to accept the agreements subscribed in the terms ?" --scrolltext 25 75 --yes-button Agree --no-button Reject); then
        rm LICENSE -f
        Eula
    else
        rm LICENSE -f
        Menu
    fi
else
    exit 0
fi

}

function Eula() {

EULA_URL="https://raw.githubusercontent.com/afi-dev/Termsteel/main/EULA"
wget "$EULA_URL" 2>&1 | \
 stdbuf -o0 awk '/[.] +[0-9][0-9]?[0-9]?%/ { print substr($0,63,3) }' | \
 whiptail --title "EULA" --gauge "Downloading EULA from https://raw.githubusercontent.com/afi-dev/Termsteel/main/EULA" 10 100 0

if(whiptail --title "EULA Agreements" --textbox "EULA" --scrolltext 25 75 --ok-button "Next"); then
    if(whiptail --title "EULA Agreements" --yesno "To install termsteel you must absolutely accept these EULA agreements. Wishing you to accept the agreements subscribed in the terms ?" --scrolltext 25 75 --yes-button Agree --no-button Reject); then
        rm EULA -f
        Install_Termsteel
    else
        rm EULA -f
        Menu
    fi
else
    exit 0
fi

}


function Install_Termsteel() {
python_ver="$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[0:2])))')"

termsteel --version &>/dev/null
if [ $? -eq 0 ]; then
    whiptail --msgbox "Termsteel is already installed" --title "Already installed" 15 50
    Menu
else

    msgs=("Preparing Install..."
        "Starting Update your system..."
        "Preparing installing all dependencies (Python Librairies)"
        "Starting Install argon2-cffi==21.3.0"
        "Starting Install argon2-cffi-bindings==21.2.0"
        "Starting Install bidict==0.22.0"
        "Starting Install certifi==2022.5.18.1"
        "Starting Install cffi==1.15.0"
        "Starting Install charset-normalizer==2.0.12"
        "Starting Install click==7.1.2"
        "Starting Install Flask==1.0.2"
        "Starting Install Flask-Argon2==0.2.0.0"
        "Starting Install flask-jwt-login==0.0.5"
        "Starting Install Flask-SocketIO==5.2.0"
        "Starting Install idna==3.3"
        "Starting Install importlib-metadata==4.11.4"
        "Starting Install itsdangerous==1.1.0"
        "Starting Install Jinja2==2.11.3"
        "Starting Install markup==0.2"
        "Starting Install MarkupSafe==2.0.1"
        "Starting Install pycparser==2.21"
        "Starting Install PyJWT==1.6.4"
        "Starting Install python-engineio==4.2.1"
        "Starting Install python-socketio==5.4.0"
        "Starting Install requests==2.27.1"
        "Starting Install urllib3==1.26.9"
        "Starting Install waitress==2.1.2"
        "Starting Install Werkzeug==1.0.1"
        "Starting Install zipp==3.8.0"
        "Preparing Extracting Termsteel files"
        "Starting cd into /tmp"
        "Starting Download termsteel_v0.0.1.tar.gz"
        "Starting Unpacking termsteel_v0.0.1.tar.gz"
        "Starting cd into termsteel_v0.0.1"
        "Starting Install Termsteel in python3 distpackage"
        "export"
        "Starting Add $USER permissions to dist-packages on termsteel"
        "Starting Add $USER permissions to dist-packages on termsteel"
        "Starting Setup FLASK_APP on termsteel"
        "Starting Setup FLASK_ENV on development"
        "Starting cd into /tmp"
        "Starting Removing /termsteel_v0.0.1"
        "Starting Removing termsteel_v0.0.1"
        ...
        )
    commands=("sleep 0.5"
            "sudo apt-get update &>/dev/null"
            "sleep 0.5"
            "sudo pip install argon2-cffi==21.3.0 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "sudo pip install argon2-cffi-bindings==21.2.0 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "sudo pip install bidict==0.22.0 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "sudo pip install certifi==2022.5.18.1 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "sudo pip install cffi==1.15.0 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "sudo pip install charset-normalizer==2.0.12 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "sudo pip install click==7.1.2 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "sudo pip install Flask==1.0.2 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "sudo pip install Flask-Argon2==0.2.0.0 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "sudo pip install flask-jwt-login==0.0.5 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "sudo pip install Flask-SocketIO==5.2.0 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "sudo pip install idna==3.3 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "sudo pip install importlib-metadata==4.11.4 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "sudo pip install itsdangerous==1.1.0 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "sudo pip install Jinja2==2.11.3 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "sudo pip install markup==0.2 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "sudo pip install MarkupSafe==2.0.1 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "sudo pip install pycparser==2.21 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "sudo pip install PyJWT==1.6.4 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "sudo pip install python-engineio==4.2.1 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "sudo pip install python-socketio==5.4.0 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "sudo pip install requests==2.27.1 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "sudo pip install urllib3==1.26.9 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "sudo pip install waitress==2.1.2 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "sudo pip install Werkzeug==1.0.1 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "sudo pip install zipp==3.8.0 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "sleep 0.5"
            "cd /tmp &>/dev/null"
            "sudo wget https://github.com/afi-dev/Termsteel/releases/download/v0.0.1/termsteel_v0.0.1.tar.gz &>/dev/null"
            "sudo tar -xvf termsteel_v0.0.1.tar.gz"
            "cd termsteel_v0.0.1"
            "sudo python3 setup.py install &>/dev/null"
            "sudo chown -R $USER /usr/local/lib/python$python_ver/dist-packages/"
            "sudo chown -R $USER /usr/local/lib/python$python_ver/dist-packages/"
            "export FLASK_APP=termsteel &>/dev/null"
            "export FLASK_ENV=development &>/dev/null"
            "cd /tmp &>/dev/null"
            "sudo rm -rf termsteel_v0.0.1"
            "sudo rm -f termsteel_v0.0.1.tar.gz"
            ...
            )

    n=${#commands[@]}
    i=0
    while [ "$i" -lt "$n" ]; do
        pct=$(( i * 100 / n ))
        echo XXX
        echo $i
        echo "${msgs[i]}"
        echo XXX
        echo "$pct"
        eval "${commands[i]}"
        i=$((i + 1))
    done | whiptail --title "Installing Termsteel..." --gauge "We are almost there be patient..." 10 60 0

    Check_is_install

fi

}


function Check_is_install() {

if command -v termsteel &> /dev/null; then
    termsteel --version &>/dev/null
    if [ $? -eq 0 ]; then
    All_done
    else
    whiptail --msgbox --title "Error" "Termsteel installer encountered an error during the installation and did not correctly install termsteel, tried to restart an installation, if the problem persists send an issue on github." 15 50
    fi
else
    whiptail --msgbox --title "Error" "Termsteel installer encountered an error during the installation and did not correctly install termsteel, tried to restart an installation, if the problem persists send an issue on github." 15 50
    exit
fi

}

function All_done() {

whiptail --title "Termsteel installed" --msgbox "Termsteel V0.0.1 has been successfully installed ! \n\nIf you encounter a problem do not hesitate to let me know by creating an issue on github. \n\nHave fun with Termsteel" 15 50
exit
}

function Uninstall_Termsteel() {

termsteel --version &>/dev/null
if [ $? -eq 0 ]; then
    if (whiptail --title "Uninstall Termsteel" --yesno "Do you want really uninstall Termsteel ?" 15 50); then
        sudo rm /usr/local/lib/python$python_ver/dist-packages/* -rf
        sudo rm /usr/local/bin/termsteel -f
        whiptail --msgbox "Termsteel has just been successfully uninstalled" --title "Uninstalled" 15 50
        Troubleshooting
    else
        Troubleshooting
    fi
else
    whiptail --msgbox "Termsteel is not installed on this system" --title "Termsteel not installed" 15 50
    if (whiptail --title "Install Termsteel" --yesno "Do you want install Termsteel ?" 15 50); then
        Install_Termsteel
    else
        Troubleshooting
    fi
    Troubleshooting
fi
    Troubleshooting

}

function Reinstall_Termsteel_Deeps() {
    

msgs=("Preparing Install..."
      "Starting Install argon2-cffi==21.3.0"
      "Starting Install argon2-cffi-bindings==21.2.0"
      "Starting Install bidict==0.22.0"
      "Starting Install certifi==2022.5.18.1"
      "Starting Install cffi==1.15.0"
      "Starting Install charset-normalizer==2.0.12"
      "Starting Install click==7.1.2"
      "Starting Install Flask==1.0.2"
      "Starting Install Flask-Argon2==0.2.0.0"
      "Starting Install flask-jwt-login==0.0.5"
      "Starting Install Flask-SocketIO==5.2.0"
      "Starting Install idna==3.3"
      "Starting Install importlib-metadata==4.11.4"
      "Starting Install itsdangerous==1.1.0"
      "Starting Install Jinja2==2.11.3"
      "Starting Install markup==0.2"
      "Starting Install MarkupSafe==2.0.1"
      "Starting Install pycparser==2.21"
      "Starting Install PyJWT==1.6.4"
      "Starting Install python-engineio==4.2.1"
      "Starting Install python-socketio==5.4.0"
      "Starting Install requests==2.27.1"
      "Starting Install urllib3==1.26.9"
      "Starting Install waitress==2.1.2"
      "Starting Install Werkzeug==1.0.1"
      "Starting Install zipp==3.8.0"
      ...
     )
commands=("sleep 0.5"
          "sudo pip install argon2-cffi==21.3.0 --no-dependencies --upgrade --force-reinstall &>/dev/null"
          "sudo pip install argon2-cffi-bindings==21.2.0 --no-dependencies --upgrade --force-reinstall &>/dev/null"
          "sudo pip install bidict==0.22.0 --no-dependencies --upgrade --force-reinstall &>/dev/null"
          "sudo pip install certifi==2022.5.18.1 --no-dependencies --upgrade --force-reinstall &>/dev/null"
          "sudo pip install cffi==1.15.0 --no-dependencies --upgrade --force-reinstall &>/dev/null"
          "sudo pip install charset-normalizer==2.0.12 --no-dependencies --upgrade --force-reinstall &>/dev/null"
          "sudo pip install click==7.1.2 --no-dependencies --upgrade --force-reinstall &>/dev/null"
          "sudo pip install Flask==1.0.2 --no-dependencies --upgrade --force-reinstall &>/dev/null"
          "sudo pip install Flask-Argon2==0.2.0.0 --no-dependencies --upgrade --force-reinstall &>/dev/null"
          "sudo pip install flask-jwt-login==0.0.5 --no-dependencies --upgrade --force-reinstall &>/dev/null"
          "sudo pip install Flask-SocketIO==5.2.0 --no-dependencies --upgrade --force-reinstall &>/dev/null"
          "sudo pip install idna==3.3 --no-dependencies --upgrade --force-reinstall &>/dev/null"
          "sudo pip install importlib-metadata==4.11.4 --no-dependencies --upgrade --force-reinstall &>/dev/null"
          "sudo pip install itsdangerous==1.1.0 --no-dependencies --upgrade --force-reinstall &>/dev/null"
          "sudo pip install Jinja2==2.11.3 --no-dependencies --upgrade --force-reinstall &>/dev/null"
          "sudo pip install markup==0.2 --no-dependencies --upgrade --force-reinstall &>/dev/null"
          "sudo pip install MarkupSafe==2.0.1 --no-dependencies --upgrade --force-reinstall &>/dev/null"
          "sudo pip install pycparser==2.21 --no-dependencies --upgrade --force-reinstall &>/dev/null"
          "sudo pip install PyJWT==1.6.4 --no-dependencies --upgrade --force-reinstall &>/dev/null"
          "sudo pip install python-engineio==4.2.1 --no-dependencies --upgrade --force-reinstall &>/dev/null"
          "sudo pip install python-socketio==5.4.0 --no-dependencies --upgrade --force-reinstall &>/dev/null"
          "sudo pip install requests==2.27.1 --no-dependencies --upgrade --force-reinstall &>/dev/null"
          "sudo pip install urllib3==1.26.9 --no-dependencies --upgrade --force-reinstall &>/dev/null"
          "sudo pip install waitress==2.1.2 --no-dependencies --upgrade --force-reinstall &>/dev/null"
          "sudo pip install Werkzeug==1.0.1 --no-dependencies --upgrade --force-reinstall &>/dev/null"
          "sudo pip install zipp==3.8.0 --no-dependencies --upgrade --force-reinstall &>/dev/null"

          ...
         )

n=${#commands[@]}
i=0
while [ "$i" -lt "$n" ]; do
    pct=$(( i * 100 / n ))
    echo XXX
    echo $i
    echo "${msgs[i]}"
    echo XXX
    echo "$pct"
    eval "${commands[i]}"
    i=$((i + 1))
done | whiptail --title "Reinstallation of dependencies..." --gauge "We are almost there be patient..." 10 60 0
whiptail --msgbox --title "Successfully re-installed" "Dependencies successfully re-installed" 15 50

Troubleshooting

}

# === SCRIPT ===

# Force User to use sudo 
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    whiptail --msgbox --title "Termsteel installer need sudo permission" "Please run Termsteel installer with sudo." 15 50
    exit 1
fi

# Force User to use bash => 3.
if [ -z ${BASH} ]; then
    whiptail --msgbox --title "Please run the script using the bash interpreter." "Termsteel installer need bash" 15 50
    exit 1
else
  bash_major_version=${BASH_VERSION:0:1}
  if [ ${bash_major_version} -lt 3 ]; then
    echo "Please run the script using bash version 3 or greater"
    exit 1
  fi
fi

echo """

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

"""

sleep 1
Menu
