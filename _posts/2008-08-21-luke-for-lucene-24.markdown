---
layout: post
status: publish
published: true
title: Luke for Lucene 2.4
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 34
wordpress_url: http://www.liquidfoot.com/?p=34
date: 2008-08-21 12:13:37.000000000 -04:00
categories:
- Programming
- Projects
tags:
- solr
- lucene
- luke
comments:
- id: 7
  author: Daniel
  author_email: claesen@home.se
  author_url: ''
  date: '2008-10-29 09:25:30 -0400'
  date_gmt: '2008-10-29 16:25:30 -0400'
  content: "Your jar doesn't work. I got the following error: Exception in thread
    \"main\" java.lang.NoClassDefFoundError: org/apache/lucene/document/Document\r\nCaused
    by: java.lang.ClassNotFoundException: org.apache.lucene.document.Document.\r\n\r\nSo
    I built it myself and it turns out that the lukeall and lukemin jars works but
    not the luke jar. It's the same with the one you download from the official luke
    homepage so there's probably an error in the build script or something. Maybe
    you should publish lukeall or lukemin instead?"
---
On the Vufind project, I've been migrating the Solrmarc codebase to use Solr 1.3. It's got a lot of nifty changes (the multi-core and DataImportHandler are really nice additions), including moving to Lucene 2.4 for the actual indexing.

On the down side, this means that <a href="http://www.getopt.org/luke/">Luke </a>doesn't have the correct analyzers or format interpretors (you get an incorrect format excpetion).

The fix is pretty quick. Just download the source tarball/zip for Luke (at the bottom of the page) and extract them somewhere. Then, grab a build of the Lucene 2.4 core, analyzers, and snowball analyzer (I grabbed mine from the <a href="http://people.apache.org/builds/lucene/solr/nightly/">Solr nightly build</a>).

Just throw the jars into Luke's lib folder (e.g. ~/luke-src-0.8-dev/lib) and then rebuild with Ant (ant). This will build the jars in the dist folder. You should be able to check out your index to make sure everything is good in the index.

If you're lazy and just want the one I created, here you go: <a href="http://www.liquidfoot.com/wp-content/uploads/2008/08/luke-08-dev.jar">luke-08-dev</a>
