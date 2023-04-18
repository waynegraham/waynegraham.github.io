---
layout: post
status: publish
published: true
title: Subversion with mod_security
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 196
wordpress_url: http://www.liquidfoot.com/?p=196
date: 2007-03-06 16:35:02.000000000 -05:00
image:
  feature: abstract-3.jpg
  credit: dargadgetz
  creditlink: http://www.dargadgetz.com/ios-7-abstract-wallpaper-pack-for-iphone-5-and-ipod-touch-retina/

categories:
- General
tags:
- Apache
- Server
- Subversion
comments: []
---

I ran into a bit of an issue while setting up a new subversion server today. On that box we're running <a href="http://www.modsecurity.org/">mod_security</a> on all vhosts to add another layer of security to our web apps. I got everything configured with the the security, but when I was testing, I kept getting 403 errors when I attempted to get the files in anything other than a web browser.


After scratching my head for a while, I looked at the Apache logs, and noticed that mod_rewrite was causing the issue with lines like this:

~~~bash
[Tue Mar 06 13:46:46 2007] [error] [client xxx.xxx.xxx.xxx] mod_security: Access denied with code 403. Pattern match ”!(^$|^application/x-www-form-urlencoded$|^multipart/form-data)” at HEADER(“Content-Type”) [severity “EMERGENCY”] [hostname “svn.example.com”] [uri “/test”]
~~~

I stumbled on <a href="http://blog.charlvn.za.net/2006/09/subversion-modsecurity.html">Charl van Niekerk's</a> entry on this. One of the comments suggested that the following is the bare minimum to run mod_security on a vhost running subversion:

~~~
SecFilterSelective REQUEST_METHOD ”^(PROPFIND|PROPPATCH)$” allow
SecFilterSelective REQUEST_METHOD ”^(REPORT|OPTIONS)$” allow
SecFilterSelective REQUEST_METHOD ”^(MKACTIVITY|CHECKOUT)$” allow
SecFilterSelective REQUEST_METHOD ”^(PUT|DELETE|MERGE)$” allow
~~~

This should be in the first directives in your mod_security call:

~~~
<IfModule mod_security.c>
  # Enable ModSecurity
  SecFilterEngine On

  SecFilterSelective REQUEST_METHOD ”^(PROPFIND|PROPPATCH)$” allow
  SecFilterSelective REQUEST_METHOD ”^(REPORT|OPTIONS)$” allow
  SecFilterSelective REQUEST_METHOD ”^(MKACTIVITY|CHECKOUT)$” allow
  SecFilterSelective REQUEST_METHOD ”^(PUT|DELETE|MERGE)$” allow
</IfModule>
~~~

If you run a Subversion repository and have run into this issue, these security filters should help!
