function Check_brew() {

type -P brew >/dev/null 2>&1 && Brew_Installed=yes
if [[ "$Brew_Installed" == 'yes' ]]; then
    Menu
else
    osascript >/dev/null <<'END'
    display dialog "Termsteel to notice that brew is not installed on your machine, please install brew before launching Termsteel Installer" with icon stop buttons {"Ok"} default button "Ok"
END
echo "Error | Termsteel ended with a error because brew is not installed on system"
exit 1
fi

}

function Troubleshooting() {

echo "Troubleshooting"

}

function Menu() {

MenuItems=$(osascript 2>&1 <<End
    set tlist to {"Install Termsteel", "Troubleshooting", "Exit"}
    set titem to choose from list tlist with prompt "Termsteel Installer V0.4Beta" default items {"Install Termsteel"}
    titem
End
)

if [[ "$MenuItems" == 'Install Termsteel' ]]; then
    MIT
elif [[ "$MenuItems" == 'Troubleshooting' ]]; then
    Troubleshooting
elif [[ "$MenuItems" == 'Exit' ]]; then
    exit 1
else
    exit 1
fi

}

function MIT() {


MIT_Item=$(osascript 2>&1 <<End
   set LICENSE to do shell script "curl https://raw.githubusercontent.com/afi-dev/Termsteel/main/LICENSE"
   display alert "LICENSE AGREEMENTS" message LICENSE buttons {"Reject","Agree"} 
End
)

if [[ "$MIT_Item" == 'button returned:Agree' ]]; then
    Eula
elif [[ "$MIT_Item" == 'button returned:Reject' ]]; then
    Menu
else
    Menu
fi

}

function Eula() {


Eula_Item=$(osascript 2>&1 <<End
   set EULA to do shell script "curl https://raw.githubusercontent.com/afi-dev/Termsteel/main/EULA"
   display alert "EULA AGREEMENTS" message EULA buttons {"Reject","Agree"} 
End
)

if [[ "$Eula_Item" == 'button returned:Agree' ]]; then
    Install
elif [[ "$Eula_Item" == 'button returned:Reject' ]]; then
    Menu
else
    Menu
fi

}

function Install() {

python_ver="$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[0:2])))')"

osascript 2>&1 <<End
    display notification "You will be notified once the installation is complete" with title "Termsteel Installer V0.4Beta" subtitle "The installation has started" sound name "Blow"
End

curl https://raw.githubusercontent.com/naive-coders/loadbar/main/loadbar --output loader &>/dev/null

    msgs=(""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        )
    commands=("sleep 0.5"
            "brew update &>/dev/null"
            "brew install python &>/dev/null"
            "curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py &>/dev/null"
            "python3 get-pip.py &>/dev/null"
            "brew install fastjar &>/dev/null"
            "brew install wget &>/dev/null"
            "pip install argon2-cffi==21.3.0 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "pip install argon2-cffi-bindings==21.2.0 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "pip install bidict==0.22.0 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "pip install certifi==2022.5.18.1 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "pip install cffi==1.15.0 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "pip install charset-normalizer==2.0.12 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "pip install click==7.1.2 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "pip install Flask==1.0.2 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "pip install Flask-Argon2==0.2.0.0 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "pip install flask-jwt-login==0.0.5 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "pip install Flask-SocketIO==5.2.0 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "pip install idna==3.3 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "pip install importlib-metadata==4.11.4 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "pip install itsdangerous==1.1.0 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "pip install Jinja2==2.11.3 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "pip install markup==0.2 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "pip install MarkupSafe==2.0.1 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "pip install pycparser==2.21 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "pip install PyJWT==1.6.4 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "pip install python-engineio==4.2.1 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "pip install python-socketio==5.4.0 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "pip install requests==2.27.1 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "pip install urllib3==1.26.9 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "pip install waitress==2.1.2 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "pip install Werkzeug==1.0.1 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "pip install zipp==3.8.0 --no-dependencies --upgrade --force-reinstall &>/dev/null"
            "cd /var/tmp &>/dev/null"
            "wget https://github.com/afi-dev/Termsteel/releases/download/v0.0.1/termsteel_v0.0.1.tar.gz &>/dev/null"
            "tar -xvf termsteel_v0.0.1.tar.gz &>/dev/null"
            "cd termsteel_v0.0.1 &>/dev/null"
            "python3 setup.py install &>/dev/null"
            "chown -R $USER /usr/local/lib/python$python_ver/site-packages/"
            "chown -R $USER /usr/local/lib/python$python_ver/site-packages/"
            "export FLASK_APP=termsteel &>/dev/null"
            "export FLASK_ENV=development &>/dev/null"
            "cd var/tmp &>/dev/null"
            "rm -rf termsteel_v0.0.1"
            "rm -f termsteel_v0.0.1.tar.gz"
            )

    n=${#commands[@]}
    i=0
    while [ "$i" -lt "$n" ]; do
        pct=$(( i * 100 / n ))
        echo $i
        echo "${msgs[i]}"
        echo "$pct"
        eval "${commands[i]}"
        i=$((i + 1))
    done # | bash loader -p -t "Installing Termsteel V0.1"



Check_is_install

}

function Check_is_install() {

if command -v termsteel &> /dev/null; then
    termsteel --version &>/dev/null
    if [ $? -eq 0 ]; then
    All_done
    else
    osascript 2>&1 <<End
    display dialog "Termsteel installer encountered an error during the installation and did not correctly install termsteel, tried to restart an installation, if the problem persists send an issue on github." with icon stop buttons {"Ok"} default button "Ok"
End
    exit
    fi
else
    osascript 2>&1 <<End
    display dialog "Termsteel installer encountered an error during the installation and did not correctly install termsteel, tried to restart an installation, if the problem persists send an issue on github." with icon stop buttons {"Ok"} default button "Ok"
End
    exit 1
fi

}

function All_done() {
osascript 2>&1 <<End
display dialog "Termsteel V0.0.1 has been successfully installed ! \n\nIf you encounter a problem do not hesitate to let me know by creating an issue on github. \n\nHave fun with Termsteel" with icon caution buttons {"Ok"} default button "Ok"
End
exit 1
}


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

      Termsteel Installer V0.4BETA (DARWIN)

"""

if [ -z ${BASH} ]; then
    osascript >/dev/null <<'END'
    display dialog "Please run this install script using the bash interpreter." with icon stop buttons {"Ok"} default button "Ok"
END
else
  bash_major_version=${BASH_VERSION:0:1}
  if [ ${bash_major_version} -lt 3 ]; then
    osascript >/dev/null <<'END'
    display dialog "Please run this install script with a newer version of bash" with icon stop buttons {"Ok"} default button "Ok"
END
    echo "Error | Termsteel ended with a error because the script was not run with bash or the bash version used is too old"
    exit 1
  fi
fi

if [ $(id -u) = 0 ]; then
    osascript >/dev/null <<'END'
    display dialog "Please do not run this installer script with sudo" with icon stop buttons {"Ok"} default button "Ok"
END
   echo "Error | Termsteel ended with a error because the installer script was launched with administrator rights from sudo"
   exit 1
else
    Check_brew
fi
