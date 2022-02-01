#!/usr/bin/env bash

# Use single quotes instead of double quotes to make it work with special-character passwords
PASSWORD='coderslab'
HOSTNAME='student.edu'

echo
echo "Welcome to CodersLab!"
echo
echo "This script will update your operating system, install a few necessary programs"
echo "that you will need during the course, and configure PostgreSQL database."
echo "During this process, you will see many messages on your screen."
echo "FOR THE INSTALLATION TO BE SUCCESSFUL, YOU MUST HAVE INTERNET ACCESS"
echo "DURING THE INSTALLATION!"
read -n1 -r -p "Press any key to continue."

mkdir ~/.coderslab

# pausing updating grub as it might trigger ui
sudo apt-mark hold grub*
echo
echo " Updating system..."

# update / upgrade
sudo apt update
sudo apt -y upgrade
echo
echo "Installing system tools..."

# install all used tools
sudo apt install -y curl vim git virtualenv openjdk-8-jre-headless tlp tlp-rdw python3-pip
pip3 install --user pycodestyle termcolor
preload screen
sudo tlp start

echo
echo "Installing PostgreSQL..."
sudo apt install -y postgresql postgresql-contrib postgresql-client
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD '${PASSWORD}';"

echo
echo "Creating working directory..."
# creating and linking Workspace
sudo mkdir ~/workspace
sudo chmod 777 ~/workspace
sudo chmod 777 -R ~/workspace

# PyCharm
echo
echo "Installing PyCharm"
# # https://download.jetbrains.com/python/pycharm-professional-2017.2.3.tar.gz
# wget -O ~/.coderslab/pycharm-professional-2017.2.3.tar.gz https://download.jetbrains.com/python/pycharm-professional-2017.2.3.tar.gz
# sudo tar -zxvf ~/.coderslab/pycharm-professional-2017.2.3.tar.gz -C /opt/
# rm ~/.coderslab/pycharm-professional-2017.2.3.tar.gz
sudo snap install pycharm-professional --classic

echo
echo "Just to be certain -- Updating system again..."
# update and upgrade all packages
sudo apt update -y
sudo apt upgrade -y

DESKTOP=$(cat <<EOF
[Desktop Entry]
Name=PyCharm
Comment=IDE used during CodersLab course
Exec=/opt/pycharm-2017.2.3/bin/pycharm.sh
Icon=/opt/pycharm-2017.2.3/bin/pycharm.png
Terminal=false
Type=Application
StartupNotify=true
Categories=Utility;Application
EOF
)
touch ~/.coderslab/pycharm.desktop
echo "${DESKTOP}" > ~/.coderslab/pycharm.desktop
sudo cp ~/.coderslab/pycharm.desktop /usr/share/applications/pycharm.desktop
rm ~/.coderslab/pycharm.desktop


# unpausing updating grub
sudo apt-mark unhold grub*
