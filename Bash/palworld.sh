# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

sudo apt update && sudo apt upgrade -y 
sudo apt install unzip apt-transport-https ca-certificates curl gnupg lsb-release -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg -y
sudo apt update

#install AWS CLI
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install

#create random string for password
VHPW=$(echo $RANDOM | md5sum | head -c 20)

#get stackname created by user data script and update SSM parameter name with this to make it unique
STACKNAME=$(</tmp/bagParamName.txt)
PARAMNAME=bagPalworldPW-$STACKNAME

#put random string into parameter store as encrypted string value
aws ssm put-parameter --name $PARAMNAME --value $VHPW --type "SecureString" --overwrite


#install docker and palworld app on docker
sudo apt install docker-ce docker-ce-cli containerd.io -y
sudo apt install docker-compose -y
sudo usermod -aG docker $USER
sudo mkdir /usr/games/serverconfig
cd /usr/games/serverconfig
sudo bash -c 'echo "version: \"3\"
services:
  palworld:
    image: mbround18/palworld-docker:latest
    ports:
      - 8211:8211 # Default game port
      - 27015:27015 # steam query port
    environment:
      PRESET: normal # Options: casual, normal, hard
      MULTITHREADING: true # Optional, Allows for multithreading the server.
      WORK_SPEED_RATE: 2.0 # default is 1.0
      PAL_EGG_DEFAULT_HATCHING_TIME: 1 # default is 24 hours
      BUILD_OBJECT_DETERIORATION_DAMAGE_RATE: 0.5 # default is 1.0
    volumes:
      - ./data:/home/steam/palworld" >> docker-compose.yml'
echo "@reboot root (cd /usr/games/serverconfig/ && docker-compose up)" > /etc/cron.d/awsgameserver
sudo docker-compose up
