---
layout: post
status: publish
published: true
title: Real Life XSLT 2.0 transformations
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 208
wordpress_url: http://www.liquidfoot.com/?p=208
date: 2006-08-23 11:56:31.000000000 -04:00
categories:
- General
tags:
- xslt
- coldfusion
- XML
- Web
comments: []
image:
  feature: abstract-3.jpg
  credit: dargadgetz
  creditlink: http://www.dargadgetz.com/ios-7-abstract-wallpaper-pack-for-iphone-5-and-ipod-touch-retina/

---

I ran into a bit of a situation that was really blowing my mind. I have a rather large XML file (around 20,000+ lines) marked up in TEI that I wanted to do some transformations on (a day book and ledger from the 1850s). Essentially the code follows the format

~~~ xml
<figure>
  <head>Page 12</head>
  <graphic url="0023_p12"/>
</figure>
<fw type="header" place="top-center">
  <name type="place" key="7022220">Williamsburg</name>,
  <date value="1850">1850</date>,
</fw>
<table>
  <row>
    <cell>
      <date value="1850-10-03"><choice><abbr>Oct<hi rend="sup;underline">r</hi></abbr><expan>October</expan></choice> 3<hi rend="sup">th</hi> 1850</date>
    </cell>
    <cell>
      <name type="person" key="griffss01">Doct<hi rend="sup;underline">r</hi> S S Griffin</name>
    </cell>
    <cell><strong><em>&amp;</em></strong></cell>
  </row>
...
</table>
<pb/>
~~~

What I wanted to accomplish was group all this together in separate divs for HTML output (ok, I actually need to write each page to its own file, but this is pretty much just one more step).

I just could not find a way to group this info this way using XSLT 1 without wrapping each page within its own div structure. I didn't really want to go back and do this, so I asked the TEI-L list. David Sewell pinged me back with some XQuery code that recursively recalls the document structure for a given node.

He also mentioned that it would be pretty easy to write an XSLT 2 transformation that groups these nodes together. I did a little bit of digging and came up with

~~~xml
<xsl:template match="tei:div">
  <xsl:for-each-group select="*" group-ending-with"tei:pb">
    <div class="page">
      <xsl:apply-templates select="current-group()" />
    </div>
  </xsl:for-each-group>
</xsl:template></div>
~~~

This transformed the pages to what I was wanting


~~~html
<div class="page">
  <img src="0023_12.png" alt="Page 12" />
  <h1 class="fw">Williamsburg, 1850,</h1>
  <table>
    <tr>
      <td>
        <span class="abbr">Oct<sup><u>r</u></sup><span class="expan">October 3<sup>th</sup> 1850</date>
      </td>
      <td>
        <a href="javascript:getName('griffss01');>Doct<sup><u>r</u></sup> S S Griffin</a>
      </td>
      <td><strong><em>&amp;nbsp;</em></strong></td>
    </tr>
    ...
  </table>
</div>
<div class="page">
...
</div>
~~~

The XSLT processor for ColdFusion doesn't support XSLT 2.0 (it's still a draft spec). However, Saxon does (specifically Saxon 8). For more on doing XSLT transformations, see <a href="http://swem.wm.edu/blogs/waynegraham/index.cfm/2005/11/21/XSLT-20-in-ColdFusion">XSLT 2.0 in ColdFusion</a>.
