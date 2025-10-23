
2025-10-10 17:54

Status: #child

Tags: [[RaspberryPi]] [[VIM]] [[BTOP]] [[Networking]] [[BSLI]] 

# Setting up a Raspberry Pi 3 Model B

Raspberry Pis are remarkably versatile and user-friendly computing modules capable of serving countless purposes. Common applications include use as a home server, media manager, data acquisition device, 3D printer interface, robot controller, and many more innovative projects.

This document outlines the steps I followed to image the Raspberry Pi with an operating system (OS), set up the Vim text editor, and install Btop, a powerful command-line system resource monitor and more!

Before you begin Make sure you have the following:
1. 5V power source
2. SD Card 35GB+ recommended
3. HDMI or Mini HDMI
4. Keyboard and Mouse

Step 1: Install the Operating System
	1. Download and open the Raspberry Pi Imager application.
	2. Select your Raspberry Pi device, choose the desired Operating System, and specify the storage device.
	3. Configure the advanced settings, including username, password, and SSH options.
	4. Once configured, click OK and proceed to write the OS to the SD card.
	5. After completion, insert the SD card into your Raspberry Pi and boot the OS.

Step 2: Install Vim

Update your package list and install Vim by running:

```
sudo apt update

sudo apt install vim

```


Step 3: Install Btop

Install Btop for real-time system monitoring with:

```
sudo apt install btop
```

To launch the monitor, simply run:

```
btop
```


Step 5: Install Pi-Apps

```
wget -qO- https://raw.githubusercontent.com/Botspot/pi-apps/master/install | bash
```

Install Flameshot from Pi-Apps

## References

BTO Tutorial
https://www.youtube.com/watch?v=0B-a3DIRTgY&t=67s

Docker Tutorial
https://pimylifeup.com/raspberry-pi-docker/

[[BSLI Raspberry Pi Data Acquisition Server]]

Pi-apps:
https://pi-apps.io/install/
