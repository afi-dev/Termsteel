# Termsteel

<!-- markdownlint-configure-file { "MD004": { "style": "consistent" } } -->
<!-- markdownlint-disable MD033 -->

<p align="center">
    <a href="#">
        <img href="https://raw.githubusercontent.com/afi-dev/Termsteel/main/.github/assets/termsteel_logo.png" alt="Termsteel">
    </a>
    <br>
    <strong>Termsteel is a versatile and sleek web terminal built in python and accessible from a web browser to interact without complexity with the terminal on your machine inspired on <a href="https://github.com/cs01/pyxtermjs">Pyxtermjs</a>.</strong>
</p>
<!-- markdownlint-enable MD033 -->

<img href="https://raw.githubusercontent.com/afi-dev/Termsteel/main/.github/assets/termsteel_banner.png">

- **Easy-to-install**: Install Termsteel quickly and easily with no hassle
- **Lightweight**: Works seamlessly with minimal hardware and software requirements.
- **Design**: a beautiful and responsive web interface to view and interact with your machine's terminal.
- **Scalable**: able to handle a lot of data and supports many linux console applications
- **Free**: open source software that makes it easy to access your machine.

<img href="https://raw.githubusercontent.com/afi-dev/Termsteel/main/.github/assets/termsteel_cards.png">

-----

## Pre-installation Note

- Termsteel only works on some one **Linux distributions** & **MacOS** for the moment. **Windows and some linux distributions** that do not support the [pty](https://docs.python.org/3/library/pty.html) (pseudo-terminal manipulation tools), [termios](https://docs.python.org/3/library/termios.html) and [fcntl](http://manpages.ubuntu.com/manpages/bionic/man2/fcntl.2.html) will not be able to run Termsteel.

- Termsteel requires a minimum of **`1GB`** of RAM to function properly.

- You will need python `3.0` or `higher`

## Easy install

To start using and installing Termsteel type the command:

```
pip install termsteel
```
## Alternative Install Methods

### Method 1: Curl the installer script (Recommanded)

```
curl -sSL https://raw.githubusercontent.com/afi-dev/Termsteel/main/install.sh | bash
```

### Method 2: Manually download the installer script and run

```
wget -O https://raw.githubusercontent.com/afi-dev/Termsteel/main/install.sh && sudo bash install.sh
```

## Run termsteel

If you installed from pip or from the install script use this :
```
termsteel
```

Or if you have installed manually from git you can run directly with :

```
cd Termsteel && pip install -r requirements.txt && cd termsteel && python3 app.py
```

### Optional arguments you can use
```
termsteel [-h] [-p PORT] [--host HOST] [--debug] [--version] [-r]
                        [--command COMMAND] [--cmd-args CMD_ARGS]
or

python3 app.py [-h] [-p PORT] [--host HOST] [--debug] [--version] [-r]
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

Or you have to modify [`config.json`](https://github.com/afi-dev/Termsteel/blob/main/termsteel/config.json) and set `"reset"` to `true` then restart Termsteel.

## Contributing

I invite you to participate, to contribute to projects by suggesting new features, creating pull requests or issues.

If you have something to add, whether it's a typo or a brand new feature, I'm glad to consider it! Please be sure to follow our [code of conduct](https://github.com/afi-dev/Termsteel/blob/main/termsteel/CODE_OF_CONDUCT.md) and state your sentences clearly so that they are understandable to everyone when you submit your request.

## Support this project

Termsteel is completely free and open-source, so feel free to participate in its creation. By the way, you can support my work by supporting me by [making a donation](https://ko-fi.com/afidev), it's always a pleasure and it motivates me to make more beautiful projects. 

## License & Conditions

- [Attribution-NonCommercial-ShareAlike 4.0 International](https://github.com/afi-dev/Termsteel/blob/main/termsteel/LICENSE.md)

- [EULA](https://github.com/afi-dev/Termsteel/blob/main/termsteel/EULA)

## Useful link

- [Documentation](https://github.com/afi-dev/Termsteel/wiki)

- [Credits](https://github.com/afi-dev/Termsteel/blob/main/termsteel/CREDITS.md)
