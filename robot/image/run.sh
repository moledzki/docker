#!/bin/sh

SUITE=${ROBOT_SUITE:-"test-suite"}
WEB_PORT=${ROBOT_WEB_PORT:-"8080"}
WEB_HOST=${ROBOT_WEB_HOST:-"localhost"}
WEB_PROTOCOL=${ROBOT_WEB_PROTOCOL:-"http"}
WEB_EXPECTED_STRING=${ROBOT_WEB_EXPECTED_STRING:-".*"}
SELENIUM_HOST=${ROBOT_SELENIUM_HOST:-"localhost"}
SELENIUM_PORT=${ROBOT_SELENIUM_PORT:-"4444"}
SELENIUM_URL=${ROBOT_SELENIUM_URL:-""}
EXCLUDED_TESTS=${ROBOT_EXCLUED_TESTS:-"defaultexcludetag"}
INCLUDED_TESTS=${ROBOT_INCLUDED_TESTS}
APP_STARTUP_TIMEOUT=${ROBOT_APP_STARTUP_TIMEOUT:-"600"}
SKIP_WEB_APP_DETECTION=${ROBOT_SKIP_APP_DETECTION:-""}


if [ -z "$SKIP_WEB_APP_DETECTION" ]
then
  timeout=0
  echo "Waiting for Web Application on ${WEB_PROTOCOL}://${WEB_HOST}:${WEB_PORT}"
  while ! curl -ksL "${WEB_PROTOCOL}://${WEB_HOST}:${WEB_PORT}" | grep "${WEB_EXPECTED_STRING}" > /dev/null ; do
    sleep 2
    timeout=$((timeout+2))
    if [ $timeout -gt "$APP_STARTUP_TIMEOUT" ]; 
    then
      echo "Error: Timeout reached ($APP_STARTUP_TIMEOUT)s when waiting for Web Application start. Test execution terminated!"
      exit 1
    fi
  done
else
  echo "Skipping detection of ${WEB_PROTOCOL}://${WEB_HOST}:${WEB_PORT} (variable SKIP_WEB_APP_DETECTION) is set"
fi

#while ! nc -z $WEB_HOST $WEB_PORT; do
#  sleep 2 # wait for 1/10 of the second before check again
#done

echo "Web application is active"

echo "Waiting for selenium on $SELENIUM_HOST:$SELENIUM_PORT"

while ! curl -sL "http://${SELENIUM_HOST}:${SELENIUM_PORT}${SELENIUM_URL}/status" | jq .value.ready | grep "true" > /dev/null; do
  sleep 1 # wait for 1 before check again
done


#while ! nc -z $SELENIUM_HOST $SELENIUM_PORT; do
#  sleep 2 # wait for 1/10 of the second before check again
#done

echo "Selenium is active"

#sleep 10

cd /var/lib/robot/input/Zosia || exit

if [ -z ${INCLUDED_TESTS} ]
then
  robot --runemptysuite --exclude "${EXCLUDED_TESTS}" -d /var/lib/robot/output -x /var/lib/robot/output/xunit.xml "${SUITE}"
else
  robot --runemptysuite --include "${INCLUDED_TESTS}" --exclude "${EXCLUDED_TESTS}" -d /var/lib/robot/output -x /var/lib/robot/output/xunit.xml "${SUITE}"

fi

