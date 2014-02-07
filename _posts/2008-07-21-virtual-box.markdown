---
layout: post
status: publish
published: true
title: Virtual Box
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 26
wordpress_url: http://www.liquidfoot.com/?p=26
date: 2008-07-21 06:22:19.000000000 -04:00
categories:
- General
tags:
- virtual box
- vmware
comments: []
---
On several of the projects I work on, it's very handy to have multiple operating systems installed to test out my code. For a while I've been using VMWare. It's been working pretty nicely and I didn't have many complaints. I did experience some headaches when I upgraded to Ubuntu 8.04 because of the kernel packages, but after a couple of bug fixes, recompiling, and reconfiguring, everything was happy.

I've got a Mac Pro on the desk next to me that we've been running Parallels on to run some of our Windows-only software (e.g. the client for our library catalog). Phil saw that there was support for Windows on OS X 10.5, so we threw Virtual Box on it to try it out. Here are my observations thus far running the software on Ubuntu and Leopard:

<ol>
	<li>Virtual Box seems to be a bit faster. I have no tests to back this up, it just <em>seems</em> faster.</li>
	<li>The VDIs are nice (here's a <a href="http://veedee-eyes.com/veedeeeyes/vdi/index">longer list</a> of VDIs)</li>
	<li>Permissions for the kernel driver can cause a small headache (be sure to add your user account to the vboxusers group).</li>
	<li>Virtual Box doesn't require me to go get keys when I rebuild a computer and forget to write down the key :)</li>
</ol>
So far, I really am liking Virtual Box...
