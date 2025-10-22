# Introduction
Playbooks and roles to set up my webserver and mailserver

# Dependencies
https://github.com/Checkmk/ansible-collection-checkmk.general

# Information to start
## create ansible user
in der Datei /etc/ssh/sshd_config "PermitRootLogin yes" setzen

    ssh root@<IP> -o StrictHostKeyChecking=no -o IdentitiesOnly=yes

## Ansible commands

   ansible-inventory -i inventory.ini --list

## Connection test
   
    ansible all -i inventory.ini -m ping

## Show facts

    ansible all -i inventory.ini -m setup

## test the playbook
    --check

## show difference
   --diff

## limit execution to a certain host
    --limit webserver

## show value for specific host and variable
    ansible rocky9 -m debug -a "var=fail2ban_loglevel" -i inventory/inventory.ini

## lint
    ansible-lint verify-apache.yml

## yaml lint
    yamllint .

-----------------------
## ab jetzt alles als ansible Benutzer
    ansible-playbook -i inventory/inventory.ini playbook/all.yml

## run only on mailserver
    ansible-playbook -i inventory/inventory.ini playbook/all.yml -l mailserver

## run only on certain tags
    ansible-playbook -i inventory/inventory.ini playbook/all.yml --tags "common"

## zum Testen
    ansible-playbook -i inventory/inventory.ini roles/checkmk/tasks/main.yaml

## list all tags
    ansible-playbook playbook/all.yml --list-tags

# Playbooks

## Checkmk site

    ansible-playbook -i inventory/inventory.ini playbooks/checkmksite.yml

## Checkmk agent

    ansible-playbook -i inventory/inventory.ini playbooks/checkmkagent.yml

    ansible-playbook -i inventory/inventory.ini playbooks/checkmkagent.yml --tags checkmk_rest
    
    cmk-agent-ctl register --hostname $(hostname -f) --server "checkmk.privatundfrei.de" --site "mycheck" --user agent_registration --password "XXXXX"

## OS Update

use -l to limit the update to a certain host

    ansible-playbook -i inventory/inventory.ini playbooks/os_update.yml -l webserver
