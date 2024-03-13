function unit_test () {
    ###
	### Runs a unit test with any generic condition $1 and with any id $2
    ### A sleep of time $3 occurs before a process cleanup attempt
	###
	### Usage: unit_test [condition] [id] [time]
	###
    if $1 ; then
        pid=$!
        tput setaf 2
        echo "PASS:"
    else
        pid=$!
        tput setaf 1
        echo "FAIL:"
    fi
    tput sgr0
    echo "    $2"
    sleep $3
    kill "$pid"
}

# setup
dir="unit_test_$(date "+%Y%m%d_%H%M%S")"
echo $dir
mkdir $dir
cd $dir

source ../bash_extensions.sh

# mkdoc
mkdoc test
unit_test "$(diff -q "test.odt" "../DefaultDocument.odt")" "doc0" 1
rm test.odt
mkdoc test.odt
unit_test "$(diff -q "test.odt" "../DefaultDocument.odt")" "doc1" 1
rm test.odt

# mkdiagram
mkdiagram test
unit_test "$(diff -q "test.drawio.png" "../DefaultDiagram.drawio.png")" "diagram0" 3
mkdiagram test.drawio.png
unit_test "$(diff -q "test.drawio.png" "../DefaultDiagram.drawio.png")" "diagram1" 3

# open


# cleanup
cd ..
rm -rf $dir