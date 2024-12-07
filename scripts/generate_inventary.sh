#!/bin/bash

source /home/jdherranz/git/TFG/scripts/vars.env

# Ruta al archivo de inventario
archivo="/home/jdherranz/git/TFG/inventario.ini"
NEW_IP=$(nmap -sn 192.168.10.0/24 | grep $NEW_NAME | awk -F'[()]' '{print $2}')

# Comprobar si NEW_NAME empieza con "master" o "worker"
if [[ $NEW_NAME == master* ]]; then
    # Si NEW_NAME empieza con "master"
    echo "Se está configurando un master."

    # Verificar si [master] ya existe en el archivo
    if grep -q "\[master\]" "$archivo"; then
        echo "[master] ya existe en el archivo, agregando nueva cadena debajo."
        # Añadir la nueva cadena debajo de [master]
        sed -i "/\[master\]/a $NEW_NAME ansible_host=$NEW_IP ansible_user=jdherranz" "$archivo"
    else
        echo "[master] no existe, creándolo."
        # Añadir [master] al final del archivo si no existe
        echo "[master]" >> "$archivo"
        # Agregar la cadena debajo de [master]
        echo "$NEW_NAME ansible_host=$NEW_IP ansible_user=jdherranz" >> "$archivo"
    fi

elif [[ $NEW_NAME == worker* ]]; then
    # Si NEW_NAME empieza con "worker"
    echo "Se está configurando un worker."

    # Verificar si [worker] ya existe en el archivo
    if grep -q "\[worker\]" "$archivo"; then
        echo "[worker] ya existe en el archivo, agregando nueva cadena debajo."
        # Añadir la nueva cadena debajo de [worker]
        sed -i "/\[worker\]/a $NEW_NAME ansible_host=$NEW_IP ansible_user=jdherranz" "$archivo"
    else
        echo "[worker] no existe, creándolo."
        # Añadir [worker] al final del archivo si no existe
        echo "[worker]" >> "$archivo"
        # Agregar la cadena debajo de [worker]
        echo "$NEW_NAME ansible_host=$NEW_IP ansible_user=jdherranz" >> "$archivo"
    fi

else
    echo "El nombre de la máquina no comienza ni con 'master' ni con 'worker'."
fi
