#!/bin/bash
# Autor: Javier

temp0=$(mktemp -t test0.XXXXXX)
temp1=$(mktemp -t test1.XXXXXX)
temp2=$(mktemp -t test2.XXXXXX)

function diskspace {
    df -k > $temp1
    dialog --textbox $temp1 20 50
}

function mem {
    cat /proc/meminfo > $temp1
    dialog --textbox $temp1 20 50
}

function whoIam {
    who > $temp1
    dialog --textbox $temp1 20 50
}

function files { 
    ls | wc -l > $temp1
    dialog --textbox $temp1 20 50
}


while [ 1 ]
do
dialog --menu "Menu" 20 30 10 1 "Disk space" 2 "whoIam" 3 "Memory" 4 "Count files" 0 "Exit" 2> $temp2
if [ $? -eq 1 ] 
then 
    break
fi

selection=$(cat $temp2)
case $selection in
    1) 
        diskspace ;;
    2) 
        whoIam ;;
    3) 
        mem ;;
    4) 
        files ;;    
    0)
        break ;;
    *)
        dialog --msgbox "Wrong key" 100 80
esac
done
rm -f $temp0 2> /dev/null
rm -f $temp1 2> /dev/null
rm -f $temp2 2> /dev/null
clear