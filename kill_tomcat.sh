#Title: kill_tomcat.sh
#Description: Kill Script For Tomcat Cluster - Powered By HA Pacemaker
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
pid=$(ps -ef | grep tomown | grep "$i" | awk '{print $2}')
if [ "$pid" == "" ]; then
sleep 2
echo "----------------------------------------------------"
printf "INFO: $(tput setaf 2)${i%%/}$(tput sgr 0)\t \
$(tput setaf 1)Already stopped$(tput sgr 0) 
"
echo "----------------------------------------------------"
else
sleep 2
echo "----------------------------------------------------"
printf  "INFO: $(tput setaf 2)${i%%/}$(tput sgr 0)\t \
[PID="$pid"\t \
$(tput setaf 1)Killing$(tput sgr 0) $(tput setaf 2)${i%%/}$(tput sgr 0$(tput sgr 0))  
"
echo "----------------------------------------------------"
kill -9 "$pid"  2>/dev/null
fi
done
