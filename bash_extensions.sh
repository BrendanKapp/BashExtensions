#!/bin/bash

###
### A set of helpful commands to extend bash. See README for details.
###

function mkdoc () {
	###
	### Creates a blank .odt document in the current folder
	###
	### Usage: mkdoc [document_name]
	###
	local filename="$1"
	_check_filename_validity $filename
	if [[ $? == 1 ]]; then
		# Returns if filename is invalid
		return
	fi
	if [[ $filename != *".odt" ]]; then
		# Appends .odt to filename if it wasn't supplied
		filename="$1.odt"
	fi
	if test -f $filename; then
		echo "ERROR: File of the same name already exists!"
		return
	fi
	cp $BASH_EXTENSIONS_HOME/DefaultDocument.odt $filename
	open $filename
}
function mkdiagram () {
	###
	### Creates a blank .drawio diagram in the current folder
	###
	### Usage: mkdiagram [diagram_name]
	###
	local filename="$1"
	_check_filename_validity $filename
	if [[ $? == 1 ]]; then
		# Returns if filename is invalid
		return
	fi
	if [[ $filename != *".drawio" ]]; then
		# Appends .png to the filename if it wasn't supplied
		filename="$1.drawio.png"
	fi
	if [[ $filename != *".drawio.png" ]]; then
		# Appends .drawio.png to the filename if it wasn't supplied
		filename="$1.drawio.png"
	fi
	if test -f $filename; then
		echo "ERROR: File of the same name already exists!"
		return
	fi
	cp $BASH_EXTENSIONS_HOME/DefaultDiagram.drawio.png $filename
	open $filename
}
function open () {
	###
	### Opens files based on extension from the terminal.
	###
	### Usage: open [file_name]
	###
	if [[ $1 == *".odt" ]]; then
		libreoffice $1 &
	elif [[ $1 == *".html" ]]; then
		firefox $1 & &> /dev/null
	elif [[ $1 == "." ]] || [[ $1 == "" ]]; then
		# if you use "open ." it will open the file explorer at the current location
		nemo . & &> /dev/null
	elif [[ $1 == *".drawio" ]]; then
		drawio $1 & &> /dev/null
	elif [[ $1 == *".drawio.png" ]]; then
		drawio $1 & &> /dev/null
	else
		echo "ERROR: Unknown file extension: $1"
	fi
}
function catd () {
	###
	### Performs cat command on an odt document.
	###
	### Usage: catd [file_name]
	###
	if [[ $1 != *".odt" ]]; then
		echo "ERROR: catd only works on .odt documents."
		return
	fi
	unoconv --format=txt $1
	odt=$1
	txt=${odt::-4}
	cat "$txt.txt"
	rm "$txt.txt"
}
function _check_filename_validity () {
	###
	### Local function to check filename naming convention validity.
	###
	### Returns:
	### 0 on success.
	### 1 on failure and prints an error message.
	###
	### Usage: _check_filename_validity [file_name]
	###
	local key=$1
	local val=$(echo "${#key}")

	if [[ $key == "" ]]; then
		echo "ERROR: Filename cannot be blank!"
		return 1
	fi

	if [[ $key == "." ]] || [[ $key == ".." ]]; then
		# "." and ".." are added automatically and always exist, so you can't have a
		# file named . or .. // https://askubuntu.com/a/416508/660555
		echo "ERROR: Filename cannot be . or .."
		return 1
	fi

	if [ $val -gt 255 ]; then
		# String's length check
		echo "ERROR:  Filename must be less than 255 characters!"
		return 1
	fi

	if ! [[ $key =~ ^[0-9a-zA-Z._-]+$ ]]; then
		# Checks whether valid characters exist
		echo "ERROR: filename must be valid characters (0-9 a-z A-Z . _ -)"
		return 1
	fi

	local cut_key=$(echo $key | cut -c1-1)
	if ! [[ $cut_key =~ ^[0-9a-zA-Z.]+$ ]]; then
		# Checks the first character
		echo "ERROR: first character of filename cannot be '_' or '-'!"
		return 1
	fi
	return 0
}