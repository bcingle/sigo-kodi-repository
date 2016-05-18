#!/bin/sh

if [[ -z "$1" ]]
then
	SRC_DIR="$PWD/src"
else
	SRC_DIR="$1"
fi

if [[ ! -d "$SRC_DIR" ]]
then
	echo "Source directory doesn't exist: $SRC_DIR"
	exit 1
fi
python generator.py
find "$SRC_DIR" -mindepth 1 -maxdepth 1 -type d -print0 | while read -d $'\0' PKG_DIR
do
	# ZIP filename needs version number
	VERSION_FILE="$PKG_DIR"/VERSION
	VERSION="$(cat "$VERSION_FILE")"
	PKG_NAME="$(basename "$PKG_DIR")"
	echo "Processing package $PKG_NAME"
	DIST_DIR="$SRC_DIR"/../dist/"$PKG_NAME"
	ZIP="$DIST_DIR"/"$PKG_NAME"-"$VERSION".zip
	
	if [[ ! -d "$DIST_DIR" ]]
	then
		echo "Creating directory $DIST_DIR"
		mkdir -p "$DIST_DIR"
	fi
	
	if [[ -f "$ZIP" ]]
	then
		echo "Package ZIP already exists: $PKG_NAME" >&2
		rm -f "$ZIP"
	fi
	cd "$PKG_DIR"/..
	ls
	zip -r "$ZIP" "$(basename "$PKG_DIR")" 
	cd "$OLDPWD"
	
	if [[ -f "$PKG_DIR"/icon.png ]]
	then
		cp "$PKG_DIR"/icon.png "$DIST_DIR"
	fi
	
	if [[ -f "$PKG_DIR"/fanart.jpg ]]
	then
		cp "$PKG_DIR"/fanart.jpg "$DIST_DIR"
	fi
	
	if [[ -f "$PKG_DIR"/addon.xml ]]
	then
            cp "$PKG_DIR"/addon.xml "$DIST_DIR"
	fi
done

