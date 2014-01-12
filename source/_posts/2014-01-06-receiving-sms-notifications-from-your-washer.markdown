---
layout: post
title: "Receiving SMS notifications from your washer & dryer"
date: 2014-01-06 03:05
comments: true
categories: [electricimp, accelerometer, electronics]
---

<img src="/images/posts/lundry/thumb_pebble_notification.jpg" class="center" />

As I've continued my experiments with embedded microcontrollers and electronics, I've found myself looking at the physical world in a new way - as an environment that can be enhanced with the application of novel smart devices, blurring the line between physical and digital. This perspective has driven me to build devices of my own imagination that enhance aspects of my day to day life. 

For example, in previous posts, I covered how I built an [Open Source Universal Remote](http://alexba.in/blog/2013/06/08/open-source-universal-remote-parts-and-pictures/) using a RaspberryPi, an expansion board I designed, and a [NodeJS web application](http://github.com/alexbain/lirc_web) I built. It allows me to control any infrared device from a phone, smart watch, laptop, or other web connected device. I use the device daily, and it's sparked my curiosity to explore new ways of enhancing my physical environment with thoughtful application of web connected electronics.

In this post, I'm going to cover a new project I've been working on - creating a non invasive device that monitors a washer or dryer and sends you a text message when a load of laundry finishes. I built this device because I wanted to experiment with applying the principles of [progressive enhancement](http://en.wikipedia.org/wiki/Progressive_enhancement), a web software concept, to the physical world.

In the world of web software, the concept of [progressive enhancement](http://en.wikipedia.org/wiki/Progressive_enhancement) is summarized on Wikipedia as follows: "Progressive enhancement uses web technologies in a layered fashion that allows everyone to access the basic content and functionality of a web page, [...] while also providing an enhanced version of the page to those with more advanced browser software [...]." I believe this applies to the physical world, as well. I believe that a physical device can be progressive enhanced (using web connected electronics) to become a "smart" or "internet of things" device without affecting it's existing, non digital, functionality. In this way, the appliance continues to operate as before, with no change in offline behavior, while gaining new web connected functionality that enhances the user experience of interacting with the device.

<img src="/images/posts/lundry/thumb_circuit_macro.jpg" class="center" />

So, without further ado, I'm going to cover how I built an open source device that:

* Magnetically attaches to the outside of a washer or dryer, requiring no modification to the appliance
* Measures the vibrations of the washer and dryer using an [ElectricImp](http://electricimp.com) microcontroller and an accelerometer
* Determines when the machine is running, and when it's finished running
* Has a specially designed, 3D printable enclosure (designed by the talented John Steenson)
* Connects to your WiFi network, enabling:
  1. The ability to monitor the state of the washer or dryer from a web page (using [Firebase](http://firebase.com))
  2. The ability to send an SMS (using [Twilio](http://twilio.com)) when the washer or dryer finishes running

I'll cover this project in four sections:

1. Hardware
2. 3D printable enclosure
3. Software
4. Web services

## Hardware

<img src="/images/posts/lundry/thumb_hardware_device.jpg" class="center" />

For this project, I purchased most of my parts from [Adafruit](http://adafruit.com), a fantastic online retailer of electronic components. Here's the full bill of materials:

* [Electric Imp](http://www.adafruit.com/products/1129)
* [April dev board for Electric Imp](http://www.adafruit.com/products/1130)
* [ADXL335 analog 3.3V +-3g accelerometer](http://www.adafruit.com/products/163)
* [Quarter size perma-proto breadboard](http://www.adafruit.com/products/589)
* [USB power supply](http://www.adafruit.com/products/501)
* [USB A to Mini B cable](http://www.amazon.com/AmazonBasics-A-Male-Mini-B-Cable-Meters/dp/B001TH7GUK/ref=sr_1_1?ie=UTF8&qid=1388982594&sr=8-1&keywords=usb+mini)
* [Solid core wire](http://www.adafruit.com/products/289)

### Electric Imp

<img src="/images/posts/lundry/thumb_electric_imp.jpg" class="center" />

For the microcontroller component of the project, I chose the [Electric Imp](http://electricimp.com/product/). The Electric Imp is a microcontroller in the form factor of an SD card with a 32bit Cortex M3 processor in it. What I find exciting about the Electric Imp, however, is that it also includes an 802.11b/g/n chip, making it one of the smallest WiFi enabled microcontrollers I've found online. Combined with the fact that the card itself is only $30, and it was a no brainer for the project.

Teaching the Electric Imp your WiFi credentials is done through an extremely clever process that the team calls [BlinkUp](http://electricimp.com/product/blinkup/). The Imp itself contains a phototransistor on it, which allows you to program your WiFi credentials via a smart phone app. The display of your smart phone strobes in a pattern that the Imp recognizes, which allows you to program the credentials optically, without having to connect the Imp to your computer.

Programming the Electric Imp is done via their Web based IDE, which makes pushing updates to the device a piece of cake. Later on, I'll include all of the code I wrote for both the Imp and the "Agent" - which is a program that runs on the Electric Imp Cloud, allowing you to make net requests and do more computationally heavy processing.

I also used the April Dev board, which is a breakout board that makes working with the Electric Imp very easy. You can see the dev board in the image listed underneath the "Hardware" section.

### ADXL335 Analog Accelerometer

<img src="/images/posts/lundry/thumb_adxl335.jpg" class="center" />

For the accelerometer, I chose the [ADXL335](http://www.analog.com/static/imported-files/data_sheets/ADXL335.pdf). It's a 3.3V analog accelerometer sensitive to +- 3g. The device itself is widely used, and documentation is readily available. In addition, [Adafruit](http://adafruit.com) sells a breakout board (listed above in the bill of materials) that made including the device in my project an easy decision.


### The Software

On the software side of things, we'll need:

* [Twilio account](https://www.twilio.com/)
* An Electric Imp account - http://electricimp.com

Optional (for a real time web interface):

* A free firebase account - http://firebase.com
* A free GitHub account (for web hosting) - http://github.com

