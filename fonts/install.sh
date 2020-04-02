#!/bin/bash


echo "Configuring fonts..."
echo "Installing fonts..."
mkdir -p ${HOME}/.local/share/fonts

echo "Installing Operator Mono font..."
sudo cp -a Operator\ Mono/. ${HOME}/.local/share/fonts
sudo cp -a Operator\ Mono\ Lig/. ${HOME}/.local/share/fonts
sudo cp -a Dank\ Mono/. ${HOME}/.local/share/fonts

fc-cache -f -v


echo "fonts configuration!"
