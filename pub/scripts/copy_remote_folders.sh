#!/bin/bash




echo "COPY REMOTE FOLDER TO LOCAL FOLDER"

rsync -av -e 'ssh -p 55555' --progress  almalinux@o2.host.ac:/usr/node /usr/
