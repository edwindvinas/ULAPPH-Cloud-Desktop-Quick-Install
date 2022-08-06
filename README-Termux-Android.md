### ULAPPH Installation in Android Termux

Installation Guide for Android
===============

# STEP1: Install F-Droid
- Go to Android, open browser, search "f-droid" and open f-droid site
https://f-droid.org/
- You need to increase the timeout of your Android screen since some commands being executed may take some time.

# STEP2: Install Termux in Android
- Do not install from Google Playstore
- Install from F-Droid
- Open F-Droid app
- Search & Install "Termux"

# STEP3: Optional: Install Hacker's Keyboard
- If you have relatively new Android device, no need to perform this.
https://play.google.com/store/apps/details?id=org.pocketworkstation.pckeyboard&hl=fil&gl=US

# STEP4: Optional: Install Git bash terminal in Windows
- If you don't want to ssh from Windows to Android, skip to STEP8.
https://git-scm.com/download/win

# STEP5: Install ssh in Termux
https://wiki.termux.com/wiki/Remote_Access
- Open Termux & execute the following commands:
```
$ apt update && apt upgrade
- On first prompt, enter Y. On second and third prompt, just press Enter.
$ pkg install openssh
- On prompt, enter Y.
$ sshd
$ passwd
$ whoami
- Take note of the username. Example: u0_a290
$ ifconfig
- Take note of the IP address beside inet. Example: 192.168.1.51

# Connecting to Android via SSH
- To connect from Windows Gitbash to your Android, we need to setup proper ssh keys.
- This involves copying your Windows ssh keys to Android.
- On Windows terminal such as Git bash:
```
$ ssh-keygen -t rsa -b 2048 -f id_rsa
$ cd ~/.ssh
$ ls -la id_rsa*
$ ssh-copy-id -p 8022 -i id_rsa u0_a290@192.168.1.51
```

- Sample Output from Windows GitBash.
```
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "id_rsa.pub"
The authenticity of host '[192.168.1.125]:8022 ([192.168.1.125]:8022)' can't be established.
ED25519 key fingerprint is SHA256:RAhKshLsEEQQlocGYP38RCQXJIDgETCOCrGJ7PxVFPg.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
u0_a257@192.168.1.125's password:

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh -p '8022' 'u0_a257@192.168.1.125'"
and check to make sure that only the key(s) you wanted were added.
```
- You can now test ssh connection. Make sure to use the exact user and IP address
```
$ ssh -p 8022 u0_a290@192.168.1.51
```
# STEP6: Optional: Use Putty to connect to SSH from Windows
- To connect to the Android Termux via Putty
- Make sure to indicate SSH port 8022
https://chiark.greenend.org.uk/~sgtatham/putty/latest.html

# STEP7: Optional: Connect a bluetooth keyboard to your Android
- This is good so that it will be easier to type the commands.
- If no bluetooh keyboard, you can still perform the steps in your Android touch screen.

# STEP8: Install git in Termux
```
$ pkg install git
```

# STEP9: Install Golang in Termux
```
$ pkg install golang
$ go version
go version go1.18.3 android/arm64
- If you see above output, that means golang is installed.
```

# STEP10: Download the Quick Install repo from Google Cloud Sources Repository
- If you have no access to Google Cloud Sources Repository, skip to STEP11.
- First, go to Google Cloud Source Repositories to "Generate and store your Git credentials".
```
$ cd ~/go/src/github.com/edwindvinas/
$ git clone https://source.developers.google.com/p/edwin-daen-vinas/r/ULAPPH-Cloud-Desktop-Quick-Install
$ cd ~/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop-Quick-Install
$ ./ulapph_download_initial_setup.sh
$ ls -la ~/go/src/github.com/edwindvinas/
drwx------  9 u0_a4 u0_a4     3488 Aug  1 01:22 ULAPPH-Cloud-Desktop
drwx------  4 u0_a4 u0_a4     3488 Aug  1 01:18 ULAPPH-Cloud-Desktop-AI
drwx------  3 u0_a4 u0_a4     3488 Aug  1 01:18 ULAPPH-Cloud-Desktop-CTL
drwx------  4 u0_a4 u0_a4     3488 Aug  1 01:18 ULAPPH-Cloud-Desktop-Configs
drwx------  9 u0_a4 u0_a4     8192 Aug  1 01:30 ULAPPH-Cloud-Desktop-Quick-Install
drwx------  4 u0_a4 u0_a4     3488 Aug  1 01:18 ULAPPH-Cloud-Desktop-WP
drwx------  3 u0_a4 u0_a4     3488 Aug  1 01:18 ULAPPH-Cloud-Desktop-Watson
```

# STEP11: Download the Quick Install repo from Github.
```
$ cd ~
$ mkdir -P ~/go/src/github.com/edwindvinas/
$ cd ~/go/src/github.com/edwindvinas/
$ git clone https://source.developers.google.com/p/edwin-daen-vinas/r/ULAPPH-Cloud-Desktop-Quick-Install
$ cd ~/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop-Quick-Install
$ ./ulapph_download_initial_setup.sh
$ ls -la ~/go/src/github.com/edwindvinas/
drwx------  9 u0_a4 u0_a4     3488 Aug  1 01:22 ULAPPH-Cloud-Desktop
drwx------  4 u0_a4 u0_a4     3488 Aug  1 01:18 ULAPPH-Cloud-Desktop-AI
drwx------  3 u0_a4 u0_a4     3488 Aug  1 01:18 ULAPPH-Cloud-Desktop-CTL
drwx------  4 u0_a4 u0_a4     3488 Aug  1 01:18 ULAPPH-Cloud-Desktop-Configs
drwx------  9 u0_a4 u0_a4     8192 Aug  1 01:30 ULAPPH-Cloud-Desktop-Quick-Install
drwx------  4 u0_a4 u0_a4     3488 Aug  1 01:18 ULAPPH-Cloud-Desktop-WP
drwx------  3 u0_a4 u0_a4     3488 Aug  1 01:18 ULAPPH-Cloud-Desktop-Watson
```

# Copy shortcut scripts scripts
```
$ cd ~/go/src/github.com/edwindvinas/ULAPPH-Android-Desktop-Quick-Install/scripts-termux
$ ls -la
$ cp * ~/
$ cd ~
```

# Install default go/bin executables
```
$ dep
$ cd go-bin
$ cp * ~/go/bin/
```

# Update shortcut scripts
```
$ pkg install vim
$ vim run_ulapph.sh
$ vim setalias_ulapph.sh
$ vim stop_ulapph.sh
$ source setalias_ulapph.sh
$ dep
$ dev
$ ctl
$ ai
$ cfg
```

# Setup Termux Storage
https://wiki.termux.com/wiki/Termux-setup-storage
First, go to Android settings and grant permission to Termux.
Then, restart Android so permission will take effect.
```
$ termux-setup-storage
$ cd ~/storage/
$ mkdir ulapph
$ cd ~/storage/ulapph/
$ mkdir ulapph-data
```

# Setup Termux API
https://wiki.termux.com/wiki/Termux:API
First, Download the Termux:API add-on from F-Droid or the Google Play Store. It is required for the API implementations to function.
```
$ pkg install termux-api
```

# Install ULAPPH dependencies
```
$ dev
$ chmod +x gogetall.sh
$ ./gogetall.sh
```

$ vim ulapph-demo-android.yaml
# Example of config items that you need to update
# If stateless, use a fix IP where this server runs
   - item: SYS_FIXED_IP_ADDRESS
     format: Text
     status: Enable
     value: 192.168.1.125
	 
   - item: SYS_STATIC_FOLDER_PATH_INDEX
     format: Text
     status: Enable
     value: /data/data/com.termux/files/home/storage/
```

# Generate server certificates
```
$ dev
$ pkg install openssl
$ pkg install openssl-tool
$ openssl genrsa -des3 -passout pass:x -out server.pass.key 2048
$ openssl rsa -passin pass:x -in server.pass.key -out server.key
$ openssl req -new -key server.key -out server.csr
$ openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
```

# Setup wallpaper folder
```
$ dev
$ mkdir -p static/img/wallpapers
```

# Index Android images
```
$ dep
$ vim termux_index_android_files.sh
HOME="/data/data/com.termux/files/home/storage/"
HOME_DATA="/data/data/com.termux/files/home/storage"
$ ./termux_index_android_files.sh
```

# Setup crontab
```
$ crontab -e
$ pkg install cronie
*/15 * * * * cd /data/data/com.termux/files/home/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop-Quick-Install/ && ./termux_index_android_files.sh
```

# Run build/deploy script
```
$ deploy-android
Welcome to ULAPPH Cloud Desktop - Quick Installation Tool
Installing ulapph cloud desktop...
Number of targets: 1
Installing [0/1]...  ulapph-demo-android
======================================
Backing up main.go
*** Installation Type is ANDROID ***
Configuring project:  ulapph-demo-android
Configuration used:  ulapph-demo-android
/data/data/com.termux/files/home/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop-Configs/ulapph-demo-android.yaml
Please wait... this may take a while...
 2731 / 90731 [====>----------------------------------]   3.01% 01m56
```
 
# Test if ULAPPH is running
Go to browser in Android or PC
https://192.168.1.125:8443

# Fingerprint Login 
Go to Android device and do fingerprint check.

# Upgrading to the latest version
$ cd ~
$ ./update_ulapph.sh

#######################################################
# OPTIONAL STEPS
######################################################

# Optional Termux Desktop
https://github.com/adi1090x/termux-desktop
```
$ cd ~
$ git clone --depth=1 https://github.com/adi1090x/termux-desktop.git
$ cd termux-desktop
$ chmod +x setup.sh
$ ./setup.sh --install
$ startdesktop
```
Install VNC server from your desktop...
IP: 192.168.1.125:5901

# Optional: Install NGROK for Termux
https://wiki.termux.com/wiki/Bypassing_NAT#Ngrok
```
$ pkg install openssh
$ ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa
```
Add ssh public key here:
https://dashboard.ngrok.com/auth/ssh-keys/new
Sample: ssh -R 0:localhost:${PORT} tunnel.us.ngrok.com tcp ${PORT}
```
ssh -R 0:localhost:8443 tunnel.us.ngrok.com tcp 80443
(not working)
```

Sample Commands
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
