---
layout: post
status: publish
published: true
title: Facebook API
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 188
wordpress_url: http://www.liquidfoot.com/?p=188
date: 2007-06-14 10:41:57.000000000 -04:00
image:
  feature: abstract-3.jpg
  credit: dargadgetz
  creditlink: http://www.dargadgetz.com/ios-7-abstract-wallpaper-pack-for-iphone-5-and-ipod-touch-retina/

categories:
- Programming
tags:
- facebook
comments:
- id: 132
  author: Marc
  author_email: marc@joyfulleadership.com
  author_url: http://www.joyfulleadership.com
  date: '2009-02-04 20:52:04 -0500'
  date_gmt: '2009-02-05 03:52:04 -0500'
  content: "Hi Graham, I wanted to firstly say how impressive your site ise, very
    kewl!!! I have recently been writing an ap for Facebook, using the only book that
    makes any sense which is yours.... I have followed the book page by page dilegently
    taking in your hints and tips, and descided as a first stake that I would write
    something simular to your games review, accept its focused on books and resources
    for Life Coaches (which is what I am when not playing with software)\r\n\r\nHowever
    a couple of things have come up and I still really dont understand AWS full to
    get what I want to do...\r\n\r\nthe first thing that keeps coming up and I am
    unsure how to resolve is: \"HTML error while rendering tag \"img\": Relative URLs
    not allowed here\" there seems to be a lot of questions out there regarding this
    and facebook however no real answers, I assume you must have had this working
    at somestage.\r\n\r\nThe second question is I want to use AWS to bring the image
    back of a book cover based upon an ISBN being entered, any ideas how I would modify
    amazon.php to use the aws?\r\n\r\nLook forward to hearing back from you.\r\nRegards
    Marc"
- id: 219
  author: Wayne
  author_email: wayne.graham@virginia.edu
  author_url: http://liquidfoot.com
  date: '2009-02-24 10:44:34 -0500'
  date_gmt: '2009-02-24 17:44:34 -0500'
  content: "<p><p>Marc,</p><br />\r\n<p>Sorry for the delay...I recently changed
    jobs and had a second child and have been running behind in almost every facet
    of my life.</p><br />\r\n<p>One of the bad things about writing the Facebook
    API book is that the API was changing weekly while I was writing it. There was
    very little documentation for the functions at the time, so I had to keep rewriting
    a lot of the code as the book progressed.</p></p>\r\n<p><p>With that said,
    the best I can do is point you to Tyler Hall's php-aws project (http://code.google.com/p/php-aws/)
    which should handle communications with AWS far better than the Amazon wrapper
    I wrote for the book.</p></p>\r\n<p><p>Cheers,<br /><br />\r\nWayne</p></p>\r\n"
---

I've been kind of silent here as I've been trying to keep this blog at least somewhat focused on ColdFusion and I've been doing development in some different languages as of late (Java, PHP, and Ruby). However, when Facebook released their API for developers, my summer assistant Phil started hacking away at it and we've released our first app for Facebook: <a href="http://apps.facebook.com/swemtools/">SwemTools</a>.

It does a couple of things, provides a search interface for both the online catalog and our website, news feeds, hours, and a bit of a neat application based on <a href="http://swem.wm.edu/services/swemsignal/">Swem Signal</a> that was created by <a href="http://wm.facebook.com/profile.php?id=7605710">Tom MacWright</a>.

We're still working on the code for the Signals part, but the idea is that on a map of the library, you'd be able to see where your friends are. Right now, you can see a dot where your friends are, but not who they are...but we're working on a solution for it.

Anyway, if you're on <a href="http://www.facebook.com/">Facebook</a>, check it out...you can add me as a friend too.</div>
