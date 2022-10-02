#!/bin/bash

for i in {1..2500}
do
 echo -e "{  \n 'name': 'ISN #$i',\n 'image': 'Base-URI/1.gif' \n}" > $i
done
