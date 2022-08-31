# Helpful Bash Aliases

This script was made for Linux Mint 20. If you use it on another distro you will likely need to change some of the code slightly.

## Usage

Add the following two lines to the `.bashrc` or `.bash_aliases` file found in your home directory:
```
export BASH_EXTENSIONS_HOME=[path_to_this_repo]
source $BASH_EXTENSIONS_HOME/bash_extensions.sh
```
## Commands

Currently available commands:
- mkdoc [document_name] - makes a Libre Office document.
- mkdiagram [diagram_name] - makes a Drawio diagram.
- open [file_name] - opens a filename based on its extension. If `.` is supplied, it will open the file explorer in the current directory.
