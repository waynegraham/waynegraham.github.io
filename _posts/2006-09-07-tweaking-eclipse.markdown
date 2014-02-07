---
layout: post
status: publish
published: true
title: Tweaking Eclipse
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 204
wordpress_url: http://www.liquidfoot.com/?p=204
date: 2006-09-07 16:30:14.000000000 -04:00
categories:
- Projects
tags:
- java
- Windows
- Eclipse
comments: []
image:
  feature: abstract-3.jpg
  credit: dargadgetz
  creditlink: http://www.dargadgetz.com/ios-7-abstract-wallpaper-pack-for-iphone-5-and-ipod-touch-retina/

---

I finally got fed up yesterday with the slow speed at which Eclipse was launching on my Windows box. On my Linux box, it doesn't take <em>that</em> long to launch (may five or six seconds) compared to my Windows box (around 15 - 20 seconds). I know I have a lot of plugins, but it was getting a little ridiculous. I started poking around and I noticed in the configuration details (Help / About Eclipse SDK / Configuration Details) that the vm that was launching was 1.4. Ok, so there's one problem. I also noticed that the max memory setting was 256MB (-Xmx256M). Since this box has 2GB of RAM, I figured 256MB is a little on the low side (and note, mucking around with the heap sizes won't help load times).

The first thing I did was change the shorcut target for Eclipse to be

~~~bash
C:\eclipse\eclipse.exe -vm "C:\Program Files\Java\jdk1.5.0_08\bin\javaw.exe"
~~~

Now I'm sure that Eclipse will launch with Java 5 and (hopefully) speed things up a bit. Double-click on the short-cut, and sure enough, we're down to about 8 seconds.

The next thing I wanted to do is increase the default min and max memory settings. In c:\eclipse\eclipse.ini, you'll see

~~~bash
-vmargs
-Xms40M
-Xmx256M
~~~


I changed these to

~~~bash
-vmargs
-Xms256m
-Xmx768m
~~~

This increases the minimum memory space to 256M and the maximum to 768M. You can also do this by adding these vmargs to the shortcut target:

~~~bash
C:\eclipse\eclipse.exe -vm "C:\Program Files\Java\jdk1.5.0_08\bin\javaw.exe" -vmargs -Xms256M -Xmx768M
~~~

If you have a multi-processor computer (and I believe this includes dual-core systems, though I haven't read the docs on this), you can use some of the new VM ergonomics to self-tune garbage collection by adding this switch:

~~~bash
-XX:+UseParallelGC
~~~

One last handy parameter is "-showlocation" which shows the current location of your workspace. If you have different workspaces, this is handy.

If you want to read more about some JVM garbage collection (and who doesn't) here are some helpful links:
<ul>
	<li><a href="http://java.sun.com/javase/technologies/hotspot.jsp">Java SE HotSpot at a Glance</a></li>
	<li><a href="http://java.sun.com/j2se/1.5.0/docs/guide/vm/gc-ergonomics.html">Garbage Collector Ergonomics</a></li>
	<li><a href="http://java.sun.com/docs/hotspot/gc5.0/gc_tuning_5.html">Tuning Garbage Collection with the 5.0 Java Virtual Machine</a></li>
	<li><a href="http://java.sun.com/docs/performance/">Java Performance Documentation</a></li>
	<li><a href="http://blogs.sun.com/watt/resource/jvm-options-list.html">A Collection of JVM Options</a> (check out the references at the bottom of the page)</li>
</ul>
