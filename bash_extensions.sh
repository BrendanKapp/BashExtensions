function mkdoc () {
	###
	### Creates a blank .odt document in the current folder
	###
	### Usage: mkdoc [document_name]
	###
	local filename="$1"
	if [[ $filename != *".odt" ]]; then
		filename="$1.odt"
	fi
	touch $filename
	open $filename
}
function mkdiagram () {
	###
	### Creates a blank .drawio diagram in the current folder
	###
	### Usage: mkdiagram [diagram_name]
	###
	local filename="$1"
	if [[ $filename != *".drawio" ]]; then
		filename="$1.drawio"
	fi
	cp DefaultDiagram.drawio $filename
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
	elif [[ $1 == "." ]]; then
		# if you use "open ." it will open the file explorer at the current location
		nemo . & &> /dev/null
	elif [[ $1 == *".drawio" ]]; then
		drawio $1 & &> /dev/null
	else
		echo "Unknown file extension: $1"
	fi
}