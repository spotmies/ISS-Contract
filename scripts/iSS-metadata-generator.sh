#!/bin/bash

for i in {1..2500}
do
 echo -e "{  \n 'name': 'Skull #$i',\n 'image': 'https://gateway.pinata.cloud/ipfs/QmehAsMJztT2wj5ALB7gPSXrRhPenmh7JqpDczk3SpNx1d/' \n}" > $i
done



// change json to plain

#! /bin/bash 

for i in {1..4444}
do
        cp $i.json $i
done 
