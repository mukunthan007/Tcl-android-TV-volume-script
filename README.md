# Tcl-andorid-TV-volume-script

A simple bash script to disable the TV Quick Actions Pro app's accessibility for 10 seconds when the volume button is pressed, and then re-enable accessibility automatically after 10 seconds.

The reason for creating this script is that the TV Quick Actions Pro volume fix functionality is not working on my TCL Android TV, so I made this script as a workaround.

## Requirements
Download these files on PC or mobile.

Download the latest Termux APK with a name ending in +github-debug_universal.apk on Github - [Termux Github Release](https://github.com/termux/termux-app/releases) 

Download the latest Termux boot APK on github - [Termux Boot Github Release](https://github.com/termux/termux-boot/releases)

## Video Instructions For Setup
[link](https://youtu.be/ZvFDVr7B_94)

## Installation
Send these APK's files to TV through Send Files to TV app or any other apps.

Install both the APK's files and disable both apps energy optimisation by:

Setting -> Apps -> Special App Access - > Energy Optimisation -> turn off  both app.

Setting -> Apps -> Special App Access - > Display Over Other Apps -> turn on both apps.

## Usage

Open Termux app then and put this commands on TV
```bash
pkg update
pkg upgrade
mkdir ~/.termux/boot/  #do this after installing termux boot app on your TV
pkg install android-tools
pkg install openssh
passwd                 #set password for user
sshd
```
sshd command will create a openssh server to connect from your local devices

To find your TV IP address
```bash
ifconfig # will return IP Address in inet, for wifi get from wlan0 
```
For copying script to Android TV you have to install termux on mobile or use PC 

On mobile
```bash
pkg update
pkg upgrade
pkg install openssh
```
On windows install Openssh client application before using the ssh command

Do the below procedure for mobile setup also.

```bash
ssh 192.168.0.xxx -p 8022 # Your TV IP address
cd .termux/boot/ # go to boot folder to create a startup script
nano start-sshd.sh
nano volume-bash.sh
chmod +x start-sshd.sh
chmod +x volume-bash.sh
```

Paste the contents from volume-bash.sh and start-sshd.sh on this repo to the nano editor. Ctrl + X -> Y -> Enter to save the file.


Restart the Android TV to reflect the changes.

That's all

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.
