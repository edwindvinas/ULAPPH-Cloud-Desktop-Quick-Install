# ULAPPH Cloud Desktop - Quick Install
This repo contains scripts used to install/setup ULAPPH Cloud Desktop based on the target platform. Please select the platform for you.

## Google Cloud Compute Engine (GCE) VM with Ubuntu Linux
This will install ULAPPH in a Virtual Machine (VM) in Google Cloud - Compute Engine (GCE) with Ubuntu Linux.

NOTE: Do this step only on a fresh VM. It assumes your VM is fresh and doesn't have Golang or anything installed yet.
```
cd $home && rm goinstall.sh* \
  && wget https://raw.githubusercontent.com/edwindvinas/ULAPPH-Cloud-Desktop-Quick-Install/main/goinstall.sh \
  && chmod +x ./goinstall.sh \
  && ./goinstall.sh
```

