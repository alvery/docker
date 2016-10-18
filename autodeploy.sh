#!/bin/bash

function prompt(){

  echo "Do you wish to autodeploy mom_backend?"
  select yn in "Yes" "No"; do
      case $yn in
          Yes ) exec; break;;
          No ) exit;;
      esac
  done

}


# Init
function exec(){

  # Prepare
  set_hostname
  set_project_path
  add_subnetwork

  # Ready to deploy
  deploy

}

# Set project hostname
function set_hostname(){

  echo "Specify the hostname. By default: mombackend.app"
  read name

  if [ ! -n "$name" ]
  then
    hostname="mombackend.app"
  else
    hostname="$name"
  fi

  etc_hosts_add "$hostname"
  generate_nginx_conf "$hostname"

}

# Set project path
function set_project_path(){

  echo "Specify your project root directory. For example: ~/PhpstormProjects/mom_backend"
  read directory

  if [ ! -z "$directory" ]
  then
    directory="$directory"
  else
    echo "No root directory specified. Exiting.."
    exit;
  fi

  generate_docker_yml "$directory"

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

# Add main host and docs to nginx file
function generate_nginx_conf(){

  host_name="$1"
  path=./nginx

  cat $path/yii.conf.example | sed -e 's|\#HOSTNAME\#|'$host_name'|g' > $path/yii.conf

}

# Add network subnet for our containers
function add_subnetwork(){

  subnet='app_subnet2'
  exists=$(docker network ls | grep -E '(^| )'$subnet'( |$)' | wc -l)

  if [[ $exists > 0 ]]
  then
    echo "Subnetwork $subnet already exists"
  else
    echo "Subnetwork $subnet doesnt exists. Creating.."
    docker network create --gateway 172.20.1.1 --subnet 172.20.1.0/24 '$subnet'
  fi

}


# Generate docker-compose.yml
function generate_docker_yml(){

  path="$(echo -e "${1}" | tr -d '[[:space:]]')"
  cat docker-compose.example | sed -e 's|\#PATH\#|'$path'|g' > docker-compose.yml

}

function deploy(){

  echo "Ready to deploy!"
  echo "\Started..";
  docker-compose up


}



prompt
