#!/bin/bash


if grep -iq "$USER" /home/hugoc/contact.txt; then
    
    exit 0

else

    exit 1

fi

