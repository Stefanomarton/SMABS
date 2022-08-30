#!/bin/bash
sudo pacman -S ansible ansible-core &&
ansible-galaxy collection install community.general &&
sudo ansible-pull -U https://github.com/Stefanomarton/SMABS.git &&
echo "Agg' fatto"
