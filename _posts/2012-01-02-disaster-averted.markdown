---
layout: post
status: publish
published: true
title: Disaster Averted
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 396
wordpress_url: http://www.liquidfoot.com/?p=396
date: 2012-01-02 15:56:03.000000000 -05:00
categories:
- Projects
tags:
- tips
- writing
- word
- tricks
comments: []
---
Today as I was finishing chapter 10 of my forthcoming book, I ran in to a major issue. My publisher (Apress) uses Microsoft Word templates for submissions. As I was finishing the summary, the Word wheel started spinning and I was soon notified that Word couldn't save the file. Not a big deal, I just saved it to another file name. I renamed the file and tried to open it back up and I got an error that Word could not open the file as it was larger than 32MB. Panic set in, and some swearing (ok, a lot). I looked at the file and it was a whopping 684Mb.

After some Googling, I ran in to some directions on how to fix the problem for Windows users. Basically you copy the file, rename it as a zip file, expand the directory, and resize the files. On my OS X box, I resized the images with <a href="http://imageoptim.pornel.net/">ImageOptim</a>&nbsp;(I use it when I need a quick and dirty image compressor). However, when I re-compressed the files with the Compression utility, I kept getting errors in Word that it could not open the file. Again, panic and a lot of swearing (we are talking about 30 pages here).

Turns out I just needed the zip utility. I just went in to the directory that had my expanded zip files and recursively zipped all the files back in:

{% highlight bash %}
cd ch10
zip -r ch10.zip *
mv ch10.zip ch10.docx
{% endhighlight %}

I opened the file back up in Word and after some complaining that the file format wasn't correct, the file open with all the content in it! Hopefully you will never run in to this, but if you do, the fix isn't that difficult.

&nbsp;

