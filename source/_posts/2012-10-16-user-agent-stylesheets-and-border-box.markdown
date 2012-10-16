---
layout: post
title: "User agent stylesheets and border-box"
date: 2012-10-16 12:38
comments: true
categories: [html5, css]
---

Recently I was trying to troubleshoot why all of the inputs on a project had
``box-sizing: border-box`` applied to them. It turns out that a user agent
stylesheet rule that I don't normally see was being applied to all input elements.
This user agent stylesheet rule was being applied in Chrome, Firefox, and Safari.

Here is the ``user agent stylesheet`` rule that was being applied:

    input:not([type="image"]), textarea {
      box-sizing: border-box;
    }

After some troubleshooting it turns out this rule was being applied due
to a typo in the DOCTYPE for the project. After changing the DOCTYPE back
to the correct HTML5 doctype (``<!doctype html>``) everything loaded correctly.

