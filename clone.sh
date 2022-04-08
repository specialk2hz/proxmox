#!/bin/bash

# clear
# echo "#############################################################################################"
# echo "###"
# echo "###    CNAA Proxmox Virtual Machine Builder Script"
# echo "###"
# echo "#############################################################################################"
# echo
# echo

# read -p "Template ID to clone? " template_id
read -p "VMID for Clone? " clone_id
read -p "VM Name? " clone_name
read -p "What Storage? sata, nvme) " clone_storage

# #qm clone $template_id $clone_id --name $clone_name --full --storage $clone_storage

read -p "DHCP? [yn] " answer
if [ "$answer" == "y" ];
then
  echo "Clone $clone_name ($clone_id) Complete!"
  read -p "Start the VM?" answer
  if [ "$answer" == "y" ];
  then
    echo "Starting $clone_name ($clone_id) "
    qm start $clone_id
    exit
  else
    echo "GoodBye"
    exit
  fi
else
read -p "IP Address? " clone_ip
fi

read -p "Subnet Mask /24? [yn] " answer
if [[ $answer = y ]] ; then
clone_subnet=24
else
echo -n "Enter Subnet Mask (/XX)? "
read clone_subnet
fi

read -p "Gateway 10.10.10.1? [yn] " answer
if [[ $answer = y ]] ; then
clone_gateway=10.10.10.1
else
echo -n "Gateway? "
read clone_gateway
fi

qm set $clone_id --ipconfig0 ip=$clone_ip/$clone_subnet,gw=$clone_gateway

read -p "Start the VM? " answer
if [ "$answer" == "y" ];
then
    echo "Starting $clone_name ($clone_id) "
    qm start $clone_id
    exit
else
    echo "GoodBye "
    exit
fi