#!/bin/bash
nmap -sn 192.168.0.0/24 > /tmp/outfile
awk -F\( '/MAC/ {print $2}' /tmp/outfile | awk -F\) '{print $1}' | sort > /tmp/macfile
Dati=`date +"%d/%m/%Y,%H:%M"`
Tcon=`awk -F\( '/done/ {print $2}' /tmp/outfile | awk '{print $1}'`
Coun=$((Tcon-1))
Appl=`cat /tmp/macfile | grep Appl | wc -l`
Chon=`cat /tmp/macfile | grep Chon | wc -l`
Cisc=`cat /tmp/macfile | grep Cisc | wc -l`
Inte=`cat /tmp/macfile | grep Inte | wc -l`
Netg=`cat /tmp/macfile | grep Netg | wc -l`
Unkn=`cat /tmp/macfile | grep Unkn | wc -l`
Comm=','
echo $Dati$Comm$Coun$Comm$Appl$Comm$Chon$Comm$Cisc$Comm$Inte$Comm$Netg$Comm$Unkn >> /var/www/html/DeviceBreakdown.csv
