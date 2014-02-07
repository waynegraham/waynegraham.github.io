---
layout: post
status: publish
published: true
title: Sourceforge Goodness
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 24
wordpress_url: http://www.liquidfoot.com/?p=24
date: 2008-07-18 18:12:49.000000000 -04:00
categories:
- Programming
- Projects
tags:
- vufind
- svn
- sourceforge
comments: []
---
Yesterday Sourceforge was doing some work on their SVN projects. We've been using them for the Vufind project. I was attempting to finish putting in a snapshot of the solrmarc code to use that codebase for indexing marc. I put in the stuff out of the Google repository, but hadn't realized that Andrew had modified the solrmarc code in the Vufind project and we were missing a couple of functions. I was going to modify the code by just going into the SVN browse on Sourceforge, but it's still a bit on the flaky side. Right now the solrmarc code isn't a little out of synch with the Vufind code, but I should hopefully get that fixed up this weekend.

I did add a bunch of code to the solrmarc project today for logging using log4j. I have to say it's pretty nice to actually have spent the time to actually get most of this implemented since logging had been on my list of //TODO. 
