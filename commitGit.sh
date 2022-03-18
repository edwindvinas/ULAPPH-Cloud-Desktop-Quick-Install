#!/bin/bash
# commitGit.sh 202004120946PM
git add --all
#git commit -m "update"
git commit -m $1
git push origin master

