---
layout: post
title: "Use your RaspberryPi to power a company dashboard"
date: 2013-01-07 15:51
comments: true
categories: [raspberrypi]
---

Here are five steps to follow if you want to start using a RaspberryPi to power a company dashboard. I've just finished putting this together at my office. We're using [Geckoboard](http://www.geckoboard.com) for the web interface:

<img class="center" src="/images/posts/raspberrypi-dashboard.jpg" />

<img class="center" src="/images/posts/raspberrypi-dashboard-2.jpg" />

### 0: Make sure your RaspberryPi is fully updated

Before you get started I highly recommend you follow my [RaspberryPi Quickstart](/blog/2013/01/04/raspberrypi-quickstart/) guide to get your RaspberryPi updated to the latest OS and Firmware. That post also includes links to the case and peripherals I purchased for this project.

### 1: Install Chromium

First, you'll want to install Chromium on your RaspberryPi. We'll be using Chromium to load the dashboard. I've also included the ``ttf-mscorefonts-installer`` package so things render nicely.

    sudo apt-get install chromium ttf-mscorefonts-installer

### 2: Boot into X11 automatically

You'll want to make sure your RaspberryPi immediately boots into X11.

    sudo raspi-config

Scroll down to ``boot_behavior`` and hit enter. Make sure "Yes" is marked and hit enter again.

You're done here, so scroll to Finish (right arrow key) and hit enter.

### 3: Start Chromium on boot

Third, you'll want to make sure Chromium starts in kiosk (full screen, no user interface) as soon as your RaspberryPi boots up.

Create (or modify) ``~/.config/lxsession/LXDE/autostart`` and add the line:

    chromium --kiosk http://url_to_your_dashboard.com --incognito

Kiosk mode boots Chromium into full screen mode, by default. Incognito mode prevents a "Chrome did not shutdown cleanly" message from appearing on the top if the RaspberryPi loses power.

### 4: Make sure the screen does not go to sleep

Dashboards aren't very useful if the screen goes into standy after ten minutes.

Edit ``/etc/xdg/lxsession/LXDE/autostart`` and make sure the ``@xscreensaver`` line is commented out. In addition, we'll be adding three options that prevent the screen from going blank:

    #@xscreensaver -no-splash
    @xset s off
    @xset -dpms
    @xset s noblank

I also needed to modify ``/etc/lightdm/lightdm.conf``. Add this line to the ``[SeatDefaults]`` section:

    xserver-command=X -s 0 dpms

### 5: Hide the mouse cursor

There's no reason to keep the mouse cursor stuck in the middle of the screen.  We'll use the unclutter utility to hide it after boot.

    sudo apt-get install unclutter

You'll need to add this to your ``~/.config/lxsession/LXDE/autostart`` file:

    unclutter -idle 0

### Enjoy!

Reboot your RaspberryPi and it should:

* Boot directly into X11
* Start Chromium in kiosk mode and load up your dashboard
* Prevent the screen from going to sleep after 10 minutes
* Hide the mouse cursor

Please let me know if you have any questions or comments.
