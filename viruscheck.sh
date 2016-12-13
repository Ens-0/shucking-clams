#!/bin/bash 
##This is a script to automate virus scanning for attached devices using the clamAV engine. They can be found at https://www.clamav.net/ 
##It's intended as an independent practice Bash script Nothing serious

##Checking to see if ClamAV engine is installed
hash clamscan>/dev/null
clamcheck=$?
if [ "${clamcheck}"==0 ]; then
    echo "Good! Clamscan should work"
else
    echo >&2 "I need to install the clamav package to run. Is that ok?"; read -ep "y or n " answer; case $answer in
    Yes | yes | y) sudo apt-get update; sudo apt-get install clamav --install-recommends; sudo freshclam;;
    No | no | n) echo "Clamscan is requried. Exiting. "; exit 1;;
    *) echo "I don't understand. It's a yes or no question."; exit 1;;
esac
fi

if [ -d "$HOME/Desktop/taza" ]; then
    cd "$HOME/Desktop/taza"
else
    mkdir "$HOME/Desktop/taza"
    cd "!^"
fi

read -ep "Клиенттин аты ким? " givenname
    if [ -d "$HOME/Desktop/taza/${givenname}" ]; then
        cd "$HOME/Desktop/taza/${givenname}"
        day="$(date)"
        mkdir "${day}"
        cd "${day}"
        clamscan -zir /media/* --remove > check.txt
    else
        mkdir "$HOME/Desktop/taza/${givenname}"
        cd "$HOME/Desktop/taza/${givenname}"
        clamscan -zir /media/*/ --remove> check.txt
fi

estatus=$?
if [ "${estatus}"==0 ]; then
    echo "Great, everything worked"    
else
    echo "Exit Status is ${estatus}.
    Something went wrong with the cleaning step. Check again
    Google, Fix, and Try again"
fi

