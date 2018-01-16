######################################################################################################################
#
#     script to configure mysql server to accept remote connections
#
######################################################################################################################
DBUSER="mysqluser"
PASSWDDB="Random@12345"
MAGENTOVM1=$1
MAGENTOVM2=$2
MAGENTOVMUSER1=$3
MAGENTOVMUSER2=$4
echo "===========================editing the mysqld.conf file to accept any connection==========================="
sudo sed -i "s/127.0.0.1/\*/" "/etc/mysql/mysql.conf.d/mysqld.cnf"
echo "======================================restartig MySql server==============================================="
sudo service mysql restart
sleep 15

# mysql -uroot -pSysgain@12345 -e "CREATE DATABASE ${DBUSER} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
echo "========================================creating Database user ==========================================="
mysql -uroot -pSysgain@12345 -e "CREATE USER ${DBUSER} IDENTIFIED BY '${PASSWDDB}';"
mysql -uroot -pSysgain@12345 -e "GRANT ALL PRIVILEGES ON magento.* TO '${DBUSER}';"
mysql -uroot -pSysgain@12345 -e "FLUSH PRIVILEGES;"
echo "===================================granting permissions to magentodb ======================================"
mysql -uroot -pSysgain@12345 -e "GRANT ALL ON magento.* TO ${MAGENTOVMUSER1}@${MAGENTOVM1} IDENTIFIED BY '${PASSWDDB}';"
mysql -uroot -pSysgain@12345 -e "GRANT ALL ON magento.* TO magentouser${MAGENTOVMUSER2}@${MAGENTOVM2} IDENTIFIED BY '${PASSWDDB}';"
mysql -uroot -pSysgain@12345 -e "GRANT ALL PRIVILEGES ON magento.* TO 'mysqluser';"