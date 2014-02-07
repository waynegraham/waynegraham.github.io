---
layout: post
status: publish
published: true
title: Choosing a PHP Framework
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 38
wordpress_url: http://www.liquidfoot.com/?p=38
date: 2008-09-03 07:39:22.000000000 -04:00
categories:
- Programming
- Projects
- Featured
tags:
- neh
- frameworks
- php
- codeigniter
- zend
- cakephp
comments: []
---
I'm working on an NEH funded collaborative research grant entitled "Measuring the Social, Spatial, and Temporal Dimensions of Virginia Slave Housing." The project is exciting because it's taking existing architectural, archaeological, and documentary evidence to create a standard presentation for the information. A perhaps more important, though secondary (or I dare say tertiary) part is a standardized form for recording the information in the field. Right now most of this information is in varying levels of completeness, based mostly on the researcher and the sponsoring institution's goals.

So, through the process of generating the database schema, we developed about 25 relational tables that record varying degrees of information. The basic idea is that there is a meta-object (a site) that contains one-or-more buildings. Each of these buildings can have a one-or-more phases (adding editions) and then each phase has additional information on a room-by-room basis (doors, windows, fire places, etc.).

I had built a similar database for a project looking at Chesapeake architecture for the Jamestown 400th anniversary celebrations (<a href="http://www.historycooperative.org/journals/wm/64.3/graham.html">Adaptation and Innovation: Archaeological and Architectural Perspectives on the Seventeenth-Century Chesapeake</a>) in ColdFusion using <a href="http://trac.reactorframework.com/">Reactor</a> with an MSSQL backend. However, this project requied slightly different specs as it is being hosted in a different location that doesn't offer ColdFusion hosting. They have the basic \*AMP stack, so I started looking around at the different PHP frameworks to aid in the development of the application.

After a little investigation, I narrowed down the choices to what I'm calling the Big-Three: <a href="http://framework.zend.com/en/">Zend</a>, <a href="http://codeigniter.com/">CodeIgniter</a>, and <a href="http://cakephp.org/">CakePHP</a> (yes, I know there are more). While looking at these, I needed something that I can pick up quickly, let's me quickly build the different forms needed to populate the information, have a sizable community to help solve issues that pop up, and also be flexible enough to quickly change the database backend when needed (and when working with academics, this happens more than you really want it to).

Zend has some great features. It's backed by a company (Zend) who provides training. They have support and training courses, but this is a for-profit company, so the cost is a bit prohibitive for a small research project (with very little funding). Their site does provide good documentation, video examples, and a really cool integration with Lucene (<a href="http://framework.zend.com/manual/en/zend.search.lucene.html">Zend_Search_Lucene</a>). I thought the <a href="http://framework.zend.com/docs/quickstart">QuickStart</a> was a bit on the light side, but thought it had a really rich feature set (at least for what I need it to do).

Next up was <a href="http://codeigniter.com/">CodeIgniter</a>. I was a bit dazzled by this. I liked it small footprint and it seemed lighter and didn't have strict naming conventions. It also had scaffolding! This is quite important in the development process as the database backend will change through the course of the site development. I know, it's not a good idea to put this into a production environment, but we're talking about maybe two other people working on this at one time. The video tutorials are pretty nice, and there seemed to be a good group of folks adding content all the time. There are some nice authentication libraries (FreakAuth) and it's pretty easy to get something up on the screen.

I had played (briefly) with <a href="http://cakephp.org/">cakePHP</a> over the summer. I was intriged with "baking" the application (the metaphore gets a bit overplayed). Essentially they developed a script that will take the scaffolding and then generate the basic models, views, and controllers for the application. It even goes a step further with login permissions (though there's a bit of manual updating there). I didn't really dig how they really push the naming conventions, but I quickly figured out how to over ride most of them.

In the end, I've decided to go with cakePHP for this application. I really liked the fact that I could get away with writing very little code and generate most of what I'll need to get the administrative backend up-and-running. I may be disappointed in this decision, but as I make progress on the project, I'll add more posts on some of the pit-falls and successes.
