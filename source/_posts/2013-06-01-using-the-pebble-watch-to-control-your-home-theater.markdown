---
layout: post
title: "Using a RaspberryPi and Pebble Watch to control your home theater"
date: 2013-06-01 13:23
comments: true
categories: [RaspberryPi, Pebble, project]
---

This post will serve as a guide to using a [RaspberryPi](http://www.raspberrypi.org/), a [Pebble Watch](http://getpebble.com/), and an Android phone ([Google Nexus 4](http://www.google.com/nexus/4/)) to control your home theater from your wrist. The result is something like this:

<img src="/images/posts/open-source-universal-remote-pebble-watch.jpg" height="450px" width="600px" class="center" />

### Introduction

For a bit of backstory, around eighteen months ago I decided to start experimenting with and teaching myself electronics. I started working with an [Arduino Uno](http://arduino.cc/en/Main/arduinoBoardUno) and eventually moved to a [RasperryPi](http://www.raspberrypi.org). I wanted to build open hardware, open source, web connected devices and these seemed like the right tools for the job. I wanted to ensure that every device I built could, down the road, be controlled in entirely new ways with novel human computer interfaces like the [Pebble Watch](http://getpebble.com), [Thalmic Labs Myo](https://www.thalmic.com/myo/?autoplay=true), [Emotiv EPOC EEG Headset](http://www.emotiv.com/), [Leap Motion](https://www.leapmotion.com/), [Google Glass](http://www.google.com/glass/start/), and others.

So, after some consideration, I chose to build a RaspberryPi powered device that controls all of the infrared devices in my home. This project has turned into the [Open Source Universal Remote](http://opensourceuniversalremote.com), an open hardware/open source device you can make yourself with a RaspberryPi and $10 of electronic parts. This post will discuss how I wired up my Pebble Watch to control my Open Source Universal remote using my Android phone.

Let's get started!

### Outline

* Part 0: How it Works
* Part 1: Open Source Universal Remote
* Part 2: The Android Phone
* Part 3: The Pebble Watch
* Part 4: Conclusion / What's next

### Part 0: How it Works

At a high level, the project works like this:

0. User taps button on Pebble Watch.
1. Pebble Watch tells Android phone that a button has been tapped.
2. Android phone makes web request to Open Source Universal Remote API.
3. Open Source Universal Remote receives web request and sends out infrared pulses.
4. Home theater device detects infrared pulses and responds accordingly.

I'll work backwards from the Open Source Universal Remote to the Pebble Watch.

### Part 1: Open Source Universal Remote

<img src="/images/posts/open-source-universal-remote.jpg" height="320px" width="640px" class="center" />

The foundation of this project is the [Open Source Universal Remote](http://opensourceuniversalremote.com). I won't be going into detail about how to make one here, but if you're interested in learning more or making your own, here is all the information you need:

1. [Open Source Universal Remote](http://opensourceuniversalremote.com) - The open source universal remote home page. This is an overview of the project and how it works.
2. [RaspberryPi QuickStart](http://alexba.in/blog/2013/01/04/raspberrypi-quickstart/) - A guide I wrote to purchasing and doing the initial configuration on a RaspberryPi.
3. [Setting up LIRC on the RaspberryPi](http://alexba.in/blog/2013/01/06/setting-up-lirc-on-the-raspberrypi/) - How to setup and install the [Linux Infrared Remote Control (LIRC)](http://lirc.org) software on the RaspberryPi
4. [Controlling LIRC from the Web](http://alexba.in/blog/2013/02/23/controlling-lirc-from-the-web/) - How to install and configure two open source projects I wrote ([lirc_node](https://github.com/alexbain/lirc_node) and [lirc_web](https://github.com/alexbain/lirc_web)) to enable you to control LIRC from the web.
5. [Open Source Universal Remote - Parts & Picturse](http://alexba.in/blog/2013/06/08/open-source-universal-remote-parts-and-pictures/) - Finalized parts list and build pictures from a protoboard I soldered together.

For this project, I'll be using the HTTP based API that the Open Source Universal Remote generates based on the remotes and commands you teach it. Here are the three URLs I used for this project:

    http://192.168.1.115:3000/remotes/Yamaha/power
    http://192.168.1.115:3000/remotes/Microsoft_xbox360/onoff
    http://192.168.1.115:3000/remotes/sonytv/power

You could get clever and use the hostname of the open source remote, I'm just using the static IP address here.

### Part 2: The Android Phone

The second component of this project is an Android phone with the [Tasker](https://play.google.com/store/apps/details?id=net.dinglisch.android.taskerm) app installed on it. [Tasker](https://play.google.com/store/apps/details?id=net.dinglisch.android.taskerm) is a great app that provides a rich way to control your Android phone. One of the functions is the ability to send HTTP POST requests to specific URLs, which is the feature we'll be using for this project.

Within the Tasker app you'll need to create three new tasks, one for each button on the Pebble watch. Each task should be created with a descriptive name (like "Yamaha Power") and will contain a single ``HTTP POST`` action (found in the ``Net`` menu), which will be sent to the open source remote. Here's where the ``HTTP POST`` action can be found:

<img src="/images/posts/tasker-http-post.jpg" height="640px" width="384px" class="center" />


The ``HTTP POST`` action should be setup like this:

<img src="/images/posts/tasker-action-example.jpg" height="640px" width="384px" class="center" />

    # IP / Port of the Open Source Universal Remote
    Server:Port   http://192.168.1.115:3000

    # Path to the remote/command combo you want to call
    Path          /remotes/Yamaha/power

Once you've created those three Tasks, you're ready to setup the Pebble Watch.

### Part 3: Pebble Watch

The [Pebble Watch](http://getpebble.com) was a successful Kickstarter project that launched in 2012. It's a smart watch which connects to your cell phone via Bluetooth. It has a software development kit enabling anyone to write apps for the watch. I participated in the Kickstarter project, and have been very excited to start using my watch as a "remote control for reality."

For this project we'll be using the Android/Pebble combo app called [PebbleTasker](https://play.google.com/store/apps/details?id=com.kodek.pebbletasker). This is a very straightforward app. You install the app on your phone, which gives you the option to install the PebbleTasker app on the watch.

Once the watch app has been installed, you use the Android app to define which Tasker actions should be assigned to which button. Select the three Tasker actions that you created above and you should be set!

<img src="/images/posts/pebble-tasker.jpg" height="640px" width="384px" class="center" />

Here's a photograph of my Pebble Watch with the above Tasker actions programmed into the watch:

<img src="/images/posts/open-source-universal-remote-pebble-watch-2.jpg" height="450px" width="600px" class="center" />

### Part 4: Conclusion / What's Next

Not to wax too philosophical, but I believe that next generation user interface devices like the Pebble Watch have the potential to transform how humans interact with the digital world. The cell phone was revolutionary - it enabled humans to interact with their data while away from a desktop or laptop computer. Now, devices like the Pebble Watch and the RaspberryPi allow you to move beyond the phone and begin interacting with the digital world in an entirely new way.

As additional web connected devices are made that control lights, garage doors, cars, appliances, and beyond, the interplay between those devices and user interface devices like the Pebble Watch, Myo, Emotiv EPOC, Google Glass, and others are going to give us new and powerful interactions to control the digital and physical world. These interactions were, until now, the stuff of science fiction. These are exciting times we live in.

If you found this post interesting, please subscribe to the [RSS feed](http://feeds.feedburner.com/alexbain) to receive future updates or share this post with your social network. If you have any questions, feel free to leave a comment or send me an email (alex[at]thisdomain).

Tune in next time where I'll be writing up how to control the Open Source Universal Remote with your mind using an Emotiv EPOC EEG headset.
