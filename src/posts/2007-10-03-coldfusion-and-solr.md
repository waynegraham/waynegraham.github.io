---
layout: post
status: publish
published: true
title: ColdFusion and Solr
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 184
wordpress_url: http://www.liquidfoot.com/?p=184
date: 2007-10-03 15:38:43.000000000 -04:00
image:
  feature: abstract-3.jpg
  credit: dargadgetz
  creditlink: http://www.dargadgetz.com/ios-7-abstract-wallpaper-pack-for-iphone-5-and-ipod-touch-retina/

categories:
- General
tags:
- solr
- lucene
- coldfusion
comments: []
---

I've spent the last few months working on some projects that didn't really have anything to do with ColdFusion (lots of Java and PHP). One of the projects I've been working with (<a href="http://www.vufind.org/">Vufind.org</a>) uses <a href="http://lucene.apache.org/solr/">Solr</a> as it's indexing/search engine. That's starting to get picked up by some pretty big companies (Netflix just relaunched their search using Solr this week).

I've been working with Solr in Java for a bit now, and I wanted to start to build an interface for using it as a search engine (my Lucene code is stuck in open source limbo) in Coldfusion. One of the cool things about Solr is that it returns results back through HTTP (in XML, JSON, or ruby).

As soon as I get the code finished, I'll post it as a patch in Solr.
