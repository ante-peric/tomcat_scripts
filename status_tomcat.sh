#Title: status_tomcat.sh
#Description: Status Script For Tomcat Cluster - Powered By HA Pacemaker
#Vol: 1.1
#Author: Ante Perić
#Email peric.pericante@gmail.com
if ! [ $(id -u) = 0 ]; then
echo "$0 must be run as root or with sudo"
echo "Exiting."
exit 1
fi
cd /var/applications/tomcat
for i in $(ls -d */)
 do
echo ""
#pid=$(cat /var/applications/tomcat/${i}/temp/tomcat.pid)
pid=$(ps -ef | grep tomown | grep "$i" | awk '{print $2}')
if [ "$pid" == "" ]; then
printf  "INFO: ${i%%/}\t \
[PID="0"\t \
              VER=9.0.45.0 USER:root]\t \
      STATUS:$(tput setaf 1)Stopped$(tput sgr 0) "
echo ""
echo "-------------------------------------------------------------------------------------------------------------"
else
datum_01=$(ls -l --time-style=+"%d/%m/%Y %H:%M:%S"  /var/applications/tomcat/$i/temp/tomcat.pid |  awk '{print  $6, $7}')
datum_02=$(ls -l --time-style=+"%d %m %Y %H:%M:%S"  /var/applications/tomcat/$i/temp/tomcat.pid |  awk '{print  $9}')
datum_1=$(ls -l  --time-style=+%F  /var/applications/tomcat/$i/temp/tomcat.pid |  awk '{print   $6}')
datum_1a=$(date -d "$datum_1" '+%s')
datum_2=$( date +"%F")
datum_2a=$(date -d "$datum_2" '+%s')
ispis=$(( ( datum_2a - datum_1a )/(60*60*24) ))
if [ "$datum_1" == "$datum_2" ]; then 
printf  "INFO: ${i%%/}\t \
[PID="${pid%%}"\t \
      VER=9.0.45.0 USER:root]\t \
      STATUS:$(tput setaf 2)Active:$(tput sgr 0)${datum_01} "
echo ""
echo "-------------------------------------------------------------------------------------------------------------"
else
printf  "INFO: ${i%%/}\t \
[PID="${pid%%}"\t \
      VER=9.0.45.0 USER:root]\t \
      STATUS:$(tput setaf 2)Active:$(tput sgr 0)${ispis} ${datum_02}"
echo ""
echo "-------------------------------------------------------------------------------------------------------------"
fi
fi
done
