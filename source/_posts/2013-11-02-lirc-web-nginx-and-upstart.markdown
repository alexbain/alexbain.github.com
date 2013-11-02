---
layout: post
title: "Running lirc_web with nginx and upstart"
date: 2013-11-02 09:50
comments: true
categories: [raspberrypi, lirc, opensourceuniversalremote, nginx, upstart]
---

In this post I will cover how to start the ``lirc_web`` project when a RaspberryPi boots up, as well as how to run the ``lirc_web`` app behind an NGINX web server. ``lirc_web`` is an open source NodeJS app I wrote as part of the [Open Source Universal Remote](http://opensourceuniversalremote.com) project, a RaspberryPi powered universal remote I built to control the electronics within my home. If you'd like to learn more about the remote, please check out the [Open Source Universal Remote - Parts & Pictures](http://alexba.in/blog/2013/06/08/open-source-universal-remote-parts-and-pictures/) blog post.

To accomplish these goals, we'll be tackling the problem in three stages:

1. Configure a ``http://universalremote.local`` hostname for the RaspberryPi
2. Daemonize the ``lirc_web`` project with upstart and start it on system boot
3. Install and configure the NGINX web server to host ``lirc_web``

Once these steps are complete the ``lirc_web`` project will automatically launch when the RaspberryPi turns on, and be available via the web at ``http//universalremote.local``. This ensures the Open Source Universal Remote web interface will always be available, even if the RaspberryPi unexpectedly loses power.

**Note: Not all mobile devices support ``.local`` domains, you may still need to connect to your RaspberryPi via IP**

### Configure a ``http://universalremote.local`` hostname for the RaspberryPi

If you want your RaspberryPi to be accessible on your local network via hostname, instead of always typing it's IP address, you'll want to install an mDNS daemon. If you'd like to learn why, I recommend reading [How (and Why) to Assign the .local Domain to Your Raspberry Pi](http://www.howtogeek.com/167190/how-and-why-to-assign-the-.local-domain-to-your-raspberry-pi/). To accomplish this, we'll use [Avahi](http://en.wikipedia.org/wiki/Avahi_(software)) to provide mDNS on the RaspberryPi. Installation is easy, just run:

    sudo apt-get install avahi-daemon

When that command finishes, try pinging ``raspberrypi.local`` from a different computer. Everything should just work. **Note: Some mobile devices do not support .local domains, but OSX and Windows should both do the right thing**. Next, we'll update the hostname of the RaspberryPi to be ``universalremote``. This requires three changes:

1. Edit ``/etc/hosts`` and change the last line to ``127.0.1.1 universalremote``
2. Edit ``/etc/hostname`` and change the hostname to ``universalremote``
3. Reboot the RaspberryPi by running ``sudu shutdown -r now``

When the RaspberryPi boots back up you should be able to access it over SSH with

    ssh pi@universalremote.local


### Daemonize the ``lirc_web`` app and start it on system boot

To ensure that the ``lirc_web`` app starts whenever the RaspberryPi boots, we'll use a tool called Upstart. Upstart is a project from Ubuntu that simplifies writing init scripts. If you want to learn more about it, you can visit [http://upstart.ubuntu.com/](http://upstart.ubuntu.com/) and read more. RaspbianOS does not include Upstart by default, but it can be installed to replace sysvinit with no negative consequences. Here are the commands:

    sudo apt-get install upstart
    # You will be asked to type 'Yes, do as I say!' - you can do this, everything will continue to work
    # You may see an error about initctl being unable to connect, which will be fixed after a reboot

    # Reboot the RaspberryPi
    sudo shutdown -r now

Once the RaspberryPi reboots Upstart should be installed. Upstart configuration files are placed in ``/etc/init``. You can either use the sample Upstart configuration that comes with the ``lirc_web`` Git repository, or you can use this example (place in ``/etc/init/open-source-universal-remote.conf``):

    # /etc/init/open-source-universal-remote.conf
    description "universalremote.local"

    start on runlevel [2345]
    stop on runlevel [016]

    # Restart when job dies
    respawn

    # Give up restart after 5 respawns in 60 seconds
    respawn limit 5 60

    script

      echo $$ > /var/run/open-source-universal-remote.pid
      exec /usr/local/bin/node /home/pi/lirc_web/app.js 2>&1 >> /var/log/open-source-universal-remote.upstart.log

    end script

    pre-start script
        # Date format same as (new Date()).toISOString() for consistency
        echo "[`date -u +%Y-%m-%dT%T.%3NZ`] (sys) Starting" >> /var/log/open-source-universal-remote.upstart.log
    end script

    pre-stop script
        rm /var/run/open-source-universal-remote.pid
        echo "[`date -u +%Y-%m-%dT%T.%3NZ`] (sys) Stopping" >> /var/log/open-source-universal-remote.upstart.log
    end script

After creating the Upstart script, you should be able to start the ``lirc_web`` project by running:

    sudo initctl start open-source-universal-remote

You can verify everything works by opening ``http://universalremote.local:3000`` (or the RaspberryPi's IP address) in your web browser. You should see the ``lirc_web`` web interface.


### Install and configure the NGINX web server to host ``lirc_web``

If you run ``lirc_web`` by itself it creates a basic web server on port 3000. This is fine, but it's more convenient when an web application runs on port 80, the default port for web traffic. We'll use the free and open source NGINX web server to accomplish this.

To install nginx and ensure it starts on boot, run:

    sudo apt-get install nginx
    update-rc.d nginx defaults
    sudo service nginx start

When this completes, confirm everything installed correctly by trying to  access ``http://universalremote.local`` in your web browser. You should see a "Welcome to nginx!" web page.

Next, we have to configure nginx to serve the ``lirc_web`` app. You can use the sample config file included in the ``lirc_web`` Git repository (within the config directory), or use this example:

    server {
        listen            80;
        server_name       universalremote.local;

        # Change this to the location you installed lirc_web
        root              /home/pi/lirc_web;
        index             index.html index.htm;

        access_log        /var/log/open-source-universal-remote.nginx.log;

        location / {
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Host $http_host;
            proxy_set_header X-NginX-Proxy true;

            proxy_pass http://127.0.0.1:3000/;
            proxy_redirect off;
        }
    }

Restart nginx to pick up the new configuration with ``sudo service nginx restart``.

Now, if you visit ``http://universalremote.local`` in your web browser you should now see the project running. In the future, any time you reboot the RaspberryPi ``lirc_web`` will start automatically.

### Conclusion

If everything went smoothly you should now have a daemonzized version of ``lirc_web`` running on your RaspberryPi, which is being served via nginx over port 80. In addition, any time you restart your RaspberryPi the ``lirc_web`` app will start up at boot.

Are you interested in reading more about the Open Source Universal Remote project? Check out:

* [Setting up LIRC on the RaspberryPi](http://alexba.in/blog/2013/01/06/setting-up-lirc-on-the-raspberrypi/)
* [Controlling LIRC from the web](http://alexba.in/blog/2013/02/23/controlling-lirc-from-the-web/)
* [Using a RaspberryPi and a Pebble Watch to control your home theater](http://alexba.in/blog/2013/06/01/using-the-pebble-watch-to-control-your-home-theater/)
* [Open Source Universal Remote - Parts & Pictures](http://alexba.in/blog/2013/06/08/open-source-universal-remote-parts-and-pictures/)

