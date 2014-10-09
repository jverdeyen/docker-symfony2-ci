#!/bin/bash

# Now the provided user credentials are added
/usr/sbin/mysqld &
sleep 5
mysql -u root -e " \
  SET PASSWORD = PASSWORD('root'); \
  UPDATE mysql.user SET password = PASSWORD('root') WHERE user = 'root';"


# And we restart the server to go operational
mysqladmin shutdown
echo "Starting MySQL Server"
/usr/sbin/mysqld