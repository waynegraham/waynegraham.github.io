---
layout: post
status: publish
published: true
title: Starting Over
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 3
wordpress_url: http://liquidfoot.com/?p=3
date: 2008-07-17 04:52:58.000000000 -04:00
categories:
- Programming
- Projects
tags:
- solrmarc
- dspace
comments: []
---
I saw this on SmashingMagazine this morning and just had to have it! I haven't been posting to this blog much and figured this would be as good a time as any to pick things back up.&nbsp; While I was in there I upgraded from WP 2.4 to 2.6. Wow. Talk about a great improvement on the backend!

I learned a couple of interesting facts over the last couple of days. First, working on the <a href="http://www.vufind.org">Vufind</a> code (well, actually it was <a title="SolrMarc" href="http://code.google.com/p/facebook-athenaeumhttp://code.google.com/p/solrmarc">solrmarc</a>), Andrew and I were discussing the looping of subfields in marc records. It seemed to us that any field should only have a single subfield. So, say a 650 should only have one subfield a, b, c, etc. Much to our shagrin, we found out that specific fields can have repeating subfields. It never ceases to amaze me that what all is packed into this specification.

Also, the Dspace upgrade didn't go so well...in fact parts of the upgrade went well, but there's a big error I'm getting when we attempt to create the new indexes. No matter what, it errors out with a null pointer exception. I'm building a new machine to get this reconfigured. I'm just glad there aren't that many folks using that server right now!
