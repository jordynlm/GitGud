#!/bin/bash

# Prompt for and set GITGUD_PATH
printf "Enter GitGud path: "
read gitgud_path
echo "export GITGUD_PATH=$gitgud_path" >> ~/.bashrc
source ~/.bashrc

# Add gitgud symlink
sudo ln -s $GITGUD_PATH/gitgud /usr/bin/gitgud

# Clone pizzapi
git clone https://github.com/gamagori/pizzapi.git
cd pizzapi
sudo python3 setup.py install
cd ..

# Clone PyGithub
