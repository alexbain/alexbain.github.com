---
layout: post
title: "Receiving SMS notifications from your washer & dryer"
date: 2014-01-06 03:05
comments: true
categories: [electricimp, accelerometer, electronics]
---

<img src="/images/posts/lundry/thumb_pebble_notification.jpg" class="center" />

As I continue my experiments with embedded microcontrollers and electronics, I find myself increasingly fascinated by internet connected devices that blur the physical with the digital. It's almost as if I can fulfill the ubiquitous childhood dream of having super powers - I simply have to build the devices that enable them myself.

Previously, I discussed how I built my [open source universal remote](http://alexba.in/blog/2013/06/08/open-source-universal-remote-parts-and-pictures/) using a RaspberryPi, an expansion board I designed, and a [NodeJS web application](http://github.com/alexbain/lirc_web). This device allows me to control any infrared device in my home from my phone, smart watch, laptop, and other web connected device. I use the remote daily, and it's sparked my curiosity to devise new ways of enhancing my physical environment with thoughtful application of internet connected devices.

In this post, I'm going to cover a new project I've been working on - creating a non invasive device that monitors a washer or dryer and sends a text message when a load of laundry finishes. I built this device for two reasons. First, I wanted a project that introduced me to accelerometers - a sensor I find fascinating. Second, I wanted to try applying the principles of [progressive enhancement](http://en.wikipedia.org/wiki/Progressive_enhancement), a web software concept, to the physical world.

> "Progressive enhancement uses web technologies in a layered fashion that allows everyone to access the basic content and functionality of a web page, [...] while also providing an enhanced version of the page to those with more advanced browser software [...]." ([Wikipedia](http://en.wikipedia.org/wiki/Progressive_enhancement))

I wanted to apply the concept of progressive enhancement to the physical world by enhancing an appliance (washer or dryer) without modifying it's existing functionality or interface. I wanted the appliance to continue to operate as before, but gain new functionality that progressively enhances the user experience of interacting with the appliance digitally (SMS notifications).

<img src="/images/posts/lundry/thumb_circuit_macro.jpg" class="center" />

### Goals & Overview

Here were my goals for this project:

* Magnetically attach to the appliance, requiring no modifications.
* Contained within a 3D printed enclosure (thanks to John Steenson for his design)
* Accurately measure vibrations of appliance using an accelerometer.
* Analyze the accelerometer data, determining the state of the appliance.
* Send an SMS message to a cell phone  when the appliance finishes running.
* Open a web page to view the real time status of the appliance.

This post is broken down into three sections:

* The hardware
* The 3D printable enclosure
* The software

Lastly, I'll end with a conclusion and some thoughts now that it's complete.

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

<a href="/images/posts/lundry/case_with_lid.jpg"><img src="/images/posts/lundry/thumb_case_with_lid.jpg" class="center" /></a>

The above photos show the device mounted in the case (with and without the lid). Inside of the case, but beneath the device, I have attached (with two sided tape) the two rare earth magnets. I then placed a thin sheet of plastic between the magnets and the device to ensure there is no chance of electrical short. I have not found that the magnets interfere with the device in any way. The two magnets are what enables the device to attach to the washer or dryer.

**STL files for the 3D printable enclosure:**

* <a href="/stl/lundry/Enclosure_base.STL">Enclosure - Base</a>
* <a href="/stl/lundry/Enclosure_lid.STL">Enclosure - Lid</a>


## Part 3: Writing the Software

When writing software for the Electric Imp, you write two programs. The first program, called the "Device", runs on the Electric Imp hardware. The second program, called the "Agent", runs on the Electric Imp cloud. The Agent has the ability to send and receive HTTP traffic, making it a perfect candidate for the Twilio API, a RESTful API that allows you to send SMS messages.

For this project, the Device samples the accelerometer 50x a second. I found this to be frequent enough to get a clear picture for how much the washer or dryer is vibrating. For each sample, I determine the magnitude of the accelerometer vector and compute the percentage of change against the previous sample's magnitude. I track the amount of change over 5 seconds (250 samples), and return that value to the Agent. In my testing, I found that the average reading when the machine was turned off to be between 100 and 250. When the washer or dryer are running, I find the samples vary between 300 and 6000 depending on what stage of the cycle the machine is in.

The Agent receives the total amount change over the past 250 samples, and compares that against a threshold to determine if the machine is ON or OFF. If the value is above the threshold, the device is experiencing enough vibration where it's safe to call the machine ON. In my testing, I found 300 to be a good threshold to determine if the washer or dryer was running. Once the Agent receives 18 consecutive samples above the threshold (which works out to 90 seconds of data), it enters the RUNNING state. Then, at some point in the future, once the Agent receives 36 consecutive samples below the ON threshold, it returns to the OFF state. These delays help take into account lulls in vibration during a typical laundry cycle (ex: filling the washer, draining the washer). Depending on your appliances, you may need to adjust the thresholds in the Agent to reduce false positives. Finally, when returning to the OFF state, if the device was in the RUNNING state, an SMS notification is emitted (via [Twilio](http://twilio.com)) to each phone number stored in the phoneNumbers array.

If you'd like to read more about how to process the data coming off an accelerometer, I found [A Guide To using IMU (Accelerometer and Gyroscope Devices) in Embedded Applications.](http://www.starlino.com/imu_guide.html) to be an extremely informative read.

** Note:** The Agent code requires you to setup a Twilio account and enter your Twilio credentials before you can send any messages. Twilio, at the time of writing this article, charges $0.01 per text message. At the rate I do laundry, it should cost < $2 a year to send these text messages.

**Note2:** If you would like to log all of your data to a persistent data store (either to show on a web page, or just to analyze output), [Firebase](http://firebase.com) is a great option, and they have a free tier. Just change ``logToFirebase`` to be ``true`` and enter your Firebase URL if you want to enable this feature.

You may also <a href="https://gist.github.com/alexbain/8392153">view this code</a> on GitHub.

Here is the code for the Device, which reads in and processes the accelerometer data:

```
local total = 0; // Sum of % change from all samples
local n = 0;     // Counter for number of samples read
local last = 1;  // Previous reading of magnitude

function readSensor() {
    // Time interval
    local interval = 0.02;

    // Get source voltage, should be 3.3V
    local vRef = hardware.voltage();

    // Read in ADC values from accelerometer
    local adcRx = hardware.pin1.read();
    local adcRy = hardware.pin2.read();
    local adcRz = hardware.pin5.read();
    // server.log(format("Raw ADC values: %f, %f, %f", adcRx, adcRy, adcRz));

    // Convert 16bit ADC accelerometer values (0-65535) into voltage
    local voltsRx = (adcRx * vRef) / 65535.0;
    local voltsRy = (adcRy * vRef) / 65535.0;
    local voltsRz = (adcRz * vRef) / 65535.0;
    // server.log(format("Voltages: %f, %f %f", voltsRx, voltsRy, voltsRz));

    // Subtract 0g (1.5V at 3V, 1.65V at 3.3V)
    local deltaVoltsRx = voltsRx - (vRef / 2);
    local deltaVoltsRy = voltsRy - (vRef / 2);
    local deltaVoltsRz = voltsRz - (vRef / 2);
    // server.log(format("Adjusted voltages %f, %f, %f", deltaVoltsRx, deltaVoltsRy, deltaVoltsRz));

    // Convert from voltage to g, using sensitivity of 300mV
    local rX = deltaVoltsRx / 0.3;
    local rY = deltaVoltsRy / 0.3;
    local rZ = deltaVoltsRz / 0.3;
    // server.log(format("Gs: %f, %f, %f", rX, rY, rZ));

    // Compute magnitude of force
    local magnitude = math.sqrt(math.pow(rX,2) + math.pow(rY, 2) + math.pow(rZ, 2));

    // Compute % change since last reading
    local change = math.fabs((magnitude - last)/last) * 100.0;

    // Store magnitude in last for next time
    last = magnitude;

    // Log magnitude and percent change
    // server.log(format("magnitude: %f, change amount: %f", magnitude, change));

    // Increment total with % change, increment N
    total = total + change;
    n = n + 1;

    // Log data to server once ever 250 samples (5 seconds)
    if (n >= 250) {
        agent.send("data", total);
        n = 0;
        total = 0;
    }

    // Sleep until time to read sensor again
    imp.wakeup(interval, readSensor);
}

// X input
hardware.pin1.configure(ANALOG_IN);

// Y input
hardware.pin2.configure(ANALOG_IN);

// Z input
hardware.pin5.configure(ANALOG_IN);

// Start reading the sensor
readSensor();
```

Here is the code for the Agent, which determines when to send an SMS

```
// Run on Agent

// Thresholds to adjust for better accuracy
local dataThreshold = 300; // Minimum accelerometer value to count as ON
local onThreshold = 18;    // Number of ON samples before machine enters RUNNING state
local offThreshold = 36;   // Number of OFF samples before machine enters OFF state

// State variable
local running = false;

// Keep track of counts
local onCount = 0;
local offCount = 0;

// Twilio
local twilioURL = "https://USER:PASS@api.twilio.com/2010-04-01/Accounts/ID/Messages.json";
local twilioHeaders = { "Content-Type": "application/x-www-form-urlencoded" };
local twilioNumber = "+14155551212";

// Array of phone numbers to be contacted with the laundry is done
local phoneNumbers = ["+14155555555", "+14155555556"];

// Firebase
local logToFirebase = false;
local firebaseURL =  "https://FIREBASE_URL.firebaseIO.com/data.json";
local firebaseHeaders = { "Content-Type": "application/json" };

// Called every time the imp emits data
device.on("data", function(data) {

    // Is there enough accelerometer activity for the device to be considered ON?
    if (data >= dataThreshold) {
        onCount = onCount + 1;

        // Prevent overflow errors by resetting onCount when it gets close to limit
        if (onCount >= 65500) {
            onCount = onThreshold;
        }

        // If the device has been ON for long enough, set running state to be true
        if (onCount >= onThreshold) {
            running = true;

            // Running, so reset offCount
            offCount = 0;
        }

        // debug / logs
        if (running == true) {
            server.log(format("ON - RUNNING (%f), onCount (%d), offCount (%d)", data, onCount, offCount));
        } else {
            server.log(format("ON (%f), onCount (%d), offCount (%d)", data, onCount, offCount));
        }

    // Imp is not recording much accelerometer movement, so device seems to be OFF
    } else {
        offCount = offCount + 1;

        // Prevent overflow errors by resetting offCount when it gets close to limit
        if (offCount >= 65500) {
            offCount = offThreshold;
        }

        // Has the device been off for long enough to be "done"?
        if (offCount >= offThreshold) {

            // Was the device previously running?
            if (running == true) {

                // This means that the laundry had been running, and is now done.

                // Send an SMS to each phone number in the phoneNumbers array.
                foreach (number in phoneNumbers) {
                    local body = format("To=%s&From=%s&Body=The%%20laundry%%20is%%20done.", number, twilioNumber);
                    local request = http.post(twilioURL, twilioHeaders, body);
                    local response = request.sendasync(function(done) {});
                }

                // debug / logs
                server.log("!!!! Emitting OFF event !!!!");
            }

            // Reset on count
            onCount = 0;

            // Machine is no longer running
            running = false;
        }

        // debug / logs
        if (running == true) {
            server.log(format("OFF - WAS RUNNING (%f), onCount (%d), offCount (%d)", data, onCount, offCount));
        } else {
            server.log(format("OFF (%f), onCount (%d), offCount (%d)", data, onCount, offCount));
        }
    }

    if (logToFirebase == true) {
        // Build a post request to Firebase to log the data
        local body = format("{\"amount\": %f, \"running\": %s, \".priority\": %d}", data, running ? "true" : "false", time());
        local request = http.post(firebaseURL, firebaseHeaders, body);

        // Send the data to Firebase async
        local response = request.sendasync(function(done) {});
    }
});
```


