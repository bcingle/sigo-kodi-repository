#!/bin/sh

PACKAGE=xbmc.repo.sigo

zip="$PWD/dist/$PACKAGE.zip"

python ./generator.py

if [[ -f "$zip" ]]
then
    echo "Zip file already exists, deleting it..."
    rm -f "$zip"
fi

zip -r "$zip" "$PACKAGE"/addon.xml "$PACKAGE"/icon.png "$PACKAGE"/fanart.jpg

