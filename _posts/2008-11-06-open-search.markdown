---
layout: post
status: publish
published: true
title: Open Search
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 116
wordpress_url: http://www.liquidfoot.com/?p=116
date: 2008-11-06 09:32:45.000000000 -05:00
categories:
- Programming
- Computing
tags:
- opensearch
- application
comments: []
---
It's been a while since I last posted, but the NEH Slave Quarters project is coming to a close and the next grant is out the door (to build a digital archive of the newspaper articles of Elizabeth Stoddard).

So I showed my student worker the search plugins I had made a few years ago and he got really excited. They're burried on our website right now (but then again, so is everything), but he like the convienence. He actually got me to start thinking about it a bit more. IE 7 and Firefox both use OpenSearch now for their search plugins. There's not a whole lot to this description (and it's a lot more convienent than the Sherlock format). What if I built a quick app that could generate the XML for these and them people could install them? We could quickly develop a collection of useful plugins that would help folks get to data (hopefully) faster.

I started looking at it yesterday and it's pretty straight forward...with a few exceptions. Most search engines use a get method, but I'm finding a bunch of our most popular search engine providers (e.g. lexisnexis, factiva, etc.) use a post method with weird session variables.

Focusing on just the "easy" stuff first, I wrote a database table (which is still in flux) that recorded the basic OpenSearch fields first: short_name, description, input_encoding, and url. I populated the fields with some basic search engines that folks use here at William and Mary: all the libraries, Google Scholar, Ebrary, JStor, EbscoHost, ScienceDirect, and our federated searching engine). I wrote a search proxy to rewrite the search URLs, though it's really not necessary (and I may change that).

Since I got on the kick, I figured I'd write something up real quick for Vufind too. By adding a few lines of code, folks will be able to add the Vufind instance to their search list without doing much!

After I get the code a bit cleaner, and work through some of the other "issues" with search providers who use 'POST' for queries, I'll add some code.
