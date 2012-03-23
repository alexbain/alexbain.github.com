---
layout: post
title: "Opening Chrome from the OSX terminal"
date: 2012-03-23 11:15
comments: true
categories: osx
---

Have you ever wanted to open an HTML file in Chrome, directly from the OSX terminal? I have. Here's how to do it:

* Open `~/.bash_profile` in your editor of choice.
* Append this to the bottom of your `~/.bash_profile`:

``` bash .bash_profile
      chrome () {
        open -a "/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome" "$1"
      }
```

* Save and close the file.
* Run `source ~/.bash_profile` from the terminal to reload it.
* Enjoy being able to type things like `chrome index.html` from the terminal.

