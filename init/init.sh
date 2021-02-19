sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install net-tools software-properties-common python  -y -qq
sudo useradd -m -p saJh0hpGCrPhw -b /home -s /bin/bash prov
if ! $(sudo grep $1 /etc/sudoers);
then
     echo $1'    ALL=(ALL) NOPASSWD: ALL' | sudo EDITOR='tee -a' visudo
fi
if ! $(sudo grep prov /etc/sudoers);
then
     echo 'prov    ALL=(ALL) NOPASSWD: ALL' | sudo EDITOR='tee -a' visudo
fi
sudo mkdir -p /home/prov/.ssh
sudo mv ~/authorized_keys /home/prov/.ssh/
sudo chown -R prov:prov /home/prov
sudo chmod 0600 /home/prov/.ssh/authorized_keys
