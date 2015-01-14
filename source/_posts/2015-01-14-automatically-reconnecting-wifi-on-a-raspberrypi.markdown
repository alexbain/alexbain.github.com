---
layout: post
title: "Automatically reconnecting WiFi on a RaspberryPi"
date: 2015-01-14 03:55
comments: true
categories: [raspberrypi]
---

In this post, I'm going to cover writing a short script that automatically reconnects a RaspberryPi to a WiFi network. The script will check to see if the Pi has network connectivity and, if it's offline, will restart the wireless interface to bring it back online. We'll use ``cron`` to schedule the execution of this script at a regular interval.

There are a few ways to determine if the RaspberryPi has network connectivity. For this script, we'll be using ``ping``.

### Writing the script

To get started, we'll need to determine if the RaspberryPi is connected to the network. To do this, we'll attempt to ping a server and see if we get a response. If the command succeeds (RaspberryPi receives a response from the server), we have network connectivity. If the command fails, we'll turn ``wlan0`` off and back on.

```
#!/bin/bash

# The IP for the server you wish to ping (8.8.8.8 is a public Google DNS server)
SERVER=8.8.8.8

# Only send two pings, sending output to /dev/null
ping -c2 ${SERVER} > /dev/null

# If the return code from ping ($?) is not 0 (meaning there was an error)
if [ $? != 0 ]
then
    # Restart the wireless interface
    ifdown --force wlan0
    ifup wlan0
fi
```

Name the script something memorable (``wifi_rebooter.sh``), and place this script in ``/usr/local/bin``. Make sure it's executable by running:

```
chmod +x /usr/local/bin/wifi_rebooter.sh
```

### Scheduling regular execution

To ensure the script runs automatically, we'll use ``cron``. The frequency that you run this script is a matter of personal preference - I chose to run the script every five minutes.

To schedule the script, open ``/etc/crontab`` for editing and add this line to the bottom:

```
*/5 *   * * *   root    /usr/local/bin/wifi_rebooter.sh
```

This will ensure that the script is run, as root, every 5 minutes. If you're unfamiliar with ``cron`` syntax, take a look at the [cron format](http://www.nncron.ru/help/EN/working/cron-format.htm).

### Testing

To test that the script works as expected, we are going to take down the ``wlan0`` interface and wait for the script to bring it back up. Before taking down ``wlan0``, you may want to adjust the interval in ``/etc/crontab`` to 1 minute. Also, note that this will immediately disconnect you from your shell session.

To take down ``wlan0`` to confirm the script works, run:

```
ifdown --force wlan0
```

After waiting patiently for ~1 minute, try SSHing back into your RaspberryPi. Assuming everything worked, your RaspberryPi should have automatically reconnected to WiFi. Don't forget to adjust the interval in ``/etc/crontab`` back to a more appropriate value, if you set it to one minute for testing.

Hopefully this helps keep your RaspberryPi projects online! if you have any questions, or have an alternative method to suggest, feel free to leave a comment.
