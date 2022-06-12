function Check_brew() {

type -P brew >/dev/null 2>&1 && Brew_Installed=yes
if [[ "$Brew_Installed" == 'yes' ]]; then
    Menu
else
    osascript >/dev/null <<'END'
    display dialog "Termsteel to notice that brew is not installed on your machine, please install brew before launching Termsteel Installer" with icon stop
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

echo "Selected: $MenuItems"

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

Mit_Licensing=$(curl https://raw.githubusercontent.com/afi-dev/Termsteel/main/LICENSE
osascript -e 'display alert "LICENSE AGREEMENTS" message "'"${Mit_Licensing//\"/}"'"'

}

function Eula() {

Eula_Agreements=$(curl https://raw.githubusercontent.com/afi-dev/Termsteel/main/EULA
osascript -e 'display alert "LICENSE AGREEMENTS" message "'"${Eula_Agreements//\"/}"'"'

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
    display dialog "Please run this install script using the bash interpreter." with icon stop
END
else
  bash_major_version=${BASH_VERSION:0:1}
  if [ ${bash_major_version} -lt 3 ]; then
    osascript >/dev/null <<'END'
    display dialog "Please run this install script with a newer version of bash" with icon stop
END
    echo "Error | Termsteel ended with a error because the script was not run with bash or the bash version used is too old"
    exit 1
  fi
fi

if [ $(id -u) = 0 ]; then
    osascript >/dev/null <<'END'
    display dialog "Please do not run this installer script with sudo" with icon stop
END
   echo "Error | Termsteel ended with a error because the installer script was launched with administrator rights from sudo"
   exit 1
else
    Check_brew
fi
