#!/usr/bin/env bash

# Use single quotes instead of double quotes to make it work with special-character passwords
PASSWORD='coderslab'
HOSTNAME='student.edu'

echo
echo "Welcome to CodersLab!"
echo
echo "This script will update your operating system, install a few necessary programs"
echo "that you will need during the course, and configure MySQL database."
echo "During this process, you will see many messages on your screen."
echo "FOR THE INSTALLATION TO BE SUCCESSFUL, YOU MUST HAVE INTERNET ACCESS"
echo "DURING THE INSTALLATION!"
read -n1 -r -p "Press any key to continue."

echo
echo "Installing console tools..."
# install Command Line Tools for Xcode
xcode-select --install


echo
echo "Installing homebrew..."
# install brew package manager
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo
echo "Adding necessary homebrew repositories..."
# add external taps
# brew tap homebrew/dupes #deprecated
# brew tap homebrew/versions #deprecated
brew tap homebrew/services
brew tap homebrew/cask-versions
echo
echo "Installing system tools..."

# install all used tools
brew tap caskroom/cask
# brew install caskroom/cask/brew-cask
# brew install homebrew/completions/brew-cask-completion #deprecated

brew install curl vim git python3 wget screen

pip3 install virtualenv

brew cask install java

echo
echo "Installing PostgreSQL..."
# install pgsql
brew install postgresql

# start service
brew services start postgresql

sleep 15
# change password
createuser postgres
createdb coderslab
psql -c "ALTER USER postgres WITH PASSWORD '${PASSWORD}';"

# ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
# launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist


echo
echo "Installing PyCharm"
brew cask install pycharm

echo
echo "Creating working directory..."
# creating and linkng Workspace
sudo mkdir ~/workspace
sleep 3
sudo chmod 777 -R ~/workspace

echo
echo "Just to be certain -- Updating system again..."
# update and upgrade all packages
brew update
brew upgrade

echo "#############################"
echo "####INSTALLATION COMPLETE####"
echo "#############################"
