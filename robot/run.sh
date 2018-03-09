#!/bin/sh

SUITE=${ROBOT_SUITE:-"test-suite"}
WEB_PORT=${ROBOT_WEB_PORT:-"8080"}
WEB_HOST=${ROBOT_WEB_HOST:-"localhost"}
WEB_PROTOCOL=${ROBOT_WEB_PROTOCOL:-"http"}
WEB_EXPECTED_STRING=${ROBOT_WEB_EXPECTED_STRING:-".*"}
SELENIUM_HOST=${ROBOT_SELENIUM_HOST:-"localhost"}
SELENIUM_PORT=${ROBOT_SELENIUM_PORT:-"4444"}
EXCLUDED_TESTS=${ROBOT_EXCLUED_TESTS:-"defaultexcludetag"}
APP_STARTUP_TIMEOUT=${ROBOT_APP_STARTUP_TIMEOUT:-"600"}

timeout=0
echo "Waiting for Web Application on ${WEB_PROTOCOL}://${WEB_HOST}:${WEB_PORT}"
while ! curl -sL "${WEB_PROTOCOL}://${WEB_HOST}:${WEB_PORT}" | grep "${WEB_EXPECTED_STRING}" > /dev/null ; do
  sleep 2
  timeout=$((timeout+2))
  if [ $timeout -gt "$APP_STARTUP_TIMEOUT" ]; 
  then
    echo "Error: Timeout reached ($APP_STARTUP_TIMEOUT)s when waiting for Web Application start. Test execution terminated!"
    exit 1
  fi
done

#while ! nc -z $WEB_HOST $WEB_PORT; do
#  sleep 2 # wait for 1/10 of the second before check again
#done

echo "Web application is active"

echo "Waiting for selenium on $SELENIUM_HOST:$SELENIUM_PORT"

while ! curl -sL "http://${SELENIUM_HOST}:${SELENIUM_PORT}/wd/hub" | grep "WebDriver Hub" > /dev/null; do
  sleep 1 # wait for 1 before check again
done


#while ! nc -z $SELENIUM_HOST $SELENIUM_PORT; do
#  sleep 2 # wait for 1/10 of the second before check again
#done

echo "Selenium is active"

#sleep 10

cd /var/lib/robot/input || exit

pybot --runemptysuite --exclude "${EXCLUDED_TESTS}" -d /var/lib/robot/output "${SUITE}"
