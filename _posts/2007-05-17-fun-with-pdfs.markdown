---
layout: post
status: publish
published: true
title: Fun with PDFs
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 192
wordpress_url: http://www.liquidfoot.com/?p=192
date: 2007-05-17 17:12:25.000000000 -04:00
image:
  feature: abstract-3.jpg
  credit: dargadgetz
  creditlink: http://www.dargadgetz.com/ios-7-abstract-wallpaper-pack-for-iphone-5-and-ipod-touch-retina/

categories:
- Projects
tags:
- lucene
- pdf
- hacks
comments: []
---
<div class="body">

I've been working with a lot of PDF files lately for a few different projects (see <a href="http://swem.wm.edu/beta/flathat/">The FlatHat</a> and <a href="http://swem.wm.edu/beta/cards/">Card Catalog</a>). With our special collections cards, when you got a result back, Acrobat viewer would blow up the image to around 600%, making for a rather ugly image. For the FlatHat, I really wanted to be able to open a PDF and have the search terms highlighted, so I started hunting for ways to actually do this.

I've been using <a href="http://www.pdfbox.org/">PDFBox</a> to extract text from our PDFs to index with Lucene, so I started there and they clued me in to Adobe's <a href="http://partners.adobe.com/public/developer/en/acrobat/PDFOpenParameters.pdf">PDF Open Parameters</a>. This really killed a few birds with one stone.

When I was working on the Flat Hat newspaper, I was originally only returning back the page that the search result was on. I had some misgivings about this (like what if the story was on more than one page), but being able to pass the search query from the engine into the PDF is really nice since the user doesn't have to search through the entire issue to find the the context they are searching for (e.g. <a href="http://swem.wm.edu/beta/flathat/issues/fh19440301.pdf#search=%22whistle%20bait%22&amp;zoom=125">whistle bait</a> -- when I saw that term, I cracked up; definitely a different era).

Basically, the PDF Open Parameters allow you to pass commands into a PDF to allow you to control how the PDF is opened. They're passed with a "#" after the filename (e.g. filename.pdf#zoom=100). You can string commands together with an ampersand (&amp;) with a few caveats:
<ol>
	<li>only one digit after a decimal is retained</li>
	<li>parameters and their values can only be 32 total characters long</li>
	<li>you can't use reserved characters (=, #, and &amp;) to escape special characters</li>
	<li>if you turn bookmarks off for a PDF that had bookmarks showing, they won't go away until the PDF has been rendered</li>
</ol>
Anyway, here are some examples of what you can do:
<ul>
	<li><a href="http://swem.wm.edu/beta/flathat/issues/fh19391031.pdf#page=3">http://swem.wm.edu/beta/flathat/issues/fh19391031.pdf#page=3</a></li>
	<li><a href="http://swem.wm.edu/beta/flathat/issues/fh19391031.pdf#page=3&amp;zoom=150,250,100">http://swem.wm.edu/beta/flathat/issues/fh19391031.pdf#page=3&amp;zoom=150,250,100</a></li>
	<li><a href="http://swem.wm.edu/beta/flathat/issues/fh19391031.pdf#pagemode=thumbs">http://swem.wm.edu/beta/flathat/issues/fh19391031.pdf#pagemode=thumbs</a></li>
	<li><a href="http://swem.wm.edu/beta/flathat/issues/fh19391031.pdf#page=4&amp;view=fitH,100">http://swem.wm.edu/beta/flathat/issues/fh19391031.pdf#page=4&amp;view=fitH,100</a></li>
	<li><a href="http://swem.wm.edu/beta/flathat/issues/fh19391031.pdf#pagemode=none">http://swem.wm.edu/beta/flathat/issues/fh19391031.pdf#pagemode=none</a></li>
</ul>
</div>
