---
layout: post
status: publish
published: true
title: Automatic rvm gemsets
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 369
wordpress_url: http://www.liquidfoot.com/?p=369
date: 2010-10-03 08:35:17.000000000 -04:00
categories:
- General
- Programming
tags: []
comments:
- id: 271
  author: Adam
  author_email: sheerun@sher.pl
  author_url: http://sher.pl
  date: '2011-01-22 08:36:56 -0500'
  date_gmt: '2011-01-22 15:36:56 -0500'
  content: Great feature, thanks!
---
I've been using Ruby version manager (rvm) for a while now, but hadn't really been paying too much attention to its new features. Over the weekend, I ran in to perhaps one of the coolest new features: project-level configurations. Essentially this allows you to set up your Ruby project to automatically switch gemsets when you enter the directory with the terminal.

To try this out, I created a new gemset and then told my project about it:

{% highlight bash %}
rvm gemset create project_name
cat "rvm ruby@project_name" > path/to/project/.rvmrc
{% endhighlight %}

Now, when you <code>cd</code> in to the directory, rvm will automagically switch gemsets for you. No more firing up rails only to get the error message that you don't have the right rubies installed. Great time saver, and if you're managing projects that aren't using bundler yet, a real time saver!

