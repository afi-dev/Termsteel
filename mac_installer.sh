function Menu() {

computerName=$(scutil --get ComputerName)

newName=$(osascript >/dev/null <<End
    display dialog "Enter Computer Name" default answer "$computerName"
    return text returned of result
End
)

echo "New name: $newName"

}

function MIT() {
echo """

=============== LICENSING ================
"""

curl https://raw.githubusercontent.com/afi-dev/Termsteel/main/LICENSE


echo """

[!] To install termsteel you must absolutely accept this license. Wishing you to accept the agreements subscribed in the terms ?
"""


}

function Eula() {
echo """

============ EULA AGREEMENTS =============
"""

curl https://raw.githubusercontent.com/afi-dev/Termsteel/main/EULA

echo """

[!] To install termsteel you must absolutely accept these EULA agreements. Wishing you to accept the agreements subscribed in the terms ?
"""


}

function Troubleshooting() {

echo "ss"

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

if [ $(id -u) = 0 ]; then
    osascript >/dev/null <<'END'
    display dialog "Please do not run this installer script with sudo" with icon stop
END
   echo "Error | Termsteel ended with a error because the installer script was launched with administrator rights from sudo"
   exit 1
fi
