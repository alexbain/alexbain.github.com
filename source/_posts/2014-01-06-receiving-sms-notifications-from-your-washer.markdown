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






As I've continued to experiment with embedded microcontrollers and electronics, I found myself intrigued by accelerometers. I've wanted to better understand how an accelerometer works. Accelerometers are amazing devices that measure acceleration. They have a wide multitude of purposes and, thanks to their widespread use in mobile electronics, have become sensitive enough and affordable enough to purchase and experiment with.

So, to give myself an opportunity to learn how an accelerometer works, I decided to try to solve a "problem" around my home that an accelerometer could handle. Namely - the fact that my wife and I frequently leave our laundry in the washer, because we've forgotten to set an alarm. How could I fix this, I thought to myself?

Well, first of all, I decided that I wanted to receive a digital notification when the washer and dryer finished. Since my washer and dryer is located in the garage, and I can't hear the buzzer from my house, it seemed a digital notification would be a reasonable way to get notified. I frequently have my phone in my pocket, or my Pebble watch on my wrist, so any kind of push notification or SMS notification would likely reach me quickly.

Since I'd also like my wife to benefit from this digital service, I ruled out a push notification. Why? I use an Android phone, and she uses an iOS device. Building two native apps to deliver a push notification seemed excessive - especially when SMS notifications can be sent to any cell device, regardless of carrier or manufacturer.

Luckily, there's a fantastic service called [Twilio](http://twilio.com) that provides RESTful APIs for sending text messages.

So, that means I'd need to have an embedded microcontroller that "speaks" HTTP. I could turn to the RaspberryPi, an amazing device I've used previously, but wanted to experiment with a new piece of technology - the [Electric Imp](http://electricimp.com). The Electric Imp is a microcontroller in an SD card package that includes a 802.11b/g/n wireless. This is perfect - it's small, compact, and contains WiFi.

Now that I'd picked out the proper microcontroller for the project, I needed a sensor that could determine when the washer or dryer was finished running. After some brainstorming I came up with the following approaches:

Potential approaches:

* Tap into the circuitry of the buzzer and notice when the voltage changed
* Place a photodiode sensor near the "done" LED on the washer / dryer and wait for it to light up
* Listen for the frequencies of the buzzer with a microphone and an audio analysis algorithm
* Feel for vibrations of the device to determine when it's running or not
* Monitor the electricity of the device to determine when the device is drawing current

Requirements:

* Does not modify the washer and dryer in any way
* Is not visible to the user - it should notify the user when the laundry is done, but otherwise be completely invisible
* Easy to add / remove the device or move it between machines

I wanted an elegant device that could be easily added/removed from the machines, so opted against modifying the circuitry. I also did not want the device to be visible, in any way, so that eliminated the photo diode approach. After doing some reading about the computation and work required to analyze an audio stream for specific frequencies, I shelved the idea of "listening" for the buzzer. While it certainly seemed possible, I didn't want to delve into the world of FFTs for this project. That left two options:

* Monitor the electricity of the device to determine when the device is drawing current
* Feel for vibrations of the device to determine when it's running or not

Both of these approaches seemed viable, but I chose the approach of monitoring vibrations of the device to determine whether it's running or not. I thought this would be the most interesting approach as well as provide a great opportunity to learn about accelerometers, a sensor I find fascinating and wanted to learn more about.

So now I had a project:

Progressively enhance my washer and dryer to digitally notify me when a load of laundry finishes.

An approach:

Monitor for vibrations emitted from the washer and dryer.

A set of tools to accomplish this:

* Electric Imp
* Accelerometer
* Twilio API

... So we're ready to begin!


### The Hardware

For this project, I purchased all of my parts from [Adafruit](http://adafruit.com), one of my favorite online retailers of electronic components. Here's the bill of materials:

* [Electric Imp](http://www.adafruit.com/products/1129)
* [April Dev board](http://www.adafruit.com/products/1130)
* [Quarter size perma-proto breadboard](http://www.adafruit.com/products/589)
* [ADXL335 analog 3.3V +-3g accelerometer](http://www.adafruit.com/products/163)
* [USB power supply](http://www.adafruit.com/products/501)
* [USB A to Mini B cable](http://www.amazon.com/AmazonBasics-A-Male-Mini-B-Cable-Meters/dp/B001TH7GUK/ref=sr_1_1?ie=UTF8&qid=1388982594&sr=8-1&keywords=usb+mini)
* [Solid core wire](http://www.adafruit.com/products/289)

### The Software

On the software side of things, we'll need:

* [Twilio account](https://www.twilio.com/)
* An Electric Imp account - http://electricimp.com

Optional (for a real time web interface):

* A free firebase account - http://firebase.com
* A free GitHub account (for web hosting) - http://github.com

