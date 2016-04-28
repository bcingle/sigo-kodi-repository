#!/bin/sh

PACKAGE=repository.sigo

zip="$PWD/$PACKAGE.zip"


if [[ -f "$zip" ]]
then
    echo "Zip file already exists, deleting it..."
    rm -f "$zip"
fi

zip -v "$zip" "addon.xml"

