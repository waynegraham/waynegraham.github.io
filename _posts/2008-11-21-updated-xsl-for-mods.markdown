---
layout: post
status: publish
published: true
title: Updated XSL for MODS
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 141
wordpress_url: http://www.liquidfoot.com/?p=141
date: 2008-11-21 13:57:09.000000000 -05:00
image:
  feature: abstract-3.jpg
  credit: dargadgetz
  creditlink: http://www.dargadgetz.com/ios-7-abstract-wallpaper-pack-for-iphone-5-and-ipod-touch-retina/

categories:
- Projects
tags:
- xslt
- sql
comments: []
---
David noticed that not all the authors were being inserted into the database. I looked at it and it turns out that an author can have an arbitrary number of given names to handle the inclusion of middle names. I had thought I was only pulling the first node, but it turns out I wasn't and the SQL to insert the authors with was erroring out so there were a lot of citations without authors.

I went back in and modified the XSLT that was processing the given names to now read:

~~~xml

<xsl:variable name="ref_id">
    <xsl:value-of select="@ID" />
</xsl:variable>
...
<xsl:for-each select="name">
  INSERT INTO authors (id, ref_id, given, family, role)
  VALUES(
      UUID(),
      <!--(SELECT id FROM citations ORDER BY added desc limit 1),-->
      '<xsl:value-of select="$ref_id"/>',
      <xsl:for-each select=".">
          '<xsl:for-each select="namePart[@type='given']">
              <xsl:value-of select="."/>
              <xsl:text> </xsl:text>
          </xsl:for-each>',
  
          '<xsl:value-of select="namePart[@type='family']"/>',
          '<xsl:value-of select="role/roleTerm"/>'
      </xsl:for-each>
      );
</xsl:for-each>

~~~

It looked like the SQL to grab the last item didn't always return a record for whatever reason (a locking issue?). Since there was already a key in the field, I just switched over to use that in the inserts. Still need to go through and regularize the fields so MySQL isn't attempting to pull a foreign key index on a variable width field, but this is an update to yesterday's code.
