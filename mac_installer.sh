function Menu() {

newName=$(osascript -e "text returned of (display dialog \"Enter Computer Name\" default answer \"$computerName\")")
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

if [[ $EUID -ne 0 ]]; then
    osascript >/dev/null <<'END'
    display dialog "Please do not run this installer script with sudo" with icon stop
END
   exit 1
fi

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
exit 1
fi

