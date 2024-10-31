[Unit]
Description=Docker Application Container Engine
Documentation=https://docs.docker.com
After=docker.socket network-online.target firewalld.service
Requires=docker.socket
Wants=network-online.target

[Service]
Type=notify
ExecStart=/home/cs/.nix-profile/bin/dockerd \
          --host=fd:// \
          --exec-opt native.cgroupdriver=systemd \
          $OPTIONS

ExecReload=/bin/kill -s HUP $MAINPID
LimitNOFILE=infinity
LimitNPROC=infinity
LimitCORE=infinity

TimeoutStartSec=0
# set delegate yes so that systemd does not reset the cgroups of docker containers
#Delegate=yes
KillMode=process

Restart=on-failure
StartLimitBurst=10
StartLimitInterval=300s

[Install]
WantedBy=multi-user.target
