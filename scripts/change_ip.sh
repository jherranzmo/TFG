#!/bin/bash

source /home/jdherranz/git/TFG/scripts/vars.env

cat <<EOF > $OUTPUT_FILE
network:
  version: 2
  ethernets:
    enp0s3:
      dhcp4: false
      dhcp6: false
      addresses:
        - ${IP}/24
      gateway4: 192.168.10.1
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4
EOF

scp -o StrictHostKeyChecking=no -i /home/jdherranz/.ssh/id_rsa $OUTPUT_FILE ubuntu@$IP:/home/ubuntu

ssh -o StrictHostKeyChecking=no -i /home/jdherranz/.ssh/id_rsa ubuntu@$IP "sudo cp $OUTPUT_FILE /etc/netplan && sudo netplan apply"
ssh -o StrictHostKeyChecking=no -i /home/jdherranz/.ssh/id_rsa ubuntu@$IP "sudo sed -i 's/ubuntu-server1/$NEW_NAME/g' /etc/hostname"
