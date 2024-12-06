#!/bin/bash

source /home/jdherranz/git/TFG/scripts/vars.env

# Ruta al archivo de inventario
archivo="/home/jdherranz/git/TFG/inventario.ini"
NEW_IP=$(nmap -sn 192.168.10.0/24 | grep $NEW_NAME | awk -F'[()]' '{print $2}')

# Verificar si [master] ya existe en el archivo
if grep -q "\[master\]" "$archivo"; then
    echo "[master] ya existe en el archivo, agregando nueva cadena debajo."
    # Añadir la nueva cadena debajo de [master]
    # Usamos sed para encontrar la línea que contiene [master] y agregar una línea después de esa
    sed -i "/\[master\]/a $NEW_NAME ansible_host=$NEW_IP ansible_user=ubuntu" "$archivo"
else
    echo "[master] no existe, creándolo."
    # Añadir [master] al final del archivo si no existe
    echo "[master]" >> "$archivo"
    # Agregar la cadena debajo de [master]
    echo "$NEW_NAME ansible_host=$NEW_IP ansible_user=ubuntu" >> "$archivo"
fi

