---
layout: post
title: "Adventures with Microprocessors"
date: 2012-02-03 08:17
comments: true
categories: [arduino, ez430]
---

I've always been fascinated by embedded systems but haven't taken the time
to dive into them or hack on 'em. Over the past few weeks, however, the [Arduino][1]
platform caught my eye and I've started reading about it and understanding
what it's capable of.

My verdict? It seems like the perfect introductory platform to start measureing
sensor data. So, last night I took the plunge and purchased the [Inventor's Kit][3]
from [Sparkfun electronics][2]. It should arrive next week (right before I
leave for France!). I'll take some unboxing shots when it arrives. I can't
wait to experiment with it and start hacking together some novel ideas. I plan
to post all of the code I write in a GitHub repo for others to grab and run with.

However, to get my feet wet, I busted out a [TI eZ430 Chronos watch][4] that my
good friend Jeff gave me a while back and started playing around with it's
default firmware. I'm not able to do anything too exciting yet, since I don't
have the firmware reprogrammer, but I was able to capture some of the button
events from the watch and route them out to [Pusher.com][5], a free WebSockets
API.

The next step is to write a Chrome extension that watches for those WebSockets
events and does something interesting. I've got a few ideas and I'll post about
them here once it's up and running.

If you're curious, check out the [Ruby script][6] that gets the watch talking
with [Pusher.com][5].

[1]: http://arduino.cc/ "Arduino"
[2]: http://www.sparkfun.com/ "Sparkfun electronics"
[3]: http://www.sparkfun.com/products/10173 "Sparkfun Inventor's Kit"
[4]: https://estore.ti.com/eZ430-Chronos-433-eZ430-Chronos-Wireless-Watch-Development-Tool-P1734.aspx "TI eZ430 Chronos"
[5]: http://pusher.com "Pusher"
[6]: https://github.com/alexbain/TI-Chronos-eZ430-to-WebSockets "TI eZ430 -> WebSockets"
