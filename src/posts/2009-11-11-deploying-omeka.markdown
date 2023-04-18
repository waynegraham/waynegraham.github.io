---
layout: post
status: publish
published: true
title: Deploying Omeka
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
excerpt: At work, we've been doing a lot of development using the Omeka framework.
  We've implemented plugins to enable the software to interact with our Fedora repository,
  work with geo-rectified images, build in a search interface with Solr, and another
  one (Adam's not quite ready to announce this one yet). However, as good as the project
  is, one thing I've noticed is that the ways to deploy the software are a bit heavy
  on the user knowing what they're doing. They've done a good job of guiding users
  through the setup after all the pieces are in place, but I'm a big fan of having
  automated ways of deploying software.
wordpress_id: 359
wordpress_url: http://www.liquidfoot.com/library_item/liquidfoot//deploying-omeka/
date: 2009-11-11 17:10:40.000000000 -05:00
categories: []
tags: []
comments: []
image:
  feature: abstract-3.jpg
  credit: dargadgetz
  creditlink: http://www.dargadgetz.com/ios-7-abstract-wallpaper-pack-for-iphone-5-and-ipod-touch-retina/

---
At work, we've been doing a lot of development using the Omeka framework. We've implemented plugins to enable the software to interact with our Fedora repository, work with geo-rectified images, build in a search interface with Solr, and another one (Adam's not quite ready to announce this one yet). However, as good as the project is, one thing I've noticed is that the ways to deploy the software are a bit heavy on the user knowing what they're doing. They've done a good job of guiding users through the setup after all the pieces are in place, but I'm a big fan of having automated ways of deploying software.

One of my favorite deployment tools is Capistrano. I love being able to check changes to the software to our Subversion server, and from my local machine type a simple command and update the remote source. We actually have been using this for several of our instances on our staging servers. The secret for deploying a PHP project with Capistrano is with <a href="http://github.com/leehambley/railsless-deploy">Lee Hambley's railsless-deploy gem</a>. The first time you set one of these up, it's a real pain, but you can quickly develop a template for deploying these.

I've been paying attention to some of the musings on Twitter regarding setting Omeka up. One of the big stumbling blocks is with MySQL. I wrote a quick helper script, and in one of my "how can I make this more beneficial" moments, I wrote a spec file for generating an rpm to install it.

I hadn't worked on packaging in Linux for a while and forgot how painful it could be. Compounding my efforts was the fact that I was running Fedora Core to build it from VirtualBox. Normally this runs fine, but the fact that I was using rpmbuild was causing VirtualBox to eat up most of my available memory (I only have 4GB). It was just slow going because the rpmlint was taking so long.

Anyway, I have a functional rpm that can how be installed. I haven't tested it much (read that at all), but I believe I've worked the bugs out of the build process. The idea here is to deploy it in a slightly different manner than you get out of the box. The RPM version creates /etc/omeka where it stores its database configuration and then defaults to placing the directory tree in /var/www/omeka. This helps in separating the configuration from the actual web application, but I'm debating with myself if everything but the archive folder should go into /usr/local/omeka.

Anyway, we'll have an update soon, along with more code!
