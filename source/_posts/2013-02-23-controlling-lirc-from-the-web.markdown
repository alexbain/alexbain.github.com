---
layout: post
title: "Controlling LIRC from the web"
date: 2013-02-23 13:06
comments: true
categories: [raspberrypi, javascript, nodejs, lirc]
---

In this post I will cover how to create a web interface + API for [LIRC](http://lirc.org), the Linux Infrared Remote Control project. I will be using NodeJS and a RaspberryPi in this post, but the ideas generalize to other languages and hardware. This post will serve as Part 3 of my open source universal remote project posts. If you haven't had an opportunity to read the first two posts, I suggest checking out [Universal remote experiments](/blog/2012/07/08/universal-remote-experiments/) (Part 1) and [Setting up LIRC on the RaspberryPi](/blog/2013/01/06/setting-up-lirc-on-the-raspberrypi) (Part 2) before proceeding. You may also want to read [Installing NodeJS on your RaspberryPi](/blog/2013/01/15/installing-nodejs-on-your-raspberrypi), where I cover installing NodeJS.

If you're completely new to the RaspberryPi and want to learn more I wrote a [RaspberryPi Quickstart](/blog/2013/01/04/raspberrypi-quickstart) post which covers everything from purchasing the parts to configuring the WiFi. Check that out if you're new to the RaspberryPi ecosystem.

With that out of the way, let's get started!

<img src="/images/posts/universal-remote/ir-leds.jpg" class="center" />


### Why a web interface + API?

LIRC is an awesome open source project that handles all of the low level requirements of sending and receiving Infrared commands from a Linux computer. It's well documented, well supported, and thanks to the work of the open source community there is now a ``lirc_rpi`` driver included in the latest version of RaspbianOS. This means that, as long as you're running a RaspberryPi with the latest OS and firmware, LIRC can interface with the RaspberryPi GPIO pins. Fantastic.

Once you have LIRC installed and configured (which I cover in my [Setting up LIRC on the RaspberryPi](/blog/2013/01/06/setting-up-lirc-on-the-raspberrypi) post), you can use LIRC executables like [irsend](http://www.lirc.org/html/irsend.html) and [irrecord](http://www.lirc.org/html/irrecord.html) to send and record IR commands for all your IR devices - right from the command line! This is great fun, but not very user friendly.

I wanted a way to control LIRC from the web. I wanted a web application that enabled me to interact with LIRC from any web connected device. If I had that, I could create a mobile web app for my phone, a regular web app for a desktop, and a RESTful API for web services. The API would give me a way to connect LIRC with any external web service - opening the door for future integrations. All I needed to do was find a way to call LIRC commands from within a web application.

Which brings us to the meat of this post. Getting NodeJS and LIRC to talk.

<img src="/images/posts/universal-remote/breadboard-wires.jpg" class="center" />

### Getting LIRC and NodeJS to talk

To make LIRC usable from the web I needed a client library in a language I could build a web application in. The client library would provide some way to make calls from the web application to LIRC. This would give me the building blocks I needed to build a web application. The usual web languages include PHP, Python, Ruby, and NodeJS.

For this project I chose to work in NodeJS. If you would prefer to implement a web application in a different language, I found two existing LIRC client libraries. Sadly, neither seem maintained. I found [lircr](https://github.com/fugalh/lircr) for Ruby and [pyLirc](http://sourceforge.net/projects/pylirc/) for Python.

Since I could not find an existing NodeJS LIRC client library, and the existing libraries I did find were not up to date, I built my own. I created [lirc_node](https://github.com/alexbain/lirc_node), a lightweight NodeJS client library that interfaces with LIRC. v0.0.1 of ``lirc_node`` only supports ``irsend``. This allows you to send IR commands to devices that LIRC knows about.

Before trying to install and use ``lirc_node`` make sure you have completed these steps:

* Purchased, setup, and configured a RaspberryPi to join a network
* Wired up an IR LED and an IR Receiver to your RaspberryPi
* Installed and configured LIRC to interface with your IR LED and IR Receiver
* Programmed LIRC to understand your remote controls
* Installed NodeJS on your RaspberryPi

If you have not completed all of those steps scroll back to the top of this post and check out my earlier posts. I have written detailed step by step guides to get you through each of those steps.

All caught up? Great! We're ready to install a basic web application for LIRC.

<img src="/images/posts/universal-remote/ir-receiver.jpg" class="center" />

### Creating a NodeJS web application using ``lirc_node`` and ``lirc_web``

The easiest way to setup a NodeJS web application using ``lirc_node`` is to use v0.0.1 of [lirc_web](https://github.com/alexbain/lirc_web), a sample NodeJS application I wrote as a proof of concept for ``lirc_node``. This web application is extremely basic, and only proves that ``lirc_node`` works. I have plans to grow this application with additional functionality and an improved interface. You may also use the basic API included in this web application to connect your universal remote with services like [Tasker](https://play.google.com/store/apps/details?id=net.dinglisch.android.taskerm&hl=en) or [IFTTT](https://ifttt.com/).

To download and install [lirc_web](https://github.com/alexbain/lirc_web):

    wget https://github.com/alexbain/lirc_web/archive/master.zip
    unzip master.zip
    mv lirc_web-master lirc_web
    rm master.zip
    cd lirc_web
    npm install
    node app.js

That should do it. Now, visit ``http://raspberrypi:3000/`` (or the IP address of your RaspberryPi) to confirm the sample web application shows all of the remotes and commands LIRC knows about. Clicking any of the links will tell LIRC to send that IR command via the API endpoint.

<img src="/images/posts/universal-remote/lirc_web.jpg" class="center" />

**November 2nd 2013 Update:** I have posted a follow up post that discusses how to ensure the ``lirc_web`` project automatically starts on boot and is accessible via port 80. Check out [Running lirc_web with Nginx and Upstart](http://alexba.in/blog/2013/11/02/lirc-web-nginx-and-upstart/) to learn more.

### Success!

At this point, assuming you've been able to get each step working, you should have a web application you can use to control any IR device that LIRC knows about.


### What's next?

In the coming months I hope to:

* Create an open hardware schematic and PCB board that anyone can use for the hardware.
* 3D print an enclosure for the RaspberryPi + expansion board.
* Improve the web application and give it a proper mobile web interface.
* Write about how to connect [lirc_web](https://github.com/alexbain/lirc_web) to Tasker or IFTTT.

If you have any questions, suggestions, or run into any issues - please let me know.

