---
layout: post
status: publish
published: true
title: Add highlight link to current page in Rails
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 361
wordpress_url: http://www.liquidfoot.com/?p=361
date: 2010-09-28 11:55:22.000000000 -04:00
image:
  feature: abstract-3.jpg
  credit: dargadgetz
  creditlink: http://www.dargadgetz.com/ios-7-abstract-wallpaper-pack-for-iphone-5-and-ipod-touch-retina/

categories:
- Programming
tags:
- tips
- rails
- urlhelper
comments:
- id: 286
  author: Eduardo
  author_email: edgurgel@gmail.com
  author_url: ''
  date: '2012-08-07 11:40:59 -0400'
  date_gmt: '2012-08-07 18:40:59 -0400'
  content: Nice post :)
- id: 287
  author: am
  author_email: am@am.com
  author_url: ''
  date: '2012-08-12 04:45:45 -0400'
  date_gmt: '2012-08-12 11:45:45 -0400'
  content: "module PagesHelper\r\n  def is_active?(page_name)\r\n    \"selected\"
    if params[:action] == page_name\r\n  end\r\nend"
---
I recently wanted to add a highlight link to a navigational element if the navigation was on the current page. I thought this would be pretty straight forward with Rails' link_to helper. Turns out it was a little less-than-intuitive. So, to remind myself (and show others) how to do this, I'm providing the following:

{% highlight ruby %}
<ul>
    <li>
        <%= link_to_unless_current "Home", root_path do %>
          <%= link_to "Home", root_path, :class => "current" %>
        <% end %>
    </li>
</ul>
{% endhighlight %}

In my research, I saw different ways of going about this, but this apparently is the recommended method as it's in the documentation (see the <a href="http://api.rubyonrails.org/classes/ActionView/Helpers/UrlHelper.html#method-i-link_to_unless_current">URLHelper</a>).

I have to say this seems a bit counter-intuitive and not as "easy" as it should be. I kept expecting to be able to do something like:

{% highlight ruby %}
<%= link_to "Home" {home_path}, current_page? ? (:class => 'current') : nil %>
{% endhighlight %}

Anyway, if you want to add a highlight class, this works.

