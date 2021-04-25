#!/bin/bash

# TODO
# create "menu"
# 1. validate that FILENAME param are valid (ex: ignore names starting with '-','.'... or contains '/','\'... etc)
# 2. analize all parameters beforehand
# 3. add dir parameter as an option for where to create the scripts
# 4. make the "menu" loop to search for the -h parameter in any place of the param list without losing all the other values

function displayHelp(){
    echo "creates N° of script files with the initial lines mandatory initial lines added and proper permissions granted to the file"
    echo "Usage: mkscript.sh FILENAME..."
    echo "       mkscript.sh -h"
}

while (( "$#" )); do
    case $1 in
        -h|--help) displayHelp; exit;;
        *) break;;
    esac
done

function createBashScript () {
    FILE=$1
    touch /home/${USER}/bin/${FILE}
    chmod 750 /home/${USER}/bin/${FILE}
    echo "#!/bin/bash" >> /home/${USER}/bin/${FILE}
}

function checkFileExtension () {
    case $1 in
        *.sh) createBashScript $1;;
        *) echo "missing extension in file ${1}, assuming bash type"; createBashScript $1;;
    esac
}

function validateFileName () {
    FILE=$1
    if [[ $FILE =~ ['!@#$%^&*()_+'] || $FILE == -* ]]; then
        echo "name $FILE is invalid"
        return 1
    else
        return 0
    fi
}

while (( "$#" )); do
    FILE=$1 # get the name for the file
    shift # shift to the next value for the next file if any

    #if fc validateFileName returns 1 FileName is invalid
    validateFileName ${FILE}
    if [[ $? == 0 ]]; then
        # check if a script/command exists with the same name, if it doesnt it creates the file, changes permissions and inserts the first line for the script 
        if [[ ! ( (-e /home/${USER}/bin/${FILE}) || (-e /bin/${FILE}) || (-e /sbin/${FILE}) || (-e /usr/bin/${FILE}) ) ]]; then
            checkFileExtension $FILE
        else
            echo "a file named ${FILE} already exists"
        fi
    fi
done