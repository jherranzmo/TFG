#!/bin/bash

FILE="/home/jdherranz/git/TFG/scripts/vars.env"
LINE_TO_REMOVE="NEW_NAME="

if grep -E "$LINE_TO_REMOVE" "$FILE"; then
   grep -vE "$LINE_TO_REMOVE" "$FILE" > temp_file && mv temp_file "$FILE"
else
   echo "La línea '$LINE_TO_REMOVE' no existe."
fi
