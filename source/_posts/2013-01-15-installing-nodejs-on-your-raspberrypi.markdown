---
layout: post
title: "Installing NodeJS on your RaspberryPi"
date: 2013-01-15 12:04
comments: true
categories: [raspberrypi, javascript, nodejs]
---

Here's how I installed [NodeJS](http://nodejs.org/) on my RaspberryPi:

### Upgrade to the latest OS / Firmware

If you have not already upgraded to the latest version of Raspbian OS and the
latest RaspberryPi firmware, I recommend following my [RaspberryPi Quickstart](http://alexba.in/blog/2013/01/04/raspberrypi-quickstart/).

### Getting and Compiling NodeJS

Once your RaspberryPi is up to date, here's how to download and compile NodeJS:

    # Install some prerequisites
    sudo apt-get install python g++ make

    # Grab the latest version of NodeJS
    mkdir ~/nodejs && cd $_
    wget -N http://nodejs.org/dist/node-latest.tar.gz
    tar xzvf node-latest.tar.gz && cd `ls -rd node-v*`

    # Compile and install to your RaspberryPi
    ./configure
    make
    sudo make install

Please note that it takes about two hours to compile NodeJS.

### Confirming Installation

You can confirm that NodeJS was installed correctly by running:

    node -v
    npm --help

That's it! You're ready to begin development.

### Additional Reading:

If you'd like to do some additional reading about NodeJS or ways to access the
GPIO pins on the RaspberryPi, check out:

* [NodeJS](http://nodejs.org/) - NodeJS home page
* [pi-gpio](https://github.com/rakeshpai/pi-gpio) - "node.js based library to help access the GPIO of the Raspberry Pi"
* [GpiO](https://github.com/EnotionZ/GpiO) - "Talk to your Raspberry Pi's GPIO"

If you have any other recommended resources please let me know!
