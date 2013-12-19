#! /bin/bash
html=`curl -ss http://303:30330330@192.168.1.1/userRpm/StatusRpm.htm | head -38 | tail -3`
ip=`echo $html | awk -F"[\"]" '{print $4}'`
echo $ip
touch ~/Dropbox/ip_addr.txt
echo $ip > ~/Dropbox/ip_addr.txt