---
layout: post
status: publish
published: true
title: rdesktop and Tcl/tk
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
excerpt: 'This is something I did a few years ago and has been very useful. I’m a
  *nix admin that occasionally needs to log on to a Windows server. I used rdesktop
  for a long time to do this. I wanted, though, a nice GUI that would allow me to
  pick which server I wanted (and an excuse to play a bit with Tcl). '
wordpress_id: 242
wordpress_url: http://www.liquidfoot.com/?p=242
date: 2009-01-16 09:36:17.000000000 -05:00
image:
  feature: abstract-3.jpg
  credit: dargadgetz
  creditlink: http://www.dargadgetz.com/ios-7-abstract-wallpaper-pack-for-iphone-5-and-ipod-touch-retina/

categories:
- General
- Systems Admin
tags:
- Linux
- Windows
- tcl
- script
- systems administration
comments: []
---
<p>This is something I did a few years ago and has been very useful. I'm a *nix admin that occasionally needs to log on to a Windows server. I used rdesktop for a long time to do this. I wanted, though, a nice GUI that would allow me to pick which server I wanted (and an excuse to play a bit with Tcl). This is the script I came up with to do just this:</p>

~~~ruby
#! /usr/bin/wish

wm title . "Remote Desktop Launcher"

frame .top -borderwidth 10
pack .top -side top -fill x

button .top.quit -text Quit -command exit
set but [button .top.run -text "Launch" -command Run]
pack .top.quit .top.run -side right

label .top.l -text Server: -padx 0
entry .top.cmd -width 20 -relief sunken -textvariable server
pack .top.l -side left
pack .top.cmd -side left -fill x -expand true

bind .top.cmd &amp<Return&amp> Run
focus .top.cmd

menubutton .mb -text Server -menu .mb.menu
pack .mb -padx 10 -pady 10

set m [menu .mb.menu -tearoff 1]
$m add radio -label server1 -variable server -value server1.address.edu -command Run
$m add radio -label server2 -variable server -value server2.address.edu -command Run
$m add radio -label server3 -variable server -value server3.address.edu -command Run
$m add radio -label server4 -variable server -value server4.address.edu -command Run
$m add radio -label server5 -variable server -value server5.address.edu -command Run

proc Run { } {
    global server
    exec rdesktop -u &amp<user_name&amp> -p &amp<password&amp> -g 1280x800 -x b $server
}
~~~


<p>All you need to do is plugin "real" values for the server and addresses. You can also auto-login by giving values for the username and password (may also want to change the geometry of the window unless you have a big screen).</p>

<p><a href="http://www.liquidfoot.com/wp-content/uploads/2009/01/rdesktop.png"><img class="alignnone size-medium wp-image-246" title="rdesktop" src="http://www.liquidfoot.com/wp-content/uploads/2009/01/rdesktop-300x202.png" alt="rdesktop" width="300" height="202" /></a></p>
<p>I also have bash aliases for these, but that's a different post...</p>
