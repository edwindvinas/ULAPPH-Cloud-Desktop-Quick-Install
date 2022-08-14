# ULAPPH Installation in Android Termux
===============
- Welcome to ULAPPH Installation Guide for Android
- Turn your Android into a frontend and backend server
- Basically, we will install Termux in your Android
- Then, using Termux, we will install ULAPPH-Android-Desktop (an Android version of ULAPPH-Cloud-Desktop)

# STEP1: Install F-Droid
- Go to Android, open browser, search "f-droid" and open f-droid site
```
https://f-droid.org/
```
- You need to increase the timeout of your Android screen since some commands being executed may take some time.

# STEP2a: Install Termux in Android
- Do not install from Google Playstore
- Install from F-Droid
- Open F-Droid app
- Search & Install "Termux"

# STEP2b: Install Termux-API in Android
- Do not install from Google Playstore
- Install from F-Droid
- Open F-Droid app
- Search & Install "Termux-API"

# STEP2c: Install Termux-Widget in Android
- Do not install from Google Playstore
- Install from F-Droid
- Open F-Droid app
- Search & Install "Termux-Widget"
- Enable the "Display over other apps" permission

# STEP2d: Setup Fingerprint in Android 
- Running ULAPPH requires fingerprint auth, we need to setup fingerprint in Android. 

# STEP3: Optional: Install Hacker's Keyboard
- If you have relatively new Android device, no need to perform this.
```
https://play.google.com/store/apps/details?id=org.pocketworkstation.pckeyboard&hl=fil&gl=US
```

# STEP4: Optional: Install Git bash terminal in Windows
- If you don't want to ssh from Windows to Android, skip to STEP8.
- But, as per experience, it's too much faster if you will connect to your Android via ssh.
```
https://git-scm.com/download/win
```

# STEP5a: Install ssh in Termux
- Refer to the following page for more info
```
https://wiki.termux.com/wiki/Remote_Access
```
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
```

# STEP5b: Connecting to Android via SSH
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
```
https://chiark.greenend.org.uk/~sgtatham/putty/latest.html
```

# STEP7: Optional: Connect a bluetooth keyboard to your Android
- This is good so that it will be easier to type the commands.
- If no bluetooh keyboard, you can still perform the steps in your Android touch screen.

# STEP8: Install git, bc and jq in Termux
```
$ pkg install git
$ pkg install bc
$ pkg install jq
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
- These commands maybe challenging to type in your Android, so it is better to use SSH terminal.
- Please refer to STEP5 if you would want to use SSH. Otherwise, please proceed below.
```
$ cd ~
$ mkdir -p ~/go/src/github.com/edwindvinas/
$ cd ~/go/src/github.com/edwindvinas/
$ git clone https://github.com/edwindvinas/ULAPPH-Cloud-Desktop-Quick-Install.git 
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

# STEP12: Install ULAPPH dependencies
```
$ cd ~
$ source setalias_ulapph.sh
$ dev
$ chmod +x gogetall.sh
$ ./gogetall.sh
```

# STEP13: Updating the YAML configuration 
- You need to update YAML configuration to specify special config settings.
```
$ cd ~
$ source setalias_ulapph.sh
$ cfg
$ vim ulapph-demo-android.yaml
   - item: SYS_FIXED_IP_ADDRESS
     format: Text
     status: Enable
     value: 192.168.1.125
	 
   - item: SYS_STATIC_FOLDER_PATH_INDEX
     format: Text
     status: Enable
     value: /data/data/com.termux/files/home/storage/

   - item: SYS_ULAPPH_DATA_FOLDER_PATH
     format: Text
     status: Enable
     value: /data/data/com.termux/files/home/storage/ulapph/ulapph-data

   - item: SYSTEM_CUSTOM_SEARCH_TEMPLATE
     format: Text
     status: Enable
     value: custom-search-acn.txt

   - item: SYS_FINGERPRINT_ENABLED
     format: Flag
     status: Enable
     value: true

   - item: SYS_DEVICE_INFO
     format: Text
     status: Enable
     value: OPPO F7 / Android 10 / Termux

```

# STEP14: Generate server certificates for your ULAPPH server
```
$ cd ~
$ source setalias_ulapph.sh
$ dev
$ ./gen_ssl_certs.sh
```

# STEP15: Optional - Setup your wallpaper folder
```
$ cd ~
$ source setalias_ulapph.sh
$ dev
$ mkdir -p static/img/wallpapers
```

# STEP16: Super Optional - Index Android images
- You only need this if you want to create a static site for browsing Android contents
```
$ cd ~
$ source setalias_ulapph.sh
$ dep
$ vim termux_index_android_files.sh
HOME="/data/data/com.termux/files/home/storage/"
HOME_DATA="/data/data/com.termux/files/home/storage"
$ ./termux_index_android_files.sh
```

# STEP17: Super Optional - Setup crontab
- You only need this if you want to run crontabs for say running the script in step above. 
```
$ pkg install cronie
$ crontab -e
asterisk/15 * * * * cd /data/data/com.termux/files/home/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop-Quick-Install/ && ./termux_index_android_files.sh
```

# STEP18: Run build/deploy script
- Once everything is setup, you can initially build/deploy now!
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
 
# STEP19: Test if ULAPPH is running
- Go to browser in Android or PC
- Make sure to use your own IP address
https://192.168.1.125:8443
- This will open the simple ULAPPH tools page

# STEP20: If fingerprint is enabled, you will be prompted with Fingerprint Login 
- Go to Android device and do fingerprint check.
- Make sure Termux CLI is running in front as active app

# STEP21: Adding the Termux Widget 
- If you have widgets, you can execute commands directly from widget.
- For example for enabling disabling  ULAPPH system, sshd, file manager or syncthing etc...
- You can even use the widget for executing automatic upgrade...
- These commands are available as in Termux Android widget:
```
./ai:
ulapphspeak.sh

./crontab:
crontab.txt  crontab_disable.sh  crontab_enable.sh

./filebrowser:
filebrowser.db  filebrowser_disable.sh  filebrowser_enable.sh

./ssh:
ssh_disable.sh  ssh_enable.sh

./syncthing:
syncthing_disable.sh  syncthing_enable.sh

./ulapph:
run_ulapph.sh  stop_ulapph.sh  update_ulapph.sh

```

# STEP22: Executing shortcut commands via CLI 
- For example, to upgrade ULAPPH via CLI
- But it would be convenient to use the Termux Widget
```
$ cd ~
$ source setalias_ulapph.sh
$ short
$ ls -la
total 32
drwx------ 9 u0_a257 u0_a257 3452 Aug  7 02:50 .
drwx------ 8 u0_a257 u0_a257 3452 Aug  7 04:19 ..
drwx------ 2 u0_a257 u0_a257 3452 Aug  7 02:50 ai
drwx------ 2 u0_a257 u0_a257 3452 Aug  7 02:50 crontab
drwx------ 2 u0_a257 u0_a257 3452 Aug  7 02:50 filebrowser
drwx------ 2 u0_a257 u0_a257 3452 Aug  7 02:50 ssh
drwx------ 2 u0_a257 u0_a257 3452 Aug  7 02:50 syncthing
drwx------ 2 u0_a257 u0_a257 3452 Aug  7 02:50 tasks
drwx------ 2 u0_a257 u0_a257 3452 Aug  7 02:50 ulapph
$ cd ulapph
$ ./update_ulapph.sh
```

# STEP23: Running & Accessing the File Manager webapp
- At this point, the opensource File Browser has been installed
```
https://github.com/edwindvinas/filebrowser
```
- Go to the Termux Widget
- To run the File Browser aka File Manager, you can use the following from the Widget:
```
-rwx------ 1 u0_a290 u0_a290 65536 Aug  6 14:18 filebrowser.db
-rwx------ 1 u0_a290 u0_a290   298 Aug  6 14:18 filebrowser_disable.sh
-rwx------ 1 u0_a290 u0_a290   568 Aug  6 14:18 filebrowser_enable.sh
```
- To access the File Manager
```
http://192.168.1.125:9090
```

# STEP24: Running and Accessing the SyncThing webapp
- To run the SyncThing, you can use the following from the Widget:
```
-rwx------ 1 u0_a290 u0_a290  291 Aug  6 14:18 syncthing_disable.sh
-rwx------ 1 u0_a290 u0_a290  570 Aug  6 14:18 syncthing_enable.sh
```
- To access the File Manager
```
https://192.168.1.125:8334
```


#######################################################
# OPTIONAL STEPS
######################################################

# Launching a Termux Desktop via VNC viewer
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
(not working yet)
```
# Thank you!
