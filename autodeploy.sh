#!/bin/bash

function prompt(){

  echo "Do you wish to autodeploy mom_backend?"
  select yn in "Yes" "No"; do
      case $yn in
          Yes ) change_host; break;;
          No ) exit;;
      esac
  done

}

function change_host(){

  echo "Specify the hostname. By default: mom_backend.app"
  read name

  if [ ! -n "$name" ]
  then
    hostname="mom_backend.app"
  else
    hostname="$name"
  fi

  #etc_hosts_add "$hostname"
}

# Add nginx host to hosts file
function etc_hosts_add(){

  # insert/update hosts entry
  ip_address="172.20.1.2"
  host_name="$1"

  # find existing instances in the host file and save the line numbers
  matches_in_hosts="$(grep -n $host_name /etc/hosts | cut -f1 -d:)"
  host_entry="${ip_address} ${host_name}"

  echo "Please enter your password if requested."

  if [ ! -z "$matches_in_hosts" ]
  then
      echo "Updating existing hosts entry."
      # iterate over the line numbers on which matches were found
      while read -r line_number; do
          # replace the text of each line with the desired host entry
          sudo sed -i '' "${line_number}s/.*/${host_entry} /" /etc/hosts
      done <<< "$matches_in_hosts"
  else
      echo "Adding new hosts entry."
      echo "$host_entry" | sudo tee -a /etc/hosts > /dev/null
  fi

}

# Add network subnet for our containers
function add_subnetwork(){

  docker network create --gateway 172.20.1.1 --subnet 172.20.1.0/24 app_subnet

}





prompt
