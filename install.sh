#!/bin/bash
ansible_user=$(whoami)
sed -i -E "s/(ansible_user=.+)/ansible_user=$ansible_user/g" host.ini
if ! hash ansible >/dev/null 2>&1; then
    echo "Installing Ansible..."
    sudo apt-get update
    sudo apt-get install ansible git python3-apt -y
else
    echo "Ansible already installed"
fi

ansible-galaxy collection install ansible.posix
export ANSIBLE_LOAD_CALLBACK_PLUGINS=1
ansible-playbook workstation.yaml -K