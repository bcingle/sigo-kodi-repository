#!/bin/sh

if [[ -z "$1" ]]
then
	SRC_DIR="$PWD"
else
	SRC_DIR="$1"
fi

if [[ ! -d "$SRC_DIR" ]]
then
	echo "Source directory doesn't exist: $SRC_DIR"
	exit 1
fi

find "$SRC_DIR" -mindepth 1 -maxdepth 1 -type d -print0 | while read -d $'\0' PKG_DIR
do

	PKG_NAME="$(basename "$PKG_DIR")"
	echo "Processing package $PKG_NAME"
	ZIP="$SRC_DIR"/../dist/"$PKG_NAME".zip
	
	if [[ -f "$ZIP" ]]
	then
		echo "Package ZIP already exists: $PKG_NAME" >&2
		rm -f "$ZIP"
	fi

	zip -r "$ZIP" "$PKG_DIR" 

done
