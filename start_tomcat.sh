#Title: start_tomcat.sh
#Description: Start Script For Tomcat Cluster - Powered By HA Pacemaker
#Vol: 1.1
#Author: Ante Perić
#Email peric.pericante@gmail.com
if ! [ $(id -u) = 0 ]; then
echo "$0 must be run as root or with sudo"
echo "Exiting."
exit 1
fi
echo "First arg: $1" > /dev/null
#1. Pocetak glavnog if uvjeta
if  [ -z "$1" ]; then
#Pocetak drugog if uvjeta
cd /var/applications/tomcat
for i in $(ls -d */)
do
pid=$(ps -ef | grep tomown | grep "$i" | awk '{print $2}')
if [ "$pid" == "" ]; then
sleep 2
echo "INFO: Starting: ${i%%/}"
systemctl start tomcat-"${i%%/}"
echo "....."
pid_1=$(ps -ef | grep tomown | grep "$i" | awk '{print $2}')
echo "INFO: Checking pid (${i%%/} ${pid_1})"
echo "INFO: ${i%%/}" $(tput setaf 2)Started$(tput sgr 0)
echo "-----------------------------------------------------------"
else
sleep 2
echo "INFO: Starting: ${i%%/}"
echo "INFO: Checking pid (${i%%/} ${pid})"
echo "....."
systemctl start tomcat-"${i%%/}"
echo "INFO: ${i%%/}" $(tput setaf 2)Already started$(tput sgr 0)
echo "-----------------------------------------------------------"
fi
done
else
pid=$(ps -ef | grep tomown | grep "$1" | awk '{print $2}')
if [ "$pid" == "" ]; then
sleep 2
echo "INFO: Starting: $1"
systemctl start tomcat-$1
echo "....."
sleep 2
pid_1=$(ps -ef | grep tomown | grep $1 | awk '{print $2}')
echo "INFO: Checking pid ($1 $pid_1)"
echo "INFO: $1 $(tput setaf 2)Started$(tput sgr 0)"
else
pid_2=$(ps -ef | grep tomown | grep $1 | awk '{print $2}')
echo "INFO: Starting: $1"
echo "....."
sleep 2
echo "INFO: Checking pid ($1 $pid_2)"
echo "INFO: $1 $(tput setaf 2)Already started$(tput sgr 0)"
fi
fi

