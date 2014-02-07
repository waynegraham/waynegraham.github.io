---
layout: post
status: publish
published: true
title: Facebook App
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 17
wordpress_url: http://www.liquidfoot.com/?p=17
date: 2008-07-18 05:43:32.000000000 -04:00
categories:
- Programming
- Projects
- Featured
tags:
- facebook
- smarty
- google code
comments: []
---
Phil and I (mostly Phil) have been working on getting the code for our Facebook application ready to be released on Google Code. Phil has done a phenomenal job in getting the code ported to FBML so we don&rsquo;t have to use the lib_gd stuff any more to generate images. We also rewrote it using Smarty templates. As a brief aside, I&rsquo;m not sure why I haven&rsquo;t been using this for a while. It really is a great framework for the majority of what I need to do.

If you&rsquo;re interested, you can check out the code at <a title="Facebook Athenaeum" href="http://code.google.com/p/facebook-athenaeum">http://code.google.com/p/facebook-athenaeum</a>. There are a few more features to add in, but it does work rather nicely, and a lot faster than our previous version. The slowest thing is the asynchronous post to the MySQL server (the longest time we recorded was 111ms), but since that happens in the background, you don&rsquo;t even notice.
