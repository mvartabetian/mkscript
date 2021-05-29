#!/bin/bash

# TODO

#set initial variables
DIR=$(pwd) # unused

function displayHelp(){
    echo "creates N° of script files with the initial lines mandatory initial lines added and proper permissions granted to the file"
    echo "Usage: mkscript.sh FILENAME..."
    echo "       mkscript.sh -h"
    exit
}

while (( "$#" )); do
    case $1 in
        -h|--help) displayHelp; shift;;
        *) ARRAY+=("$1"); shift;;
    esac
done

function createBashScript () {
    FILE=$1
    touch ${FILE}
    chmod 750 ${FILE}
    echo "#!/bin/bash" >> ${FILE}
}

#changed name, see if it still works
function createScriptByExtention () {
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

for FILE in ${ARRAY[@]}; do
    validateFileName ${FILE}
    if [[ $? == 0 ]]; then
        # check if a script/command exists with the same name, if it doesnt it creates the file, changes permissions and inserts the first line for the script
        if [[ ! ( (-e /home/${USER}/bin/${FILE}) || (-e /bin/${FILE}) || (-e /sbin/${FILE}) || (-e /usr/bin/${FILE}) || (-e ./${FILE}) ) ]]; then
            createScriptByExtention $FILE
        else
            echo "a file named ${FILE} already exists"
        fi
    fi
done