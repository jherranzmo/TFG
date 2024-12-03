#!/bin/bash

# Guardar la ip de la máquina que esté levantada:
IP=$(nmap -sn 192.168.10.0/24 | grep ubuntu-server1 | awk -F'[()]' '{print $2}')

OUTPUT_FILE="99-network-config.yaml"

cat <<EOF > $OUTPUT_FILE
network:
  version: 2
  ethernets:
    eth0:
      dhcp4: false
      dhcp6: false
      addresses:
        - ${IP}/24
      gateway4: 192.168.1.1
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4
EOF

scp -o StrictHostKeyChecking=no -i /home/jdherranz/.ssh/id_rsa $OUTPUT_FILE ubuntu@$IP:/home/ubuntu
