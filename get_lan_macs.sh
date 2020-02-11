#!/bin/bash
#
SCAN=`ip route | grep -v default | awk '{print $1}'`
EXPF='/var/www/html/LANMACs.csv'
UNIQ=`date +"%Y%m%d%H%M"`
OUTF='/tmp/outfile'$UNIQ
MACF='/tmp/macfile'$UNIQ
nmap -sn $SCAN > $OUTF
awk -F\( '/MAC/ {print $2}' $OUTF | awk -F\) '{print $1}' | sort > $MACF
Dati=`date +"%d/%m/%Y,%H:%M"`
Tcon=`awk -F\( '/done/ {print $2}' $OUTF | awk '{print $1}'`
Coun=$((Tcon-1))
Appl=`cat $MACF | grep Apple | wc -l` 
Cisc=`cat $MACF | grep Cisco | wc -l`
Inte=`cat $MACF | grep Intel | wc -l`
Netg=`cat $MACF | grep Netgear | wc -l`
Chon=`cat $MACF | grep Chongqing | wc -l`
Unkn=$((Coun-Appl-Cisc-Inte-Netg-Chon))
Comm=','
echo $Dati$Comm$Coun$Comm$Appl$Comm$Cisc$Comm$Inte$Comm$Netg$Comm$Chon$Comm$Unkn >> $EXPF
find /tmp -name "???file*" -type f -mtime +7 -exec rm {} \;
