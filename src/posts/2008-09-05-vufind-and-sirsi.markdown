---
layout: post
status: publish
published: true
title: Vufind and Sirsi
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 58
wordpress_url: http://www.liquidfoot.com/?p=58
date: 2008-09-05 14:08:25.000000000 -04:00
image:
  feature: abstract-3.jpg
  credit: dargadgetz
  creditlink: http://www.dargadgetz.com/ios-7-abstract-wallpaper-pack-for-iphone-5-and-ipod-touch-retina/

categories:
- Programming
- Projects
tags:
- solrmarc
- vufind
- tips
- sirsi
comments: []
---
I committed a bunch of small fixes into the <a href="http://code.google.com/p/solrmarc">Solrmarc</a> and <a href="http://www.vufind.org">Vufind</a> projects today to deal with the release of Solr 1.3 RC 2. We're using the multicore functionality of Solr for Vufind and we were having some issues with the resource loaders for the different cores. The fix was pretty minor, just creating a <a href="http://lucene.apache.org/solr/api/org/apache/solr/core/CoreContainer.html">CoreContainer</a> and set the SolrCore from that:

~~~java
CoreContainer cc = new CoreContainer(solrCoreDir, configFile);
solrCore = cc.getCore(solrCorename);
~~~

Ok, so that was more of an update, but it got me to reindex the our marc content. Our 001 fields don't always have info, so our Systems Librarian told me just to use the 035a for the id field. There was only one problem...they had a "(Sirsi)" as a prefix to the actual number. This wouldn't be that big of an issue, but it was causing the queries sent to Solr to be off, and I wasn't getting any results for a detail view.

Fortunately, Solrmarc already has a facility to deal with this: PatternMaps! To pull out just the number, I changed the id definition in the vufind.properties file to

~~~java
id = 035a, (pattern_map.id), first
~~~

This basically maps the id field in the schema.xml file to the 035a, using a patternMap named pattern_map.id, and only takes the first of the 035a if there are multiples. I know, there shouldn't be, but I've seen funky things :)

Now, to add the PatternMap definition:

~~~java
pattern_map.id.pattern_0 = \\(Sirsi\\)\\ (.*)=>$1[/code]

It's just a simple regex pattern definition that takes out the "(Sirsi)" and the space between it and the actual id we're using.
