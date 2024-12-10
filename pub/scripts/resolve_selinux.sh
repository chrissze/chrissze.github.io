#!/bin/bash

# cat /var/log/messages | grep "SELinux is preventing"

# sealert -a /var/log/audit/audit.log

cd /root/selinux-modules



#ausearch -c 'mdadm' --raw | audit2allow -M my-mdadm
#semodule -X 300 -i my-mdadm.pp


#ausearch -c 'systemd' --raw | audit2allow -M my-systemd
#semodule -X 300 -i my-systemd.pp
