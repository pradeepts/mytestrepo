######################################################################################################################
#
#                                        script to configure magento vm 
#
######################################################################################################################
# create random password
DBUSER=$1
PASSWDDB="Random@12345"
MAGENTOVMDNS=$2
echo "================================editing the uservm.com.conf file to accept ===================================="
sudo sed -i "s/13.64.198.81/$MAGENTOVMDNS/" "/etc/apache2/sites-available/uservm.com.conf"
sudo systemctl restart apache2
sleep 15
echo "========================================creating Database user ================================================"
# mysql -uroot -pSysgain@12345 -e "CREATE DATABASE ${DBUSER} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
mysql -uroot -pSysgain@12345 -e "CREATE USER ${DBUSER} IDENTIFIED BY '${PASSWDDB}';"
mysql -uroot -pSysgain@12345 -e "GRANT ALL PRIVILEGES ON magento.* TO '${DBUSER}';"
mysql -uroot -pSysgain@12345 -e "FLUSH PRIVILEGES;"