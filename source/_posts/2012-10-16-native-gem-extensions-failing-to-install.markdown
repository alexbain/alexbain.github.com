---
layout: post
title: "Native gem extensions failing to install"
date: 2012-10-16 12:23
comments: true
categories: [ruby, gcc]
---

Recently I've had trouble installing native gem extensions on my OSX 10.8.2 laptop.
It appears that some gems are specifically looking for ``/usr/bin/gcc-4.2`` and
fail to compile if that's missing. When I checked ``/usr/bin`` I could only find
``/usr/bin/gcc``.

I tried creating a symlink to ``gcc-4.2`` and everything installed correctly:

    sudo ln -s /usr/bin/gcc /usr/bin/gcc-4.2


Hope this helps someone!
