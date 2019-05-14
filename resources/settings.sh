#!/usr/bin/env bash


FILE="/var/jenkins_home/jenkins.model.JenkinsLocationConfiguration.xml"
if [[ -f "$FILE" ]];then
    echo "Found $FILE"
    if [ ! -z ${EMAIL_ADDR+x} ]; then
        echo "Updating email address"
        `sed -i  's/address not configured yet &lt;nobody@nowhere&gt;/'EMAIL_ADDR'/g' $FILE`
    fi
    if [ ! -z ${URL_ADDR+x} ]; then
        echo "Updating email address"
        `sed -i  's/address not configured yet &lt;nobody@nowhere&gt;/'URL_ADDR'/g' $FILE`
    fi
fi