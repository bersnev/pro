#!/bin/bash
/usr/bin/mysqld_safe --skip-grant-tables &
sleep 5
mysql -u root -e "CREATE DATABASE mydb"
mysql -u root mydb < /tmp/dump.sql
