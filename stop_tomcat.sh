#Title: stop_tomcat.sh
#Description: Stop Script For Tomcat Cluster - Powered By HA Pacemaker
#Vol: 1.1
#Author: Ante Perić
#Email peric.pericante@gmail.com
if ! [ $(id -u) = 0 ]; then
echo "$0 must be run as root or with sudo"
echo "Exiting."
exit 1
fi
echo "First arg: $1" > /dev/null
pid=$(ps -ef | grep tomown | grep "$1" | awk '{print $2}')
cd /var/applications/tomcat
#1. Pocetak glavnog if uvjeta
if  [ -z "$1" ]; then 
#Pocetak drugog if uvjeta
cd /var/applications/tomcat
for i in $(ls -d */)
do
pid=$(ps -ef | grep tomown | grep "$i" | awk '{print $2}')
if [ "$pid" == "" ]; then
sleep 2
echo "INFO: Stopping: ${i%%/}"
echo "INFO: Checking pid (${i%%/} 0)"
echo "....."
echo "INFO: ${i%%/} $(tput setaf 1)Already stopped$(tput sgr 0)"
echo "----------------------------------------------------------"
else
sleep 2
echo "INFO: Stopping: ${i%%/}"
echo "INFO: Checking pid (${i%%/} ${pid})"
echo "....."
systemctl stop tomcat-"${i%%/}"
echo "INFO: ${i%%/}" $(tput setaf 1)Stopped$(tput sgr 0)
echo "-----------------------------------------------------------"
fi
done
else
#echo "Unesen je $1 i  njegov pid je: $pid"
#echo ""
if [ "$pid" == "" ];then
echo "INFO: Stopping: ${i%%/}"
echo "INFO: Checking (pid $1 0)"
echo "....."
sleep 2
echo "INFO: $1 $(tput setaf 1)Already stopped$(tput sgr 0)"
else
echo "Unesen je $1 i  njegov pid je: $pid"
echo "INFO: Stopping: $1"
echo "INFO: Checking pid ($1 ${pid})"
echo "....."
sleep 2
echo "INFO: $1" $(tput setaf 1)Stopped$(tput sgr 0)
systemctl stop tomcat-${1} > /dev/null
fi
fi
#1.Kraj glavnog if uvjeta
