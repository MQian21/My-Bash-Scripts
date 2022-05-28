#!/bin/bash

# Check for incorrect number of command-line arguments
if [ ${#} -ne 2 ]; then
	echo "incorrect number of arguments" >&2
	exit 1
fi

# Check for permissions and if arguments are valid
FILE="${1}"
PROGRAM="${2}"

if [ ! -e $FILE ]; then
	 echo "File does not exist" >&2
	 exit 2
elif [ ! -r $FILE ]; then
	 echo "File is not readable" >&2
	 exit 3
fi


if [ ! -e $PROGRAM ]; then
	 echo "Program does not exist" >&2
	 exit 4
elif [ ! -x $PROGRAM ]; then
	 echo "Program is not executable" >&2
	 exit 5
fi


# Run program with the required .args files 
FAILED=false

for files in $(cat $FILE); do

	# Check if .args file exists but isn't readable
	if [ -e ${files}.args ] && [ ! -r ${files}.args ]; then
		FAILED=true
		echo "${files}.args is not readable" >&2
		continue
	fi 
	
	# Check if .out file is missing or unreadable
	if [ ! -e ${files}.out ] || [ ! -r ${files}.out ]; then
		echo "File ${files}.out does not exist or is not readable" >&2
		exit 6
	fi
	
	# Create temp file
	TMPFILE=$(mktemp)
	
	# Store output in temp file
	if [ ! -e ${files}.args ]; then
		$PROGRAM "" > $TMPFILE
	else
		$PROGRAM $(cat ${files}.args) > $TMPFILE
	fi

	# Print output if test case fail
	SAME=$(diff -s ${files}.out $TMPFILE)
	if [ ! $? -eq 0 ]; then
		echo "Test failed: ${files}"
		echo "Args:"
	        if [ -e ${files}.args ]; then	
			cat ${files}.args
		fi
		echo "Expected:"
		cat ${files}.out
		echo "Actual:"
		if [ -e ${files}.args ]; then
			cat $TMPFILE
		fi
	fi

	#remove temp file
	rm "$TMPFILE"

done

# Terminate script with a non-zero exit status if a .args file existed but wasn't readable
if [ "$FAILED" == "true" ]; then
	exit 7
fi
