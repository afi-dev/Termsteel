function Menu() {
echo "sss"
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

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Termsteel installer need sudo permission"
    exit 1
fi

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

type -P brewi >/dev/null 2>&1 && Brew_Installed=yes
if [[ "$Brew_Installed" == 'yes' ]]; then
    Menu
else
    osascript <<'END'
    display dialog "Termsteel detects that Brew is not installed on your machine, but this is necessary in the installation of termsteel. Please install Brew before launching Termsteel install"
END
fi
