---
layout: post
status: publish
published: true
title: Map Hacking
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 314
wordpress_url: http://www.liquidfoot.com/?p=314
date: 2009-11-17 19:28:37.000000000 -05:00
categories:
- Programming
- gis
- mapping
tags: []
comments: []
---
We've been hosting an NEH Institute for Enabling Geospatial Scholarship this week and we have a lot of different folks coming together to talk about mapping issues in higher education. I almost haven't been able to keep my delicious tagging up with all the kewl new tools folks have been talking about.

One thing I did try out this evening when I got home was <a href="http://www.mapstraction.com/">Mapstraction</a>. My wife has a set of data (reading test scores) that she's been wanting to look at to see if there were neighborhoods where students were underperforming. Using a short ruby script (with the graticule gem), I geocoded addresses, calculated a median score across five reading tests, then plotted them using Mapstraction. At the top, I added some slider controls for filtering the data points, and viola, a really quick-and-dirty interactive map that lets her quickly filter ranges of scores to start looking for patterns.

Now to tweak the algorithm for generating the scores...
