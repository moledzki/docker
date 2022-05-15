#!/bin/bash

source INFO
source ../lib/.functions.sh

#set -x
buildImage robotVersion=${ROBOT_VERSION} seleniumVersion=${SELENIUM_VERSION} robotSeleniumVersion=${ROBOT_SELENIUM_VERSION} robotDatabaseVersion=${ROBOT_DATABASE_VERSION} robotImapVersion=${ROBOT_IMAP_VERSION}
