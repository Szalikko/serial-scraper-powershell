#!/bin/bash

# Get PC info
function get_pc_info {
    manufacturer=$(sudo dmidecode -s system-manufacturer)
    model=$(sudo dmidecode -s system-product-name)
    serial=$(sudo dmidecode -s system-serial-number)

    result="---------- Computer ----------
Manufacturer : $manufacturer
Model        : $model
Serial Number: $serial

------------------------------"
    echo "$result"
}

# Get user info
function get_userinfo {
    username=$(whoami)
    pcname=$(hostname)
    domain=$(domainname)

    result="Username     : $username
PCName       : $pcname
Domain       : $domain"
    echo "$result"
}

# Get monitors info using xrandr
function get_monitors_info {
    echo "---------- Monitors ----------"
    xrandr --listmonitors | tail -n +2 | while read -r line; do
        result=$(echo "$line" | awk '{print "Manufacturer : Not Found\nModel        : " $4 "\nSerial Number: Not Found"}')
        echo "$result"
    done
}

# Get current date and time
function time_f {
    date "+---- %d/%m/%Y  %H:%M:%S ----"
}

# Save all gathered data into output.txt
function output {
    get_pc_info
    get_userinfo
    get_monitors_info
    time_f
}

output > output.txt
echo "OK"
sleep 2
