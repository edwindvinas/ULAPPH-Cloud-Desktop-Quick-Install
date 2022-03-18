#!/bin/bash
#-------------TIEDOT-------
echo "Stopping tiedot db..."
curl "http://localhost:6060/shutdown"
#-------------SEAWEEDFS-------
echo "Stopping seaweedfs..."
ps aux | grep weed | grep -v "grep weed" | awk '{print $1}' | xargs kill -9
#fuser 7070/tcp 
#fuser 9333/tcp
#-------------ULAPPH-------
echo "Stopping ulapph..."
ps aux | grep ULAPPH-Cloud-Desktop | grep -v "grep ULAPPH-Cloud-Desktop" | awk '{print $1}' | xargs kill -9
ps aux | grep main | grep -v "grep main" | awk '{print $1}' | xargs kill -9
