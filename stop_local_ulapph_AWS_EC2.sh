#!/bin/bash
#-------------TIEDOT-------
echo "Stopping tiedot db..."
curl "http://localhost:6060/shutdown"
#-------------SEAWEEDFS-------
echo "Stopping seaweedfs..."
ps -ax | grep weed | grep -v "grep weed" | awk '{print $1}' | xargs kill -9
#-------------ULAPPH-------
echo "Stopping ulapph..."
ps -ax | grep ULAPPH-Cloud-Desktop | grep -v "grep ULAPPH-Cloud-Desktop" | awk '{print $1}' | xargs kill -9
ps -ax | grep main | grep -v "grep main" | awk '{print $1}' | xargs kill -9
