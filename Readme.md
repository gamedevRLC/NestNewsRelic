# Disable  Screen Saver
Edit /etc/lightdm/lightdm.conf to add the following lines at the end of the file:

[SeatDefaults]

xserver-command=X -s 0 -dpms


# Launch Binary on startup
Edit /home/pi/.config/lxsession/LXDE-pi/autostart

Add the following to the end of the file(or adjust to the path of the binary)

@/home/pi/NestNewsBin/NestNews

# Allow HDMI CEC Connection

install the cec utility

sudo apt-get install cec-utils

Edit /boot/config.txt to add the following lines to the end of the file

hdmi_force_hotplug=1

now the following commands can be used to turn the tv on and off

On: echo on 0 | cec-client -s -d 1

Off: echo standby 0 | cec-client -s -d 1

# Modifications after copying files
Upon copying the NestNews Folder to /home/pi of the target device you may need to modify two files if you copied the files using a nont ext3 formatted device. 
You will need execution bits set for the following files

NestNewsBin/NestNews 

NestNewsBin/java/bin/java

run the following commands to add the executable bit

chmod +x NestNewsBin/NestNews 

chmod +x NestNewsBin/java/bin/java

You should now be able to run the NestNews executable.
