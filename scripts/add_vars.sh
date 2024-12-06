#!/bin/bash

# Nombre del archivo
FILE="/home/jdherranz/git/TFG/scripts/vars.env"

# Línea a buscar
LINE_TO_REMOVE="NEW_NAME="

# Verificar si la línea existe en el archivo
if grep -E "$LINE_TO_REMOVE" "$FILE"; then
   grep -vE "$LINE_TO_REMOVE" "$FILE" > temp_file && mv temp_file "$FILE"
else
   echo "La línea '$LINE_TO_REMOVE' no existe. No se hará nada."
fi
