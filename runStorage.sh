#!/bin/bash
echo "Running SeaweedFS...master"
/c/Development/seaweedfs/weed master &
echo "Running SeaweedFS...starting volume server 1..."
/c/Development/seaweedfs/weed volume -dir="/c/Development/seaweedfs/data" -max=10  -mserver="localhost:9333" -port=7070 &
#echo "Running SeaweedFS...starting volume server 2..."
#/c/Development/seaweedfs/weed volume -dir="/c/Development/seaweedfs/data2" -max=10  -mserver="localhost:9333" -port=7071 &