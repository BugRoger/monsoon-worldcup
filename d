#!/bin/bash

if [ $# -lt 1 ]
then
        echo "Usage : $0 command"
        echo "Commands:"
        echo 'ssh "alias" - SSH into specified container' 
        echo 'rebuild "alias" - Rebuild specified container'
        exit
fi

case "$1" in

ssh)
  vagrant ssh -c "ssh -i /monsoon-worldcup/docker/$2/ssh/id_rsa root@\`docker inspect $2 | jq -r '.[].NetworkSettings.IPAddress'\`"
    ;;
rebuild)
    vagrant ssh -c "sh /monsoon-worldcup/docker/$2/scripts/rebuild.sh"
    ;;
*) echo "Command not known"
   ;;
esac
