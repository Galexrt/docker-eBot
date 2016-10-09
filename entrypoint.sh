#!/bin/bash

EBOT_IP="${EBOT_IP:-}"
MYSQL_HOST="${MYSQL_HOST:-}"
MYSQL_PORT="${MYSQL_PORT:-3306}"
MYSQL_USER="${MYSQL_USER:-ebot}"
MYSQL_PASS="${MYSQL_PASS:-}"
MYSQL_DB="${MYSQL_DB:-ebot}"

LO3_METHOD="${LO3_METHOD:-restart}"
KO3_METHOD="${KO3_METHOD:-restart}"

DELAY_READY="${DELAY_READY:-false}"

sed -i "s/BOT_IP =.*/BOT_IP = \"$EBOT_IP\"/g" $EBOT_HOME/config/config.ini
sed -i "s/MYSQL_IP =.*/MYSQL_IP = \"$MYSQL_HOST\"/g" $EBOT_HOME/config/config.ini
sed -i "s/MYSQL_PORT =.*/MYSQL_PORT = \"$MYSQL_PORT\"/g" $EBOT_HOME/config/config.ini
sed -i "s/MYSQL_USER =.*/MYSQL_USER = \"$MYSQL_USER\"/g" $EBOT_HOME/config/config.ini
sed -i "s/MYSQL_PASS =.*/MYSQL_PASS = \"$MYSQL_PASS\"/g" $EBOT_HOME/config/config.ini
sed -i "s/MYSQL_BASE =.*/MYSQL_BASE = \"$MYSQL_DB\"/g" $EBOT_HOME/config/config.ini

sed -i "s/LO3_METHOD =.*/LO3_METHOD = \"$LO3_METHOD\"/g" $EBOT_HOME/config/config.ini
sed -i "s/KO3_METHOD =.*/KO3_METHOD = \"$KO3_METHOD\"/g" $EBOT_HOME/config/config.ini

sed -i "s/DELAY_READY = .*/DELAY_READY = $DELAY_READY/g" $EBOT_HOME/config/config.ini

exec php "$EBOT_HOME/bootstrap.php"
