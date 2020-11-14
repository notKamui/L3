#!/bin/bash

make

launch(){
    echo "File: $1"
    "./as" < $1
    if [ $? = 0 ]; then
        echo "--> Valid syntax"
    else
        echo "--> Invalid syntax"
    fi
}

echo
echo "##########Beginning tests##########"
echo "======Valid programs======"
for file in ../test/valid/*.tpc; do
    launch $file
done
echo "======Invalid programs======"
for file in ../test/invalid/*.tpc; do
    launch $file
done
echo "##########Ending tests##########"
echo

make clean