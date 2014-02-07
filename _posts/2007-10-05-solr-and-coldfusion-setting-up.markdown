---
layout: post
status: publish
published: true
title: Solr and Coldfusion -- Setting Up
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 180
wordpress_url: http://www.liquidfoot.com/?p=180
date: 2007-10-05 12:22:14.000000000 -04:00
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
- coldfusion
- Apache
comments: []
---

To get up and running with Solr, you'll need some type of Servlet container. Typically when folks start talking about servlet containers, they're talking about <a href="http://tomcat.apache.org/">Tomcat</a> or <a href="http://jetty.mortbay.org/">Jetty</a>. In fact, Solr comes with Jetty 6.1.3 (they haven't upgraded to 6.1.5 yet in the distribution). You may also hear about <a href="http://www.caucho.com/">Resin</a>, but in my experience, it runs a bit slower than Jetty and Tomcat. As a small note, servlet containers are different than J2EE application servers like JRun, Geronimo, GlassFish, and JBoss (which use servlet containers like Tomcat and Jetty, but also have EJB containers and can handle other types of logic). If you have a J2EE application server running, you can easily use Solr, and if not, consider using Jetty or Tomcat as your container server.

Since your environment can be as varied as there are IT departments, I won't try to cover everything. Essentially you need to have at least the Java 1.5 JRE. However, I would <strong>strongly</strong> suggest the most current <a href="http://java.sun.com/">Java JDK (and not the JRE)</a> as it has performance enhancements to run in server mode (with -server). If you don't already have this Java version installed on your server (assuming this is the same server running CF), don't worry, ColdFusion will still work if you install the required Java runtime.

Essentially the process for deploying Solr, once you have a servlet container up-and-running is to drop the solr.war file into the webapps directory on the server. It won't do anything at this point as you need to set the configuration files for Solr. The easiest way to do this is copy the files from example/solr into a new directory (which I will refer to now as solr_home).

You can tell Java about the home directory by setting the solr.solr.home (-Dsolr.sol.home), set the JNDI lookup ("java:comp/env/solr/home"), or just throw it into the JVM's working directory (the default path is ./solr). Now you just need to make sure everything is running. Just point your browser to http://<server>:<port>/solr/admin. You should then see the administration interface (you may need to restart your servlet container to get everything working properly), but it's not an administrative interface like you get in CFAdmin. This is more of an informational administration panel. You can make sure everything is running, that there are documents in your index is set up properly, check out the schema and configuration files, and thread information. Really the only thing you can administer here is the log level.

For some more specific notes on intalling Solr in <a href="http://wiki.apache.org/solr/SolrTomcat">Tomcat</a> and <a href="http://wiki.apache.org/solr/SolrJetty">Jetty</a>, check out <a href="http://wiki.apache.org/solr/SolrInstall">Solr's wiki</a>. In particular, if you're going to need multiple instances of Solr to run, pay attention to the sections on Multipe Solr apps on those wiki pages.
