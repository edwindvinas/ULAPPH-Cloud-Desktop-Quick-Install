	# quick-install-ulapph
Shell script to quickly install ulapph cloud desktop
- It will generate the source codes for your project ID
- Process your config yaml file to update your source codes
- Call gcloud to install the generated codes

# Shortcut:
* Given your clone is found in your current directory 
```
- cd ULAPPH-Cloud-Desktop-1 
- vim main.go
```

* Now instll your changes in main.go or any static files
```
- cd ..
- cd quick-install-ulapph
- ./quick_install_ulapph.sh
```

* Wait while the installation is in progress
- Once done, check your project URL if changes took effect

# Directory Structure
- Sample: In my google cloud shell
- My Home DIR:
```
/home/edwin_d_vinas/ulapph
```

- Inside this home, I have the following folders:
```
drwxr-xr-x  3 edwin_d_vinas edwin_d_vinas 4096 May  9 08:43 quick-install-ulapph
drwxr-xr-x  6 edwin_d_vinas edwin_d_vinas 4096 May  4 03:02 ULAPPH-Cloud-Desktop-1
drwxr-xr-x  2 edwin_d_vinas edwin_d_vinas 4096 Apr 17 22:28 ULAPPH-Cloud-Desktop-Configs
drwxr-xr-x  3 edwin_d_vinas edwin_d_vinas 4096 Mar 25 18:57 ULAPPH-Cloud-Desktop-CTL
```

- After editing the main.go, just go to where your "quick_install_ulapph.sh" script is and excute the installation by one command

```
./quick_install_ulapph.sh
```

- And to further simplify code and deployment
```
alias dep='cd ~/ulapph/quick-install-ulapph'
alias dev='cd ~/ulapph/ULAPPH-Cloud-Desktop-1'
```

- To code, type "dev"
```
dev
vim main.go
```

- To deploy changes
```
dep
./quick_install_ulapph.sh
```

- Or to deploy to a test server
```
dep
./test_quick_install_ulapph.sh
```

