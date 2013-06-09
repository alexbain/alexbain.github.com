---
layout: post
title: "Open Source Universal Remote - Parts &amp; Pictures"
date: 2013-06-08 16:17
comments: true
categories: [raspberrypi, opensourceuniversalremote, electronics]
---

<a href="/images/posts/protoboard_v1/protoboard_v1_installed.jpg">
  <img src="/images/posts/protoboard_v1/thumb_protoboard_v1_installed.jpg" class="center" />
</a>

This past weekend I converted my [Open Source Universal Remote](http://opensourceuniversalremote.com) breadboard layout into a more permanent soldered circuit. I used the [Adafruit Protoboard](http://octopart.com/ada801-adafruit+industries-27056076) as a base instead of having a custom circuit board printed, which worked out well. The protoboard is perfectly sized for the RaspberryPi and I highly recommend it for any RaspberryPi related hardware projects.

Below, I've attached some high resolution photographs of the finished protoboard (front and back). I've also created separate versions of the photographs which are fully annotated and explain how all of the components are laid out. Please note that I did make one miscalculation in my circuit which I have corrected with a yellow jumper wire. I've pointed out the miscalculation on both annotated photographs.

If you want to build your own board here are the parts I used:

* [1 Adafruit RaspberryPi Protoboard](http://octopart.com/ada801-adafruit+industries-27056076)
* [2 940nm 40deg IR LEDs](http://octopart.com/ir333c-everlight-17677690)
* [2 right angle LED holders](http://octopart.com/hlmp-5029-avago-549484)
* [1 P2N2222AGOD-ND transistor](http://octopart.com/p2n2222ag-on+semiconductor-358561)
* [1 10k Ohm resistor](http://octopart.com/od103je-ohmite-133027)
* [1 TSOP38238 38KHz IR receiver](http://octopart.com/tsop38238-vishay-11814552)
* [Hook-up Wire Spool Set - 22AWG Solid Core - 6 x 25 ft](http://www.adafruit.com/products/1311)

Note: You also need a RaspberryPi. If you need to purchase a RaspberryPi I recommend reading my [RaspberryPi Quickstart](http://alexba.in/blog/2013/01/04/raspberrypi-quickstart/) post which talks about purchasing and configuring a RaspberryPi.

So, without further ado, here are the pictures of the finished product. All pictures link to a full resolution image which provides plenty of additional resolution for examining the circuit. The annotated photographs should help fill in anything that is unclear. If you have any questions, please leave them in the comments.

<a href="/images/posts/protoboard_v1/protoboard_v1_top.jpg">
  <img src="/images/posts/protoboard_v1/thumb_protoboard_v1_top.jpg" class="center" />
</a>

<a href="/images/posts/protoboard_v1/protoboard_v1_top_annotated.jpg">
  <img src="/images/posts/protoboard_v1/thumb_protoboard_v1_top_annotated.jpg" class="center" />
</a>

<a href="/images/posts/protoboard_v1/protoboard_v1_bottom.jpg">
  <img src="/images/posts/protoboard_v1/thumb_protoboard_v1_bottom.jpg" class="center" />
</a>

<a href="/images/posts/protoboard_v1/protoboard_v1_bottom_annotated.jpg">
  <img src="/images/posts/protoboard_v1/thumb_protoboard_v1_bottom_annotated.jpg" class="center" />
</a>

<a href="/images/posts/protoboard_v1/protoboard_v1_installed_alt.jpg">
  <img src="/images/posts/protoboard_v1/thumb_protoboard_v1_installed_alt.jpg" class="center" />
</a>

<a href="/images/posts/protoboard_v1/protoboard_v1_installed_back.jpg">
  <img src="/images/posts/protoboard_v1/thumb_protoboard_v1_installed_back.jpg" class="center" />
</a>

If you'd like to learn more about this project, here is some further reading:

* [Open Source Universal Remote intro](http://alexba.in/blog/2013/03/06/open-source-universal-remote/) - Intro post to the project
* [RaspberryPi IR Schematic for LIRC](http://alexba.in/blog/2013/03/09/raspberrypi-ir-schematic-for-lirc/) - Electrical schematic for the hardware
* [Setting up LIRC on the RaspberryPi](http://alexba.in/blog/2013/01/06/setting-up-lirc-on-the-raspberrypi/) - Installing and configuring IR software
* [Controlling LIRC From the Web](http://alexba.in/blog/2013/02/23/controlling-lirc-from-the-web/) - Installing (mobile/desktop) web interface

