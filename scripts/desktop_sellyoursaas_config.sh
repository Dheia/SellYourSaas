#!/bin/bash
#----------------------------------------------------------------
# This script allows to update or fix the /etc/sellyoursaas.conf file
#----------------------------------------------------------------


#set -e

source /etc/lsb-release

if [ "x$3" == "x" ]; then
   echo "Usage:   $0  hostfile  param  value  [hostgrouporname]"
   echo "         [hostgrouporname] can be 'master', 'deployment', 'web', 'remotebackup', or list separated with comma like 'master,deployment' (default)"
   echo "Example: $0  myhostfile  usecompressformatforarchive  zstd  master,deployment"
   echo "Example: $0  myhostfile  maxemailperday  500  withX.mysellyoursaasdomain.com"
   exit 1
fi

param=$2
value=$3
target=$4

if [ "x$target" == "x" ]; then
	target="master"
fi


export currentpath=$(dirname "$0")

cd $currentpath/ansible

echo "Execute ansible for host group $1 and targets $target"
pwd


#command="ansible-playbook -K change_sellyoursaas_config.yml -i hosts-$1 -e 'target="$target" option="$param" value="$value"' --limit=*.mydomain.com"
command="ansible-playbook -K change_sellyoursaas_config.yml -i hosts-$1 -e 'target=\"$target\" option=\"$param\" value=\"$value\"'"

echo "$command"
eval $command

echo "Finished."

