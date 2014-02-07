---
layout: post
status: publish
published: true
title: Getting XML from MSSQL Server
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 210
wordpress_url: http://www.liquidfoot.com/?p=210
date: 2006-08-21 11:49:57.000000000 -04:00
categories:
- General
tags:
- coldfusion
- XML
- AJAX
- MSSQL
comments: []
image:
  feature: abstract-3.jpg
  credit: dargadgetz
  creditlink: http://www.dargadgetz.com/ios-7-abstract-wallpaper-pack-for-iphone-5-and-ipod-touch-retina/

---
I've been playing with <a href="http://openrico.org/">all</a> <a href="http://swem.wm.edu/blogs/waynegraham/index.cfm/2006/scriptaculous">the</a> <a href="http://labs.adobe.com/technologies/spry/">AJAX</a> <a href="http://dojotoolkit.org/">stuff</a> <a href="http://developer.yahoo.com/yui/">that's</a> <a href="http://code.google.com/webtoolkit/">been</a> <a href="http://mochikit.com/">coming</a> <a href="http://www.aflax.org/">out</a> <a href="http://jquery.com/">lately</a>. I suppose that like a lot of folks, I was creating a query, then having a generic function that created the XML in a proxy file for the JavaScript (<a href="http://ray.camdenfamily.com/index.cfm/2006/7/13/ToXML-Update">Ray Camden has a really nice function for transforming a query to XML</a>).

Last week I was doing some research to find a way to do some XML searching and stumbled upon the <a href="http://msdn2.microsoft.com/en-us/library/ms190922.aspx">FOR XML</a> statement. I knew that most RDBMSs were capable of dealing with XML record sets, but it's been years since I've even looked at any of the XML stuff for MSSQL.

The FOR XML statement returns a query result and transforms rows into XML elements. There are three arguments that this can take:
<ul>
	<li><a href="http://msdn2.microsoft.com/en-us/library/ms175140.aspx">RAW</a>: Transforms each row into an element with a generic identifier (<row/>) as the element tag.</li>
	<li><a href="http://msdn2.microsoft.com/en-us/library/ms188273.aspx">AUTO</a>: Returns the results in a simple nested XML tree</li>
	<li><a href="http://msdn2.microsoft.com/en-us/library/ms175140.aspx">EXPLICIT</a>: Allows you to define the XML tree returned</li>
</ul>
