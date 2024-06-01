temp_id=$(echo $RANDOM | md5sum | head -c 20)
zip_file_name="${temp_id}.zip"
echo $zip_file_name
mkdir $temp_id
cd $temp_id
wget -O $zip_file_name  https://hashicorp-releases.yandexcloud.net/packer/1.10.3/packer_1.10.3_linux_amd64.zip
sudo apt install unzip
unzip $zip_file_name
sudo apt remove unzip -y
sudo mv packer /usr/local/bin/
echo $temp_id
cd ~
rm -rf $temp_id
packer