#!/bin/bash
# (c) by Robertas Smuilys 2021
#
## Variables
ssh_params="-o StrictHostKeyChecking=no"

## main script
if [ ! $1 ] && [ ! $2 ] && [ ! $3 ];
then
  echo " !!! You haven't specified destination IP and privileged user name. Usage:
       - ./deploy.sh [ip address] [username] [password]"
else

#for debbuging porpouses
echo "ip: "$1
echo "user: "$2
echo "password: "$3

sshpass -p $3 scp -p $ssh_params ./init/init.sh $2@$1:/tmp/init.sh
sshpass -p $3 scp -p $ssh_params ~/.ssh/id_rsa.pub $2@$1:~/authorized_keys
sshpass -p $3 ssh $ssh_params $2@$1 'echo '$3' | sudo -S bash /tmp/init.sh '$2
cd ansible
ansible-playbook -e strategy=linear --ssh-extra-args='-o StrictHostKeyChecking=no' -i inventories/dev playbooks/deploy.yml -i $1,

fi
