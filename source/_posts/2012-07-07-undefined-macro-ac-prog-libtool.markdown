---
layout: post
title: "Undefined macro: AC_PROG_LIBTOOL"
date: 2012-07-07 23:00
comments: true
categories: linux, tip
---

While trying to install LIRC on my RaspberryPi I ran into this error:

``configure.ac:24: error: possibly undefined macro: AC_PROG_LIBTOOL``

The solution that worked for me (on Debian Wheezy) was:

``sudo apt-get install libtools``

Hope that helps someone else out there.
