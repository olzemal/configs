#!/bin/sh
grep '^cp' deploy.sh | awk '{print $2 " " $3}' | sed "s,~,$HOME," | xargs -n2 diff | wc -l

