#!/bin/sh

SUITE=${ROBOT_SUITE:-"test-suite"}
WEB_PORT=${ROBOT_WEB_PORT:-"8080"}
WEB_HOST=${ROBOT_WEB_HOST:-"localhost"}
SELENIUM_HOST=${ROBOT_SELENIUM_HOST:-"localhost"}
SELENIUM_PORT=${ROBOT_SELENIUM_PORT:-"4444"}

echo "Waiting for Web Application on $WEB_HOST:$WEB_PORT"

while ! nc -z $WEB_HOST $WEB_PORT; do
  sleep 2 # wait for 1/10 of the second before check again
done

echo "Web application is active"

echo "Waiting for selenium on $SELENIUM_HOST:$SELENIUM_PORT"

while ! nc -z $SELENIUM_HOST $SELENIUM_PORT; do
  sleep 2 # wait for 1/10 of the second before check again
done

echo "Selenium is active"

sleep 10


cd /var/lib/robot/input
pybot --runemptysuite -d /var/lib/robot/output $SUITE
