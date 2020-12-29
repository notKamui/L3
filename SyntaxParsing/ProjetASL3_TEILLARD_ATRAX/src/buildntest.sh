#!/bin/bash

make
echo > testoutputs.txt

launch(){
    echo "File: $1" | tee -a testoutputs.txt
    "./as" < $1 | cat >> testoutputs.txt
    if [ $? = 0 ]; then
        echo "--> Valid syntax" | tee -a testoutputs.txt
    else
        echo "--> Invalid syntax" | tee -a testoutputs.txt
    fi
}

echo
echo "##########Beginning tests##########"
echo "======Valid programs======" | tee -a testoutputs.txt
for file in ../test/valid/*.tpc; do
    launch $file
done
echo | tee -a testoutputs.txt
echo "======Invalid programs======" | tee -a testoutputs.txt
for file in ../test/invalid/*.tpc; do
    launch $file
done
echo "##########Ending tests##########"
echo

make clean