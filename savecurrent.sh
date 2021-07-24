#!/bin/sh
echo "Answer 'y' to save the changes to:"
grep '^cp' deploy.sh | awk '{print $3 " " $2}' | sed "s,~,$HOME," | xargs -p -n2 cp

git commit -a

