######################################################################################################################
#
#                               script to install Magento software on ubuntu VM
#
######################################################################################################################
#variables required to run magento-install command
firstname=$1
lastname=$2
adminemail=$3
adminuser=$4
adminpassword=$5
dbname=$6
dbhost=$7
dbuser=$8
dbpassword=$9
adminloginurlname=${10}

#Go to the magento installed folder 
 cd /var/www/html/uservm.com/public_html

#Provide permissions for the public_html folder to read/write by all the php scripts
 sudo chown -R www-data:www-data /var/www/html/uservm.com/public_html
 sudo find var vendor pub/static pub/media app/etc -type f -exec chmod g+w {} \;
 sudo find var vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} \;
 sudo chown -R magento:www-data .
 sudo chmod u+x bin/magento
 echo "======================================restartig MySql server==================================================="
 #Restart Apache
 sudo systemctl restart apache2
 
 cd bin
 echo "======================================Installing Magento software==============================================="
 ./magento setup:install --admin-firstname="$firstname" --admin-lastname="$lastname" --admin-email="$adminemail" --admin-user="$adminuser" --admin-password="$adminpassword" --db-name="$dbname" --db-host="$dbhost" --db-user="$dbuser" --db-password="$dbpassword" --backend-frontname="$adminloginurlname" --cleanup-database
