---
layout: post
title: "Testing for missing images in JavaScript"
date: 2012-07-07 23:08
comments: true
categories: [javascript, tip]
---

Recently I had to determine if an image URL was properly rendering or not. Since
this image URL was provided by a user there was a chance that it had been
deleted or moved since they first set it. In that case I wanted to show a
different image - perhaps a "missing user" image - rather than just an empty
box.

My solution was to bind a callback to the ``onerror`` event that fires on an
``Image`` object if the image source could not be loaded. By binding a callback 
to this error I was able to replace a missing image with an image of my choice.


Here's a sample implementation that binds a callback onto the ``onerror`` event:

``` javascript

var checkForMissingImage = function (url, callback) {

  // Create an Image object in memory
  var img = new Image();

  // Bind the callback to the onerror event
  img.onerror = function() {
    callback();
  };

  // Set the src of the image to the url provided
  img.src = url;

};


```

Here's an example that involves replacing all images with class userpic on a page.

``` html

<!-- Userpic that will render as a missing image and needs replacing -->
<img src="http://brokenhost.com/does_not_exist.png" class="userpic" />

<!-- Userpic that will render properly -->
<img src="http://placekitten.com.s3.amazonaws.com/homepage-samples/200/287.jpg" class="userpic" />

```

``` javascript

$(function() {

  // Define a custom image to replace all missing images with
  var replacementImage = 'http://placekitten.com.s3.amazonaws.com/homepage-samples/408/287.jpg';

  // Find all userpics on the page
  $('.userpic').each(function (i, userpic) {

    // Create a cached reference of this userpic
    var $userpic = $(userpic);

    // Get the source of the userpic
    var src = $userpic.attr('src');

    // Check to see if this image still exists. If it does not exist, execute
    // the callback function and replace it.
    checkForMissingImage(src, function() {

      // Update the missing image with our replacement image.
      $userpic.attr('src', replacementImage);

    });

  });

});

```

As ``onerror`` support isn't universal across every browser this should be
considered a visual enhancement for users with modern browsers.

