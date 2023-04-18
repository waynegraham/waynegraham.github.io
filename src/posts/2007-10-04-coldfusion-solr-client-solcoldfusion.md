---
layout: post
status: publish
published: true
title: Coldfusion Solr Client - SolColdfusion
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 182
wordpress_url: http://www.liquidfoot.com/?p=182
date: 2007-10-04 15:19:47.000000000 -04:00
image:
  feature: abstract-3.jpg
  credit: dargadgetz
  creditlink: http://www.dargadgetz.com/ios-7-abstract-wallpaper-pack-for-iphone-5-and-ipod-touch-retina/

categories:
- Programming
- Projects
- Computing
tags:
- solr
- lucene
- coldfusion
- Apache
comments:
- id: 261
  author: Alejandro
  author_email: adelgadilloix@gmail.com
  author_url: ''
  date: '2010-10-20 08:54:32 -0400'
  date_gmt: '2010-10-20 15:54:32 -0400'
  content: Wayne, the path you mentioned in the Coldfusion Solr Client - SolColdfusion
    post... where can i find it in Solr? I've never seen that path directly from the
    root, there is one inside webapps folder... is that the one?
- id: 264
  author: Wayne
  author_email: wayne@liquidfoot.com
  author_url: http://liquidfoot.com
  date: '2010-10-21 13:52:04 -0400'
  date_gmt: '2010-10-21 20:52:04 -0400'
  content: "Alejandro,\n\nWhat version of CF are you using? In CF 9, there's native
    support... \n\nThe patch was never officially accepted by the Solr project because
    none of the committers ran CF, but the source can be found over at RIAForge (http://solcoldfusion.riaforge.org/)."
- id: 268
  author: Alejandro
  author_email: adelgadilloix@gmail.com
  author_url: ''
  date: '2010-11-04 12:56:29 -0400'
  date_gmt: '2010-11-04 19:56:29 -0400'
  content: "Wayne,\r\n\r\nThanks for the link to the component, I decided to give
    it a try... following your tutorial line by line I've came to this problem\r\n\r\nhttp://img253.imageshack.us/img253/9751/cfsolr.png\r\n\r\nmaybe
    you can help me out a bit on how to solve it..."
- id: 269
  author: Clifford
  author_email: racz@purdue.edu
  author_url: ''
  date: '2010-11-29 15:07:00 -0500'
  date_gmt: '2010-11-29 22:07:00 -0500'
  content: "The params is an array, but you want to pass a struct, so do something
    like this:\r\n\r\nparams = StructNew();\r\nparams[\"indent\"] = \"off\";\r\nparams[\"wt\"]
    = \"standard\";\r\nparams[\"fl\"] = \"*,score\";\r\nparams[\"qt\"] = \"standard\";\r\nparams[\"wt\"]
    = \"standard\";\r\nparams[\"start\"] = 0;\r\nparams[\"rows\"] = 10;\r\nparams[\"hl\"]
    = \"on\";\r\nparams[\"hl.fl\"] = \"*\";\r\nparams[\"hl.fragsize\"] = 50000;\r\nparams[\"hl.highlightMultiTerm\"]
    = \"true\";\r\nparams[\"q\"] = \"foobar\";"
---

As I hinted at yesterday, I was close to having some code in the pipeline to abstract using Solr. I've finished the initial code with the following built in. Here's a brief setup guide to start playing with the code.

First, you're going to need to grab the latest <a href="http://www.apache.org/dyn/closer.cgi/lucene/solr/">release version of Solr (currently 1.2)</a>. The only real requirement to run this software is that you have a JRE of 1.5 or higher. Untar/zip the file somewhere convenient and open a command prompt. Get to the example directory in the apache-solr.1.2.x folder (cd /example). To start up the sample server running Jetty, just issue the following command:

~~~
java -jar start.jar
~~~

This will start a new instance of the Solr server on your computer on port 8983. You can make sure this is running by navigating to <a href="http://localhost:8983/solr">http://localhost:8983/solr</a> (NOTE: this is a link to your computer. If you get an error, it's because your computer isn't running an instance of Solr on port 8983).

At this point, it's probably good to send you over to the Solr website to take a look at <a href="http://lucene.apache.org/solr/tutorial.html">their tutorial</a>. Go ahead. I'll wait...

...

Great, you're back.

You've seen some basic inserting, deleting, and querying of Solr index data. You may have also noticed that there are clients for PHP, Ruby, Python, and Java...no ColdFusion. I want to do a little more testing on this before I submit the patch, but I've added the initial code as an encosure here to do updating, deleting, and searching in Coldfusion.

The CFC SolColdfusion should be in the path org/apache/client (at least that's where I'm putting in for the purposes of this initial demonstration). The initialization takes one required parameter (the Solr host) and then has two optional parameters (port and path).

To set this up, create an instance with

~~~html
<cfset solr = createObject(“component”, “org.apache.solr.client.SolColdfusion”).init(“http://localhost”, “8983”, “/solr”) />
~~~

Now, there are a lot of different parameters you can send to Solr to perform different queries. And, since some of these key names can repeat, I chose to implement sending these parameters as an array. So, let's set this up.

~~~html
<cfset params = arrayNew(1) />
<cfset params[1][1] = “indent”>
<cfset params[1][2] = “on” />
<cfset params[2][1] = “wt”>
<cfset params[2][2] = “standard” /> 
<cfset params[3][1] = “fl” /> 
<cfset params[3][2] = “*,score” /> 
<cfset params[4][1] = “qt” />
<cfset params[4][2] = “standard” /> 
<cfset params[5][1] = “wt” /> 
<cfset params[5][2] = “standard” />
~~~

These parameters are basically what are the defaults that Solr will return back to you. If you want highlighting, you would need to add two additional row vectors with 'hl = on' and 'hl.fl = '.

Searching is straight forward, taking a query, the start row, number of rows to return, and the array of parameters:

~~~html
<cfset results = solr.search("*:*", 0, 10, params) />
~~~


This searches all fields and all content and returns back an XML document with the search results in it.

~~~html
<cfdump var=“#results#” />
~~~

In the result node, you'll see that Solr returns an xmlAttribute of *numFound of 0* (assuming you don't have anything in the index). Let's add an example document from the documents that come with Solr.


~~~html
<cfxml variable=“sample”>
  <doc>
    <field name="id">F8V7067-APL-KIT</field>
    <field name="name">Belkin Mobile Power Cord for iPod w/ Dock</field>
    <field name="manu">Belkin</field> 
    <field name="cat">electronics</field> 
    <field name="cat">connector</field> 
    <field name="features">car power adapter, white</field> 
    <field name="weight">4</field> <field name="price">19.95</field> 
    <field name="popularity">1</field>
    <field name="inStock">false</field> 
  </doc> 
</cfxml>

<cfset solr.add(sample) />
<cfset solr.commit() /> 
<cfset solr.optimize() />

<cfset results = solr.search(“id:F8V7067-APL-KIT”, 0, 10, params) />

<cfdump var=“#xmlParse(results)#” />
~~~

You'll notice I used a commit and optmize statement. Neither of these statements are necessary every time you add a document, but be aware that Solr caches documents and won't flush the new documents to disk unless you either commit the documents or the mergefactor setting you used in your solrconfig.xml file has been reached.


Now, let's delete this document...

~~~html
<cfset solr.deleteById("F8V7067-APL-KIT") /> 
<cfset solr.commit() />
~~~

Don't forget to commit deletions to the index!

There'll be more soon (add multiple documents, delete by queries). In the mean time, try it out. If you have any comments, questions, concerns, whatever, let me know.
