---
layout: post
status: publish
published: true
title: Rails and GIS
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
excerpt: As a part of my research time, I've started dusting off an old project I
  always wanted to get back to. Back in 2005 I started working with some folks who
  were starting to write an article on the development of architectural identity in
  the early Chesapeake for the William and Mary Quarterly. I wrote the application
  in ColdFusion and used MSSQL as the backend. When the same data was used for another
  article in the Journal of Southern History, I quickly whipped up an app that would
  at least display the information. I was never happy with it, but didn't have the
  time to undertake this again.
wordpress_id: 308
wordpress_url: http://www.liquidfoot.com/?p=308
date: 2009-08-30 16:11:20.000000000 -04:00
categories:
- Programming
- Projects
tags: []
comments: []
---
As a part of my research time, I've started dusting off an old project I always wanted to get back to. Back in 2005 I started working with some folks who were starting to write an article on the development of architectural identity in the early Chesapeake for the William and Mary Quarterly. I wrote the application in ColdFusion and used MSSQL as the backend. When the same data was used for another article in the Journal of Southern History, I quickly whipped up an app that would at least display the information. I was never happy with it, but didn't have the time to undertake this again.

One of the things I never liked the way I handled was describing the basic location. At first the architectural historians wanted to use UTM coordinates. I switched to latitute/longitude and wrote some conversion code to switch between the two. I was bothered, though, that describing a "site" by a point. Obviously a site is an area that contains some number n buildings. Even worse, the points were really just the centroids of the county/city of the information that was entered as the archaeologists didn't have have information. There had to be a better way to approach the description of this information over time.

I started working at UVa earlier this spring and one of their big pushes has been GIS in the humanities. A light went off and I saw a rather nice use of using the concepts of GIS to better describe and interact with my information. I also really wanted to migrate the information to a more open format as well as really spend some time envisioning what the application should look like.

I've started working on this migration and have posted it on <a href="http://github.com/waynegraham/DECA">Github</a>. To give a brief explanation of how the application. I'm using PostGIS as the backend. On OS X, getting this ready took a bit, but I think I got it explained in the README file decently. It took a while to get the correct templates ready in PostgreSQL.

I'm using OpenLayers for interacting with the maps (through <a href="http://github.com/pka/map_layers/tree/master">map_layers</a>), and the <a href="http://github.com/fragility/spatial_adapter/tree/master">spatial_adapter</a> plugin and the <a href="http://georuby.rubyforge.org/">GeoRuby</a> gem.

I'm expecting there to be some refactoring of the data from MSSQL, but I think PostgreSQL will be a much better solution for my open source leanings.

I'll try to keep this updated with my progress...at least until our development blog gets off the ground.
