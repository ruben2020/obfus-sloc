#!/bin/bash

if [ "$1" == "--help" ] || [ "$1" == "-h" ]
then
echo
echo "$0 command_name [base_path]"
echo
echo "command_name is the command to run on C/C++ source and header files"
echo "base_path is the top level path to recurse from. Default = ."
echo
echo "Running with no arguments will print a list of"
echo "C/C++ source and header files recursively from ."
echo
exit 0

elif [ $# == 0 ]
then
find . -iregex ".*\.\(c\|h\|cpp\|hpp\|cxx\|hxx\)"
exit 0

elif [ $# == 1 ]
then
command1=$1
basepath1="."

elif [ $# == 2 ]
then
command1=$1
basepath1=$2

else
echo
echo "$0 --help"
echo "for help"
echo
exit 1

fi
 
type -P "$command1" &>/dev/null || { echo; echo "$command1 does not work, try \"$0 --help\" for help"; echo; exit 1; }

if [ ! -d "$basepath1" ]
then
echo
echo "$basepath1 is not readable as a directory"
echo
exit 1
fi

find $basepath1 -iregex ".*\.\(c\|h\|cpp\|hpp\|cxx\|hxx\)" | while read FN; do $command1 "$FN"; done

