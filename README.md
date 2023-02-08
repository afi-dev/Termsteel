# Termsteel


<p align="center"><img src="https://raw.githubusercontent.com/afi-dev/Termsteel/main/.github/assets/termsteel_logo.png" style="max-width: 100%;"></p>

<p align="center">⚠️ This project is currently not maintained, it's just a demonstration project</h1>
<br>
<p align="center"><b>🙃 Termsteel is a 🇫🇷 French project. </b></p>

<p align="center"><strong>Termsteel is a versatile and sleek web terminal built in python and accessible from a web browser to interact without complexity with the terminal on your machine inspired on <a href="https://github.com/cs01/pyxtermjs">Pyxtermjs</a>.</strong></p>

<p align="center"><a href="https://github.com/afi-dev/Termsteel/blob/main/OS_SUPPORT.md"><img src="https://i.imgur.com/XBceujJ.png" style="max-width: 100%;"></a></p>

![termsteel_banner.png](https://raw.githubusercontent.com/afi-dev/Termsteel/main/.github/assets/termsteel_banner.png)

- **Easy-to-install**: Install Termsteel quickly and easily with no hassle
- **Lightweight**: Works seamlessly with minimal hardware and software requirements.
- **Design**: a beautiful and responsive web interface to view and interact with your machine's terminal.
- **Scalable**: able to handle a lot of data and supports many linux console applications
- **Free**: open source software that makes it easy to access your machine.

![termsteel_cards.png](https://raw.githubusercontent.com/afi-dev/Termsteel/main/.github/assets/termsteel_cards.png)

### Trailer : 

https://user-images.githubusercontent.com/44731817/174507182-ecfb696f-7dfd-4303-aa69-247e97e89afe.mp4

### Demo : 

https://user-images.githubusercontent.com/44731817/179745407-9f9eedb1-ee34-42ab-ae93-3e33d8fca16b.mp4

-----

## Pre-installation Note

- Termsteel only works on MacOS, Windows (Only with WSL & WSL2), or some Linux distributions that support the [pty](https://docs.python.org/3/library/pty.html) (pseudo-terminal manipulation tools), [termios](https://docs.python.org/3/library/termios.html) and [fcntl](http://manpages.ubuntu.com/manpages/bionic/man2/fcntl.2.html) will be able to run Termsteel. For more details see the [list of supported OS/Distributions](https://github.com/afi-dev/Termsteel/blob/main/OS_SUPPORT.md).

- Termsteel requires a minimum of **`1GB`** of RAM to function properly.

- You will need python `3.0` or `higher` with `pip`

- To know how to install Termsteel in detail or on specific platform please refer to this [documentation page](https://github.com/afi-dev/Termsteel/wiki/Install-Termsteel)

- Termsteel not work Windows Platform please install Termsteel on WSL if you want to install it on Windows

- Do not use Termsteel as a public access environment to your machine, Termsteel is only a proof of concept and does not guarantee maximum security without a ssl certificate on a production environment

## Easy install 

To start using and installing Termsteel type the command:

```
pip install termsteel
```
See the [Pipy](https://pypi.org/project/termsteel/) page for more details

## Alternative Install Methods (Highly recommend)

### Method 1: Curl the installer script

If you are using **Linux** or **Windows via WSL** use this command :
```
curl -sSL https://raw.githubusercontent.com/afi-dev/Termsteel/main/installer.sh | sudo bash
```

If you are using **MacOS** use this command :
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/afi-dev/Termsteel/main/mac_installer.sh)"
```

### Method 2: Manually download the installer script and run

If you are using **Linux** or **Windows via WSL** use this command :
```
wget https://raw.githubusercontent.com/afi-dev/Termsteel/main/installer.sh | sudo bash installer.sh
```

If you are using **MacOS** use this command :
```
curl -o mac_installer.sh https://raw.githubusercontent.com/afi-dev/Termsteel/main/mac_installer.sh && bash mac_installer.sh
```

## Install for Developpement
If you just want to install the development version repo and run Termsteel:

```
git clone https://github.com/afi-dev/Termsteel.git
cd Termsteel && pip install -r requirements.txt && cd src && cd termsteel && python3 app.py
```

## Run termsteel

If you installed from pip or from the install script use this :
```
termsteel
```

### Optional arguments you can use
```
termsteel [-h] [-p PORT] [--host HOST] [--debug] [--version] [-r]
                        [--command COMMAND] [--cmd-args CMD_ARGS]

optional arguments:
  -h, --help            show this help message and exit
  -p PORT, --port PORT  port to run server on (default: 5000)
  --host HOST           host to run server on (it is highly recommended to use the ip of your machine from your local
                        network) (default: 192.168.1.190)
  --debug               debug the server (default: False)
  --version             print version and exit (default: False)
  -r, --reset           reset Termsteel to default password (default: False)
  -c COMMAND, --command COMMAND
                        Command to run in the terminal, i.e: htop (default: bash)
  --cmd-args CMD_ARGS   arguments to pass to command (i.e. --cmd-args='arg1 arg2 --flag') (default: )
  
```

## Default credentials

<p align="center"><img src="https://i.imgur.com/zs3tXc2.png" style="max-width: 100%;"></p>

The default login credentials for accessing the dashbaord are:

- username : **`Admin`**

- password : **`Termsteel`**

You can change them directly from the `web dashboard` in `setting` from the `password tab`

***⚠️ Please remember not to leave these credentials as default and change your password to a secure password containing upper case, lower case, special characters and numbers.***

## Lost login credentials

If you have lost your login credentials you can still reset Termsteel to the default credentials, to do this you can reset Termsteel directly by typing the following command : 

```
termsteel --reset
``` 

Or you have to modify [`config.json`](https://github.com/afi-dev/Termsteel/blob/main/src/termsteel/config.json) and set `"reset"` to `true` then restart Termsteel.

## Contributing

I invite you to participate, to contribute to projects by suggesting new features, creating pull requests or issues.

If you have something to add, whether it's a typo or a brand new feature, I'm glad to consider it! Please be sure to follow our [code of conduct](https://github.com/afi-dev/Termsteel/blob/main/CODE_OF_CONDUCT.md) and state your sentences clearly so that they are understandable to everyone when you submit your request.

## Support this project

Termsteel is completely free and open-source, so feel free to participate in its creation. By the way, you can support my work by supporting me by [making a donation](https://ko-fi.com/afidev), it's always a pleasure and it motivates me to make more beautiful projects. 

## License & Conditions

- [MIT](https://github.com/afi-dev/Termsteel/blob/main/LICENSE)

- [EULA](https://github.com/afi-dev/Termsteel/blob/main/EULA)

## Useful link

- [Documentation](https://github.com/afi-dev/Termsteel/wiki)

- [Credits](https://github.com/afi-dev/Termsteel/blob/main/CREDITS.md)
