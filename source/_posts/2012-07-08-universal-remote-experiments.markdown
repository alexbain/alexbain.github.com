---
layout: post
title: "Universal remote experiments"
date: 2012-07-08 09:51
comments: true
categories: [arduino, raspberrypi, electronics]
---

Over the past few months I've decided to teach myself a bit about embedded
microcontrollers and electronics. I've never worked with hardware before and,
after a bit of Googling, found an amazing Maker / Open Hardware movement going
on that I could leverage to help bootstrap my ideas.

Since I've found the best way to motivate myself is with a concrete project I
decided that, for my first project, I wanted to build a universal remote that I 
could control from my phone. I have a Harmony remote, which I use regularly,
but it's limited by line of sight and requires customization through a
cumbersome software interface.

My initial requirements were:

* Must be small enough to place discreetly in the room
* Must be WiFi enabled
* Must have great IR range and coverage
* Must be able to learn existing commands
* Must have a responsive web interface

#### Version 1: Arduino

The first prototype I built was using an [Arduino Uno][1] microcontroller along with
[Ken Shirriff's][2] multi protocol IR library. I had wired a 940nm IR LED to one
of the Arduino's pins and was able to get about two feet of range out of it.

Next, I extended the code and attached a [Roving Networks RN-XV][3] WiFi chip to
my project so it was WiFi enabled. So far so good. I could now send or receive
IR commands (relatively well, it wasn't perfect) over Wifi with about a two foot
range for the IR signal. I also had to hard code the WiFi credentials which meant
the device wasn't very portable, but at least it worked. This was version 1.1.

Version 1.2 was an updated hardware schematic that added a 2N2222 transistor to
the mix. Using a transistor meant that the output from the Arduino's pin was not
trying to power the LED but just telling a transitor to switch current on and off.
Since the transistor switches current significantly better than the output
pin of the Arduino I was able to extend the range for the IR blaster to about 15ft.
This change was inspired by open source schematics like [TV-B-Gone][4].

Version 1.3 was to be the version with the web interface. This was where I realized
the limitations of the Arduino platform. I could not easily run a WiFi libray,
an IR library, and a web server off of an 8bit micro controller. I simply didn't
have the resources.

I had considered a few alternatives:

* Run a webserver on my laptop and just send commands to/from the Arduino
* Run a webserver on the internet and relay commands that way
* Purchase a device like a [RaspberryPi][5] or [Beaglebone][6] and run the web
server on that device. Communicate with the Arduino perhaps via XBee or over WiFi.

Ultimately I decided that adding a second device increased the complexity of the
project beyond what I wanted. So, I scrapped the idea of using an Arduino and I'm
starting over with a [RaspberryPi][5].

#### Version 2: RaspberryPi

The [RaspberryPi][5] is a completely different beast than the [Arduino][1]. The [RaspberryPi][5]
is about as powerful as a mobile phone. It's got an ARM processor,
ethernet port, RAM, SD card for storage, and a bunch of [GPIO][9] pins for a hardware
interface.

So first up was finding an IR software package (designed for a Linux OS) that
could handle the transmission and receiving of IR signals. This lead me to
[LIRC][7] - the Linux Infrared Remote Control project. This project has been
around for a while, has a bunch of hardware schematics available (sending and
receiving) for it, and is open source. Perfect.

This lead me to getting LIRC working on my RaspberryPi. Luckily a chap who goes
by the name [ar0n][8] has already opened a [pull request][10] that adds preliminary
LIRC support to the RaspberryPi linux kernel.

So, at this very moment, I am attempting to recompile the RaspberryPi linux kernel
with LIRC support. Once this step is done I'll wire up some hardware to test
sending and receiving. Once that works I should be back to "adding a web platform"
which will be significantly easier when powered by an entire Linux stack.

I'll post another update down the road once I've gotten this step working.


[1]: http://arduino.cc
[2]: http://www.arcfn.com/2009/08/multi-protocol-infrared-remote-library.html
[3]: http://www.sparkfun.com/products/10822
[4]: http://www.ladyada.net/images/tvbgone/schematic.jpg
[5]: http://raspberrypi.org/
[6]: http://beagleboard.org/bone/
[7]: http://www.lirc.org/
[8]: http://aron.ws/projects/lirc_rpi/
[9]: http://en.wikipedia.org/wiki/General_Purpose_Input/Output
[10]: https://github.com/raspberrypi/linux/pull/38
