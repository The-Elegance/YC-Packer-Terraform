wget https://hashicorp-releases.yandexcloud.net/packer/1.10.3/packer_1.10.3_linux_amd64.zip

sudo apt install unzip
unzip packer_1.10.3_linux_amd64.zip
rm packer_1.10.3_linux_amd64.zip
rm LICENSE.txt
sudo apt remove unzip -y

sudo mv ~/packer /usr/local/bin/

clear
echo "Packer installed."

packer