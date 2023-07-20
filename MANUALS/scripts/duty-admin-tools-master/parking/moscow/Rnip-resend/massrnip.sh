#!/bin/bash

cat in.txt | while read line 
do
 echo "exec $line"
 echo $line | awk '{print $2}' >> out.txt
 $line >> out.txt
 sleep 10m
done

