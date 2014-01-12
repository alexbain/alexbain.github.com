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

> "Progressive enhancement uses web technologies in a layered fashion that allows everyone to access the basic content and functionality of a web page, [...] while also providing an enhanced version of the page to those with more advanced browser software [...]." ([Wikipedia](http://en.wikipedia.org/wiki/Progressive_enhancement))

I believe that the concept of progressive enhancement can also be applied to the physical world by enhancing a device (using web connected electronics) without affecting it's existing functionality. In this way, an appliance can continue to operate as before, with no change in perceived behavior or user interface, while gaining new web connected functionality that enhances the user experience of interacting with the device digitally.

<img src="/images/posts/lundry/thumb_circuit_macro.jpg" class="center" />

So, in this post, I'm going to cover how I built an open source device that:

* Magnetically attaches to a washer or dryer, requiring no modifications to the washer or dryer.
* Measures the vibrations of a washer or dryer using an [Electric Imp](http://electricimp.com) microcontroller and an accelerometer.
* Runs software that analyzes when the machine is running, and when it's finished a load of laundry.
* Has a uniquely designed, 3D printable enclosure (designed by the talented John Steenson).
* Connects to your WiFi network, enabling you to:
  1. Receive an SMS (using [Twilio](http://twilio.com)) when the washer or dryer finishes.
  2. Monitor the real-time state of the washer or dryer from a web page (using [Firebase](http://firebase.com)).

This project will be covered in four sections:

* The hardware
* The 3D printable enclosure
* Writing the software
* Connecting the device to the web services


## Part 1: The Hardware

<img src="/images/posts/lundry/thumb_hardware_device.jpg" class="center" />

For this project, I purchased most of my parts from [Adafruit](http://adafruit.com), a fantastic online retailer of electronic components. Here's the full bill of materials:

* [Electric Imp](http://www.adafruit.com/products/1129)
* [April dev board for Electric Imp](http://www.adafruit.com/products/1130)
* [ADXL335 analog 3.3V +-3g accelerometer](http://www.adafruit.com/products/163)
* [Quarter size perma-proto breadboard](http://www.adafruit.com/products/589)
* [USB power supply](http://www.adafruit.com/products/501)
* [USB A to Mini B cable](http://www.amazon.com/AmazonBasics-A-Male-Mini-B-Cable-Meters/dp/B001TH7GUK/ref=sr_1_1?ie=UTF8&qid=1388982594&sr=8-1&keywords=usb+mini)
* [Solid core wire](http://www.adafruit.com/products/289)
* 2 small rare earth magnets (available from any hardware store)

### Electric Imp

<img src="/images/posts/lundry/thumb_electric_imp.jpg" class="center" />

For this project, I chose to work with the [Electric Imp](http://electricimp.com/product/) microcontroller. The Electric Imp is a microcontroller in the form factor of an SD card with a 32bit Cortex M3 processor. What I find most exciting about the Electric Imp is that it also includes an 802.11b/g/n chip, making it one of the smallest WiFi enabled microcontrollers I've found. I used the [April dev board](http://www.adafruit.com/products/1130), a breakout board from the Electric Imp team, that makes working with the Electric Imp very straightforward. You can see the dev board (green PCB) in the image underneath the "Hardware" section.

Configuring the Electric Imp with your WiFi credentials is done through a clever process called [BlinkUp](http://electricimp.com/product/blinkup/). The Imp itself contains a phototransistor, which enables you to program your WiFi credentials optically, via an app on your Android or iOS device. Once you install and configure the app, the display on your phone strobes in a pattern that the Imp recognizes, which programs the WiFi credentials into the Imp. The process only takes a few seconds, and it worked flawlessly for me the first time.

Once you've programmed your WiFi credentials onto the Imp, it will automatically connect to the Electric Imp cloud service. From there, you're able to login to the web based IDE and program the imp via your web browser. The IDE handles deploying code updates to the device, as well. I'd like to see a GitHub integration, which would provide version control, so hopefully that's on their roadmap.

### ADXL335 Analog Accelerometer

<img src="/images/posts/lundry/thumb_adxl335.jpg" class="center" />

For the accelerometer (the component that measures the vibration of the washing machine / dryer), I chose the [ADXL335](http://www.analog.com/static/imported-files/data_sheets/ADXL335.pdf). The ADXL335 is a 3.3V analog accelerometer sensitive to +- 3g. The device itself is widely used, and I found plenty of documentation online. In addition, [Adafruit](http://adafruit.com) sells a breakout board (listed above in the bill of materials) that made including the device in my project an easy decision. The breakout board that Adafruit sells also allows you to connect the accelerometer to a 5V microcontroller, such as an Arduino.

### Assembling the Hardware

<a href="/images/posts/lundry/hardware_device_2.jpg"><img src="/images/posts/lundry/thumb_hardware_device_2.jpg" class="center" /></a>

The assembly of the device is relatively straightforward. First, you will need to assemble the April Dev board and the ADXL335 breakout board by soldering the header pins onto the breakout boards. Next, you'll need to solder both breakout boards into the perma-proto board. Lastly, you'll solder in the 5 wires to enable the two components to communicate. **If you intend to use the 3D printable enclosure, please ensure that the two components are mounted identically to the image above.**

The picture above shows how the device looks when assembled, and here are the specifics:

* Pin 1 from Electric Imp is connected to the X-out pin on accelerometer.
* Pin 2 from the Electric Imp is connected to the Y-out pin on accelerometer.
* Pin 5 from the Electric Imp is connected to the Z-out pin on accelerometer.
* 3V3 pin from Electric Imp is connected to the Vin pin on accelerometer.
* GND pin from Electric Imp is connected to GND pin on accelerometer.

At this point you should be able to:

* Boot the device up with a USB power supply
* Program the Electric Imp to connect to your WiFi
* Log into the Electric Imp web based IDE to program the device


## Part 2: The 3D Printable Enclosure

<a href="/images/posts/lundry/empty_case.jpg"><img src="/images/posts/lundry/thumb_empty_case.jpg" class="center" /></a>

For this project, I wanted a custom enclosure that would enable the device to be sealed from dust and debris. I contacted a friend of mine, John Steenson, who agreed to help me design a 3D printable enclosure for the project. He has agreed to let me post the STL files for the case, which you can download and have 3D printed yourself. I had my case printed from a local printer that I found on the [3D Hubs](http://3dhubs.com) service.

<a href="/images/posts/lundry/occupied_case.jpg"><img src="/images/posts/lundry/thumb_occupied_case.jpg" class="center" /></a>

<a href="/images/posts/lundry/case_with_lid.jpg"><img src="/images/posts/lundry/case_with_lid.jpg" class="center" /></a>

The above photos show the device mounted in the case (with and without the lid). Inside of the case, but beneath the device, I have attached (with two sided tape) the two rare earth magnets. I then placed a thin sheet of plastic between the magnets and the device to ensure there is no chance of electrical short. I have not found that the magnets interfere with the device in any way.

**STL files for the 3D printable enclosure:**

* <a href="/stl/lundry/Enclosure_base.STL">Enclosure - Base</a>
* <a href="/stl/lundry/Enclosure_lid.STL">Enclosure - Lid</a>


## Part 3: Writing the Software

When writing software for the Electric Imp, you write two programs. The first program, called the "Agent", runs on the Electric Imp cloud. The second program, called the "Device", is run on the Electric Imp itself. I'm not going to go into too much detail about the software, as it's heavily commented, but if have any questions or suggestions please feel free to ask them in the comments.

Here is the code for the Agent & Device:

<script src="https://gist.github.com/alexbain/8392153.js"></script>

