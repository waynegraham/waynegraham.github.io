---
layout: post
status: publish
published: true
title: Zotero + Ruby == Fun!
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 345
wordpress_url: http://www.liquidfoot.com/?p=345
date: 2010-04-17 09:36:10.000000000 -04:00
categories:
- Projects
tags:
- zotero
- rails
- gem
- plugins
comments: []
---
Last week I was on a panel at the Organization of American Historian's Annual Meeting up in DC with some folks from <a href="http://chnm.gmu.edu/">CHNM</a>. One of the really cool thing that I've noticed is every time I'm around those folks, I get ideas...which can be dangerous. I had been meaning to poke at the Zotero API for a while and after talking with <a href="http://twitter.com/tjowens/">@tjowens</a>, <a href="http://twitter.com/joegilbert">@joegilbert</a>, and <a href="http://twitter.com/clioweb">@clioweb</a> over some falafels, I started putting some ideas together on the train home.

Over the last couple of years, I've been working on-and-off on improving the <a href="http://deca.swem.wm.edu/">Database of Early Chesapeake Architecture</a>. I'd recently gotten the data (again) from Swem Library and had been working on pushing it to a more open framework (it was ColdFusion + MSSQL; now Rails + Postgresql). What I wanted to be able to add in is an extensible method of citation for the various buildings and sites used (check out the <a href="http://deca.heroku.com">work-in-progress</a>). At the time, I tried to use RefWorks (with very little success) to handle the citations, but with the improvements to Zotero (and it's Group ability), I thought I'd go down this road and test if this is a viable method of citation management.

I first took a look at Jeremy's <a href="http://github.com/clioweb/phpZotero">phpZotero code</a>. The first thing I noticed is that there's a pretty funky way that you have to construct URLs for the "API" (I think the Zotero API is more of an RSS decorator than an API, but hopefully they're working on that). Essentially you construct a URL requests to the Zotero API server with a user ID. Unfortunately, most people don't know their user_id, so the PHP code goes and looks this up on a different server, parses out the user_id, then constructs an HTTP request for RSS data from the API server. I kind of brace a bit at the thought of every request needing to go to two servers (multiple points of failure, speed, etc.). When I started creating a ruby wrapper for these calls, I made the object use the user_id (Integer) and not the user_name (String). Knowing folks might not know their user_id, I whipped up a quick Sinatra app on heroku to look up Zotero User ids: <a href="http://zotero-id-finder.heroku.com/">zotero-id-finder</a> (source on <a href="http://github.com/waynegraham/Zotero-ID-Finder">github</a>).

Next, I needed something to not have to use Nokogiri all the time to grab info off the Zotero server. I made a basic Gem to wrap these requests named <a href="http://rubygems.org/gems/rzotero">rzotero</a>. This is really helpful, but what I really wanted to do is add citations to ActiveRecord models a la acts_as_taggable. To that end, I started mocking up <a href="http://github.com/waynegraham/acts_as_citable">acts_as_citable</a> which will allow you to add in citations identifiers to be used with rzotero plugin to record and display items in a collection in ActiveRecord contexts.

As a warning, all of these are in a pre-alpha-ish state and may (badly) break your code (especially since it's lightly tested right now). As things progress, I'll have more posts here, and over on the <a href="http://www.scholarslab.org">Scholars' Lab site</a>.

