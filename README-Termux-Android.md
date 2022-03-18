### ULAPPH Installation in Android Termux

Pre-Requisites
===============

# Install Termux in Android
https://play.google.com/store/apps/details?id=com.termux&hl=en_US&gl=US

# Install ssh in Termux
https://wiki.termux.com/wiki/Remote_Access

Installation
===============

# Get IP Address of Termux
```
$ ifconfig
```

# Get Username of Termux
```
$ whoami
```

# Install SSH in Android Termux
```
apt update && apt upgrade
```

# SSH to Android Termux
```
$ ssh u0_a79@192.168.1.44 -p 8022
```

# Install and Run ULAPPH
```
$ ssh u0_a79@192.168.1.44 -p 8022
```

# Install NGROK for Termux
https://steemit.com/utopian-io/@faisalamin/how-to-download-install-ngrok-in-android-termux-also-work-for-non-rooted-devices