---
layout: post
status: publish
published: true
title: Improving Ubuntu GUI Resposiveness
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 212
wordpress_url: http://www.liquidfoot.com/?p=212
date: 2006-08-17 10:50:06.000000000 -04:00
categories:
- General
tags:
- Linux
comments: []
image:
  feature: abstract-3.jpg
  credit: dargadgetz
  creditlink: http://www.dargadgetz.com/ios-7-abstract-wallpaper-pack-for-iphone-5-and-ipod-touch-retina/


---
I ran across this on Digg under the title <a href="http://martin.ankerl.org/2006/08/16/how-to-make-firefox-40-percent-faster/">How to Make Firefox Over 40% Faster</a>. While the improvement actually has nothing to do with Firefox, it does cover how to improve the CPU scaling settings.

Quick breakdown...

Uninstall powernowd

~~~ bash
sudo apt-get remove powernowd
~~~

Enable speed-stepping (I'm running Centrino)

~~~ bash
sudo modprobe speedstep-centrino
~~~

Enable the ondemand governor

~~~ bash
sudo modprobe cpufreq-ondemand
~~~

This step is a change from Martin's directions, his says to use sudo, but you can't write to /sys with sudo, so

~~~ bash
echo ondemand | sudo tee /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
~~~

Now it's just a matter of updating your performance settings:

Open */etc/modules* and add

~~~ bash
speedstep-centrino
cpufreq-ondemand
~~~

Install sysfsutils

~~~ bash
sudo apt-get install sysfsutils
~~~

Add to /etc/sysfs.conf

~~~ bash
devices/system/cpu/cpu0/cpufreq/scaling_governor=ondemand
~~~

Basically what this is doing is stepping up the processor frequency if the CPU reaches 80% utilization.
