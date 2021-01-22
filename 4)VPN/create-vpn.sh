#!/bin/bash
IP=127.0.0.1                                          # Server IP       
P=1194                                                  # Server Port     
OVPN_SERVER='10.80.0.0/16'              # VPN Network     

#vpn_data=/var/lib/swarmlab/openvpn/openvpn-services/   # Dir to save data ** this must exist **
vpn_data=$PWD/openvpn-services/                                           
if [ ! -d $vpn_data ]; then
 mkdir -p $vpn_data
fi

NAME=panos-vpn-services                              # name of docker service 
DOCKERnetwork=panos-vpn-services-network             # docker network
docker=registry.vlabs.uniwa.gr:5080/myownvpn            # docker image

docker stop  $NAME					      #stop container
sleep 1
docker container rm  $NAME				#rm container

# rm config files
rm -f $vpn_data/openvpn.conf.*.bak
rm -f $vpn_data/openvpn.conf
rm -f $vpn_data/ovpn_env.sh.*.bak
rm -f $vpn_data/ovpn_env.sh

# create network
sleep 1
docker network create --attachable=true --driver=bridge --subnet=172.50.0.0/16 --gateway=172.50.0.1 $DOCKERnetwork

#run container        see ovpn_genconfig
docker run --net=none -it -v $vpn_data:/etc/openvpn  -p 1194:1194 --rm $docker ovpn_genconfig  -u udp://$IP:1194 \
-N -d -c -p "route 172.50.20.0 255.255.255.0" -e "topology subnet" -s $OVPN_SERVER   

# create pki          see ovpn_initpki
docker run --net=none -v $vpn_data:/etc/openvpn  --rm -it $docker ovpn_initpki     

#                     see ovpn_copy_server_files
#docker run --net=none -v $vpn_data:/etc/openvpn  --rm $docker ovpn_copy_server_files

#create vpn           see --cap-add=NET_ADMIN
sleep 1
docker run --detach --name $NAME -v $vpn_data:/etc/openvpn --net=$DOCKERnetwork --ip=172.50.0.2 -p $P:1194/udp --cap-add=NET_ADMIN $docker  

sudo sysctl -w net.ipv4.ip_forward=1

#show created
docker ps