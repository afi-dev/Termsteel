# /*!
#  * Termsteel V.0.0.1
#  * (c) 2022 Afi
#  * Released under the CC BY-NC-SA 3.0 Attribution-NonCommercial-ShareAlike 3.0 License.
#  */

print("""

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

""")

import sys

if sys.version_info < (3, 6, 0):
    print("Python 3.6+ is required to install Termsteel")
    exit(1)
import io # noqa E402
import os # noqa E402
from setuptools import setup, find_packages # noqa E402
import pathlib # noqa E402
import distutils.text_file # noqa E402

here = pathlib.Path(__file__).parent.resolve()

long_description = (here / "README.md").read_text(encoding="utf-8")

setup(
    name="termsteel",
    version="0.0.1post",
    description="Termsteel is a versatile and sleek web terminal built in python and accessible from a web browser to interact without complexity with the terminal on your machine inspired on Pyxtermjs.",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/afi-dev/Termsteel",
    author="Afi",
    author_email="aconique@gmail.com",
    classifiers=[
        "Operating System :: OS Independent",
        "License :: OSI Approved :: MIT License",
        "Development Status :: 5 - Production/Stable",
        "Intended Audience :: End Users/Desktop",
        "Topic :: Desktop Environment",
        "Environment :: Web Environment",
        "Framework :: Flask",
        "Natural Language :: French",
        "Natural Language :: German",
        "Natural Language :: Spanish",
        "Natural Language :: English",
        "Programming Language :: JavaScript",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.6",
        "Programming Language :: Python :: 3.7",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
        "Programming Language :: Python :: 3 :: Only",
    ],
    keywords="terminal terminal-emulators console browser pty theme termsteel xtermjs flask jwt argon2 alpinejs tailwindcss",
    package_dir={"": "src"},
    packages=find_packages(where="src"),
    include_package_data=True,
    package_data={'': ['*','templates/*','static/assets/banner/*','static/assets/*','static/css/*','static/fonts/*','static/js/*','static/js/xterm-addons/*','static/wallpapers/*','config.json']},
    scripts=[],
    entry_points={"console_scripts": ["termsteel = termsteel.app:main"]},
    extras_require={},
    zip_safe=False,
    python_requires=">=3.6",
    install_requires=distutils.text_file.TextFile(
        filename="./requirements.txt"
    ).readlines(),
    project_urls={
        "Bug Reports": "https://github.com/afi-dev/Termsteel/issues/new?assignees=&labels=&template=bug_report.md&title=",
        "Feature request": "https://github.com/afi-dev/Termsteel/issues/new?assignees=&labels=&template=feature_request.md&title=",
        "Ko-fi": "https://ko-fi.com/afidev",
        "Buy me a coffee": "https://www.buymeacoffee.com/afidev",
        "Documentation": "https://github.com/afi-dev/Termsteel/wiki",
        "Source": "https://github.com/afi-dev/Termsteel",
        "Changelog": "https://github.com/afi-dev/Termsteel/blob/main/CHANGELOG.md",
    },
)

