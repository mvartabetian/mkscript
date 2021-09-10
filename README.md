# mkscript
Init sript files such as .sh with mandatory first lines and sets proper merimitions.

It determines the type of the file according to the extention. No extention is considered as a bash file.

As of now only bash files are supported.

Usage:
mkscript.sh FILENAME...

example:
"mkscript.sh foo.sh" creates a file with "#!/bin/bash" added and the permissions of the file set as 750.
