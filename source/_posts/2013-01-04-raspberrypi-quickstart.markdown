---
layout: post
title: "RaspberryPi Quickstart"
date: 2013-01-04 20:08
comments: true
categories: [raspberrypi]
---

I recently had the opportunity to purchase and setup a second RaspberryPi system. Here's a very brief shopping list and collection of links to get your own RaspberryPi system setup.

### Parts List

* [RaspberryPi](http://www.amazon.com/gp/product/B009SQQF9C/ref=oh_details_o01_s00_i01) - 512MB version
* [Enclosure for the RaspberryPi](http://www.amazon.com/gp/product/B008TCUXLW/ref=oh_details_o01_s01_i01) - Clear and contains cutous for all of the ports + GPIO pins.
* [WiFi Card](http://www.amazon.com/gp/product/B003X26PMO/ref=oh_details_o01_s01_i02) - Drivers are included in the latest Raspbian distribution.
* [8GB Class 10 SD card](http://www.amazon.com/gp/product/B003VNKNEG/ref=oh_details_o01_s01_i03) - Class 10 cards have a fast read / write speed.
* [USB A to USB MicroB cable](http://www.amazon.com/gp/product/B003ES5ZSW/ref=oh_details_o01_s00_i00) - The 'power cable' for the RaspberryPi
* [USB power supply](http://www.amazon.com/gp/product/B005CG2ATQ/ref=oh_details_o01_s01_i00) - High powered USB power supply to drive the RaspberryPi + WiFi card.
* [HDMI cable](http://www.amazon.com/AmazonBasics-High-Speed-HDMI-Cable-Meters/dp/B003L1ZYYM) - HDMI cable to connect to HDTV / monitor.

### Setting up the SD card

1. Download the latest [Rasbian linux image](http://www.raspberrypi.org/downloads).
2. Setup the SD card by following the [RPi Easy SD Card Setup](http://elinux.org/RPi_Easy_SD_Card_Setup) guide.

### Booting it all up

Plug everything in, boot up the system. If you're planning to SSH into the RaspberryPi via Ethernet (instead of using a keyboard/mouse/monitor) you'll have to log into your router and determine what it's IP address is.

The default RaspberryPi login is username ``pi`` with password ``raspberry``. You'll probably want to change this.

### Expanding the root partition

**Update: April 12th 2013**: Thanks to Conky (and Kevin) for suggesting this.

Once your RaspberryPi boots up, you'll want to adjust the root partition to take up the entire SD card. This will help prevent errors about the file system being full once you start updating packages and installing new packages:

    # Open the RaspiConfig tool:
    sudo raspi-config

    # Navigate to the "expand_rootfs" option and select it
    # Quit out of the raspi-config screen

    # Reboot the system:
    sudo shutdown -r now

### Setting up the WiFi

Assuming everything booted up okay, you're ready to setup the wireless. To setup the wireless card to connect to your WPA/WPA2 secured wireless network, edit ``/etc/network/interfaces`` and add this to the bottom of the file. You may need to remove some existing configuration for ``wlan0``.

    allow-hotplug wlan0
    auto wlan0
    iface wlan0 inet dhcp
        wpa-ssid YOUR_SSID
        wpa-psk YOUR_PASSWORD

Save this file, and run:

    sudo ifdown wlan0
    sudo ifup wlan0

Run ``ifconfig`` and you should see that ``wlan0`` has an IP address.

### Setting up NTP

Accurate time is useful.

    sudo apt-get install ntpdate
    sudo ntpdate -u ntp.ubuntu.com

### Updating Raspbian OS

After everything is setup you'll probably want to update Raspbian to the latest packages and version.

    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get dist-upgrade


### Updating the RaspberryPi's firmware

To update the firmware to the latest version, we'll use [Hexxeh's rpi-update script](https://www.github.com/Hexxeh/rpi-update).

    sudo apt-get install git-core
    sudo wget http://goo.gl/1BOfJ -O /usr/bin/rpi-update && sudo chmod +x /usr/bin/rpi-update
    sudo rpi-update

### You're done!

At this point you should be completely setup and operational.

If you had any troubles with this please let me know in the comments.

### More reading

Here are some resources to do further reading:

* [http://elinux.org/RPi_Community](http://elinux.org/RPi_Community)
* [http://www.raspberrypi.org/phpBB3/](http://www.raspberrypi.org/phpBB3/)
* Should I add a link here? Let me know.

