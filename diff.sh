#!/bin/sh
files=$(grep '^cp' deploy.sh | awk '{print $2 " " $3}' | sed "s,~,$HOME,")

echo $files | xargs -n2 diff -q

