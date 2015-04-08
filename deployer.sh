#!/bin/bash

aftp(){
    echo "---> Configure nginx-globals automatically (provision)"
    echo "---> Checking that we have required software installed"
    for cli in curl; do
        if ! type "$cli" > /dev/null 2>&1; then
            echo "ERROR: $cli is not installed and in the PATH. Aborting."
            exit 1
        fi
    done

    curl --silent -Lk https://github.com/philcryer/nginx-globals/archive/master.tar.gz | tar xz
    sudo cp -R nginx-globals-master/globals /etc/nginx/
    rm -rf nginx-globals-master
}

local(){
    echo "---> Configure nginx-globals on local nginx"
    echo "---> Checking that we have required software installed"
    for cli in sudo; do
        if ! type "$cli" > /dev/null 2>&1; then
            echo "ERROR: $cli is not installed and in the PATH. Aborting."
            exit 1
        fi
    done

    if [ -d '/etc/nginx' ]; then
        sudo cp -R nginx-globals/globals /etc/nginx/
    else
        echo "ERROR: Nginx config dir not found in /etc/nginx, bailing."
        exit 1
    fi

    echo "---> Testing that nginx-globals runs without errors on local nginx"
    test=`sudo /usr/sbin/nginx -t -q|wc -l`
    if [ ${test} -gt '1' ]; then
        echo "  [FAIL] test was not successful. Aborting"
        sudo rm -rf /etc/nginx/globals
        exit 1
    else
        echo "  > test was successful"
        echo "  > reloading nginx with new config"
        sudo service nginx reload
    fi
}

local

echo "---> Done"

exit 0
