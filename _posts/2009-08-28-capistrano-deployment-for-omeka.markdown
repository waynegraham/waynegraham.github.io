---
layout: post
status: publish
published: true
title: Capistrano Deployment for Omeka
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 360
wordpress_url: http://www.liquidfoot.com/library_item/liquidfoot//capistrano-deployment-for-omeka/
date: 2009-08-28 08:44:09.000000000 -04:00
categories: [development]
tags: [ruby, capistrano]
comments: []
image:
  feature: abstract-3.jpg
  credit: dargadgetz
  creditlink: http://www.dargadgetz.com/ios-7-abstract-wallpaper-pack-for-iphone-5-and-ipod-touch-retina/

---

We're currently starting a project at the Scholars' Lab in which we're going to use <a href="http://www.omeka.org">Omeka</a>. We're a Rails shop and use <a href="http://www.capify.org/index.php/Capistrano">Capistrano</a> to deploy projects to our staging and production servers all the time. Since I had read that Capistrano didn't need to be for Rails, I thought it would help out in deploying the PHP for our Omeka work.

It took a little work, but I finally stumbled across Lee Hambley's <a href="http://github.com/leehambley/railsless-deploy/tree/master">railsless-deploy</a> project over on Github.

The install is pretty easy (assuming you have rubygems installed).

{% highlight bash %}
$ gem sources -a http://gems.github.com/ # make sure you have github sources installed
$ gem install leehambley-railsless-deploy
{% endhighlight %}


After this, for rails apps, you just capify the project, but this command didn't seem to work, so I just manually added the Capfile in the root of the project directory with the snip provided on the project page:

{% highlight ruby %}
load 'deploy' if respond_to?(:namespace) # cap2 differentiator
# Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }

require 'rubygems'
require 'railsless-deploy'
load    'config/deploy'
{% endhighlight %}


After that, it was just a matter of using the recipes we typically use. Now, after we get the plugins we're developing ready to be deployed, all we have to do is

{% highlight bash %}
$ cap deploy
{% endhighlight %}


Capistrano makes life so much easier!
