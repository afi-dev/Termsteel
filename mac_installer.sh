#!/bin/sh

# /*!
#  * Termsteel Installer V0.4BETA
#  * (c) 2022 Afi
#  * Released under the MIT License.
#  */

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

TroubleshootingItems=$(osascript 2>&1 <<End
    set tlist to {"Uninstall Termsteel", "Update Termsteel", "Reinstall all Termsteel dependencies", "Back"}
    set titem to choose from list tlist with prompt "Termsteel Installer V0.4Beta" default items {"Install Termsteel"}
    titem
End
)

if [[ "$TroubleshootingItems" == 'Uninstall Termsteel' ]]; then
    Uninstall_Termsteel
elif [[ "$TroubleshootingItems" == 'Update Termsteel' ]]; then
    osascript -e 'display dialog "This feature is not available in this version of Termsteel installer" with icon stop'
    Troubleshooting
elif [[ "$TroubleshootingItems" == 'Reinstall all Termsteel dependencies' ]]; then
    Reinstall_Termsteel_Deeps
elif [[ "$TroubleshootingItems" == 'Back' ]]; then
    Menu
else
    Menu
fi

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

    msgs=("Preparing Install..."
        ""
        "Update brew"
        "Installing Python"
        "Download Pip Installer"
        "Installing Pip"
        "Remove Pip Installer"
        "Installing Fastjar"
        "Installing Wget"
        "Installing argon2-cffi==21.3.0"
        "Installing argon2-cffi-bindings==21.2.0"
        "Installing bidict==0.22.0"
        "Installing certifi==2022.5.18.1"
        "Installing cffi==1.15.0"
        "Installing charset-normalizer==2.0.12"
        "Installing click==7.1.2"
        "Installing Flask==1.0.2"
        "Installing Flask-Argon2==0.2.0.0"
        "Installing flask-jwt-login==0.0.5"
        "Installing Flask-SocketIO==5.2.0"
        "Installing idna==3.3"
        "Installing importlib-metadata==4.11.4"
        "Installing itsdangerous==1.1.0"
        "Installing Jinja2==2.11.3"
        "Installing markup==0.2"
        "Installing MarkupSafe==2.0.1"
        "Installing pycparser==2.21"
        "Installing PyJWT==1.6.4"
        "Installing python-engineio==4.2.1"
        "Installing python-socketio==5.4.0"
        "Installing requests==2.27.1"
        "Installing urllib3==1.26.9"
        "Installing waitress==2.1.2"
        "Installing Werkzeug==1.0.1"
        "Installing zipp==3.8.0"
        "Access to /var/tmp"
        "Download termsteel_v0.0.1.tar.gz"
        "Extract termsteel_v0.0.1.tar.gz"
        "Access termsteel_v0.0.1/"
        "Install Termsteel"
        "Starting Add $USER permissions to site-packages on termsteel"
        "Starting Add $USER permissions to site-packages on termsteel"
        "Starting Setup FLASK_APP on termsteel"
        "Starting Setup FLASK_ENV on termsteel"
        "Access var/tmp/"
        "Remove termsteel_v0.0.1/"
        "Remove termsteel_v0.0.1.tar.gz"
        "Uninstall Termsteel from pip"
        "Reinstall Termsteel from pip"
        "Finish with verification of the installation"
        )
    commands=("sleep 0.5"
	        "osascript -e 'display alert \"WARN\" message \"Check your terminal sometimes for sudo permissions, you may probably be asked for them!\"'"
            "brew update &>/dev/null && echo '✅'"
            "brew install python &>/dev/null && echo '✅'"
            "sudo curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py &>/dev/null && echo '✅'"
            "sudo python3 get-pip.py &>/dev/null && echo '✅'"
            "sudo rm get-pip.py -f &>/dev/null && echo '✅'"
            "brew install fastjar &>/dev/null && echo '✅'"
            "brew install wget &>/dev/null && echo '✅'"
            "sudo pip install argon2-cffi==21.3.0 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install argon2-cffi-bindings==21.2.0 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install bidict==0.22.0 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install certifi==2022.5.18.1 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install cffi==1.15.0 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install charset-normalizer==2.0.12 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install click==7.1.2 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install Flask==1.0.2 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install Flask-Argon2==0.2.0.0 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install flask-jwt-login==0.0.5 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install Flask-SocketIO==5.2.0 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install idna==3.3 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install importlib-metadata==4.11.4 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install itsdangerous==1.1.0 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install Jinja2==2.11.3 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install markup==0.2 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install MarkupSafe==2.0.1 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install pycparser==2.21 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install PyJWT==1.6.4 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install python-engineio==4.2.1 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install python-socketio==5.4.0 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install requests==2.27.1 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install urllib3==1.26.9 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install waitress==2.1.2 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install Werkzeug==1.0.1 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install zipp==3.8.0 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo cd /var/tmp && echo '✅'"
            "sudo wget https://github.com/afi-dev/Termsteel/releases/download/v0.0.1/termsteel_v0.0.1.tar.gz &>/dev/null && echo '✅'"
            "sudo tar -xvf termsteel_v0.0.1.tar.gz &>/dev/null && echo '✅'"
            "sudo cd termsteel_v0.0.1 && echo '✅'"
            "sudo python3 setup.py install &>/dev/null && echo '✅'"
            "sudo chown -R $USER /usr/local/lib/python$python_ver/site-packages/ &>/dev/null && echo '✅'"
            "sudo chown -R $USER /usr/local/lib/python$python_ver/site-packages/ &>/dev/null && echo '✅'"
            "export FLASK_APP=termsteel &>/dev/null && echo '✅'"
            "export FLASK_ENV=development &>/dev/null && echo '✅'"
            "sudo cd /var/tmp && echo '✅'"
            "sudo rm -rf termsteel_v0.0.1 &>/dev/null && echo '✅'"
            "sudo rm -f termsteel_v0.0.1.tar.gz &>/dev/null && echo '✅'"
            "sudo pip uninstall -y termsteel &>/dev/null && echo '✅'"
            "sudo pip install termsteel &>/dev/null && echo '✅'"
            "echo '✅'"
            )

    n=${#commands[@]}
    i=0
    while [ "$i" -lt "$n" ]; do
        pct=$(( i * 100 / n ))
        echo "${msgs[i]}"
        eval "${commands[i]}"
        i=$((i + 1))
    done

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
    display notification "Termsteel installer has encountered a problem during installation" with title "Termsteel Installer V0.4Beta" subtitle "Instalation fail" sound name "Blow"
    display dialog "Termsteel installer encountered an error during the installation and did not correctly install termsteel, tried to restart an installation, if the problem persists send an issue on github." with icon stop buttons {"Ok"} default button "Ok"
End
    exit 1
fi

}

function All_done() {
osascript 2>&1 <<End
display notification "Termsteel installer has correctly installed Termsteel" with title "Termsteel Installer V0.4Beta" subtitle "Instalation succeed" sound name "Blow"
display dialog "Termsteel V0.0.1 has been successfully installed ! \n\nIf you encounter a problem do not hesitate to let me know by creating an issue on github. \n\nHave fun with Termsteel" with icon caution buttons {"Ok"} default button "Ok"
End
exit 1
}

function Uninstall_Termsteel() {

termsteel --version &>/dev/null
if [ $? -eq 0 ]; then

    Uninstall_Termsteel_Item=$(osascript 2>&1 <<End
    display dialog "Do you really want to uninstall termsteel?" buttons {"No","Yes"} with icon stop
End
    )

    if [[ "$Uninstall_Termsteel_Item" == 'button returned:Yes' ]]; then
        echo 'Uninstall all sites-packeges'
        sudo rm /usr/local/lib/python$python_ver/site-packages/* -rf &>/dev/null && echo '✅'
        echo 'Uninstall termsteel command'
        sudo rm /usr/local/bin/termsteel -f &>/dev/null && echo '✅'
        echo 'Uninstall termsteel'
        pip uninstall -y termsteel &>/dev/null && echo '✅'
        osascript -e "display notification \"Termsteel has just been uninstalled\" with title \"Termsteel Installer V0.4Beta\" subtitle \"Successful Uninstallation \" sound name \"Blow\""
        osascript -e "display dialog \"Termsteel V0.0.1 has been successfully uninstalled !\" with icon caution buttons {\"Ok\"} default button \"Ok\""
        exit 1
    elif [[ "$Uninstall_Termsteel_Item" == 'button returned:No' ]]; then
        Troubleshooting
    else
        Troubleshooting
    fi

else
    Uninstall_Termsteel_Install_Item=$(osascript 2>&1 <<End
    display alert "Termsteel not installed" message "Termsteel Installer noticed that you don't have Termsteel on this machine, do you want to install it?" buttons {"Not now","Yes"} with icon caution
End
    )

    if [[ "$Uninstall_Termsteel_Install_Item" == 'button returned:Yes' ]]; then
        MIT
    elif [[ "$Uninstall_Termsteel_Install_Item" == 'button returned:Not now' ]]; then
        Troubleshooting
    else
        Troubleshooting
    fi
fi

}

function Reinstall_Termsteel_Deeps() {

osascript 2>&1 <<End
    display notification "You will be notified once the re-installation of Termsteel dependencies is complete" with title "Termsteel Installer V0.4Beta" subtitle "Re-installation in progress" sound name "Blow"
End

    msgs=("Preparing Install..."
        "Installing argon2-cffi==21.3.0"
        "Installing argon2-cffi-bindings==21.2.0"
        "Installing bidict==0.22.0"
        "Installing certifi==2022.5.18.1"
        "Installing cffi==1.15.0"
        "Installing charset-normalizer==2.0.12"
        "Installing click==7.1.2"
        "Installing Flask==1.0.2"
        "Installing Flask-Argon2==0.2.0.0"
        "Installing flask-jwt-login==0.0.5"
        "Installing Flask-SocketIO==5.2.0"
        "Installing idna==3.3"
        "Installing importlib-metadata==4.11.4"
        "Installing itsdangerous==1.1.0"
        "Installing Jinja2==2.11.3"
        "Installing markup==0.2"
        "Installing MarkupSafe==2.0.1"
        "Installing pycparser==2.21"
        "Installing PyJWT==1.6.4"
        "Installing python-engineio==4.2.1"
        "Installing python-socketio==5.4.0"
        "Installing requests==2.27.1"
        "Installing urllib3==1.26.9"
        "Installing waitress==2.1.2"
        "Installing Werkzeug==1.0.1"
        "Installing zipp==3.8.0"
        "Finish"
        )
    commands=("sleep 0.5"
            "sudo pip install argon2-cffi==21.3.0 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install argon2-cffi-bindings==21.2.0 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install bidict==0.22.0 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install certifi==2022.5.18.1 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install cffi==1.15.0 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install charset-normalizer==2.0.12 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install click==7.1.2 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install Flask==1.0.2 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install Flask-Argon2==0.2.0.0 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install flask-jwt-login==0.0.5 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install Flask-SocketIO==5.2.0 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install idna==3.3 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install importlib-metadata==4.11.4 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install itsdangerous==1.1.0 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install Jinja2==2.11.3 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install markup==0.2 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install MarkupSafe==2.0.1 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install pycparser==2.21 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install PyJWT==1.6.4 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install python-engineio==4.2.1 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install python-socketio==5.4.0 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install requests==2.27.1 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install urllib3==1.26.9 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install waitress==2.1.2 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install Werkzeug==1.0.1 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "sudo pip install zipp==3.8.0 --no-dependencies --upgrade --force-reinstall &>/dev/null && echo '✅'"
            "echo '✅'"
            )

    n=${#commands[@]}
    i=0
    while [ "$i" -lt "$n" ]; do
        pct=$(( i * 100 / n ))
        echo "${msgs[i]}"
        eval "${commands[i]}"
        i=$((i + 1))
    done

osascript 2>&1 <<End
    display notification "The Termsteel dependencies have all been reinstalled" with title "Termsteel Installer V0.4Beta" subtitle "Re-installation successfull" sound name "Blow"
    display dialog "The Termsteel dependencies have all been reinstalled" buttons {"Ok"} default button "Ok" with icon caution
End
Troubleshooting

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
    unamestr=$(uname)
    if [[ "$unamestr" == 'Linux' ]]; then
        echo "Error | This installation script of termsteel is reserved to the user using macOS (Darwin), please use another installation script corresponding to your system"
        exit 1
    elif [[ "$unamestr" == 'FreeBSD' ]]; then
        echo "Error | This installation script of termsteel is reserved to the user using macOS (Darwin), please use another installation script corresponding to your system"
        exit 1
    elif [[ "$unamestr" == 'Darwin' ]]; then
        Check_brew
    else
        echo "Error | This installation script of termsteel is reserved to the user using macOS (Darwin), please use another installation script corresponding to your system"
        exit 1
    fi
fi
