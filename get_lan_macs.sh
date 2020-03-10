#!/bin/bash
#
# If the CSV output file doesn't exist create it.
#
EXPF='/var/www/html/LANMACs.csv'
if [ ! -f "$EXPF" ]; then
	echo "Date,Time,Count,Apple,Cisco,Intel,netgear,Chongqing,Other" >> $EXPF
fi
#
# this returns the local subnet to scan
#
SCAN=`ip route | grep -v default | awk '{print $1}'`
#
# define our temp files with a date / time stamp
#
UNIQ=`date +"%Y%m%d%H%M"`
OUTF='/tmp/outfile'$UNIQ
MACF='/tmp/macfile'$UNIQ
#
# run the network scan & export to the outfile
#
nmap -sn $SCAN > $OUTF
#
# extract the lines carrying the MAC addresss & export to the macfile
#
awk -F\( '/MAC/ {print $2}' $OUTF | awk -F\) '{print $1}' | sort > $MACF
#
# the date / time columns for the CSV file
#
Dati=`date +"%d/%m/%Y,%H:%M"`
#
# subtract 1 from the total count to exlude the device running this script
#
Tcon=`awk -F\( '/done/ {print $2}' $OUTF | awk '{print $1}'`
Coun=$((Tcon-1))
#
# count the most popular manufacturer & leave the rest to unknown. 
#
Appl=`cat $MACF | grep Apple | wc -l`
Cisc=`cat $MACF | grep Cisco | wc -l`
Inte=`cat $MACF | grep Intel | wc -l`
Netg=`cat $MACF | grep Netgear | wc -l`
Chon=`cat $MACF | grep Chongqing | wc -l`
Unkn=$((Coun-Appl-Cisc-Inte-Netg-Chon))
#
# append findings to CSV file
#
Comm=','
echo $Dati$Comm$Coun$Comm$Appl$Comm$Cisc$Comm$Inte$Comm$Netg$Comm$Chon$Comm$Unkn >> $EXPF
#
# keep our temp files for 14 days if any debugging or analysis is required after that delete. 
#
find /tmp -name "???file*" -type f -mtime +14 -exec rm {} \;
