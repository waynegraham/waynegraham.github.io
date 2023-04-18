---
layout: post
status: publish
published: true
title: Library Search Google Gadget
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
excerpt: I’ve been going through a bunch of old stuff I’ve written as I clean up things.
  There will be a rash of posts where I take code I’ve written in different projects
  to see how things work and that are potentially useful, just no implemented in anything
  that I may need in the future. The first one here is some code for a Google gadget
  I wrote to search our online catalog a few years ago when the API was released.
wordpress_id: 223
wordpress_url: http://www.liquidfoot.com/?p=223
date: 2009-01-15 09:26:18.000000000 -05:00
image:
  feature: abstract-3.jpg
  credit: dargadgetz
  creditlink: http://www.dargadgetz.com/ios-7-abstract-wallpaper-pack-for-iphone-5-and-ipod-touch-retina/

categories:
- Projects
- Featured
tags:
- google
- igoogle
- code
comments: []
---
I've been going through a bunch of old stuff I've written as I clean up things. There will be a rash of posts where I take code I've written in different projects to see how things work and that are potentially useful, just no implemented in anything that I may need in the future. The first one here is some code for a Google gadget I wrote to search our online catalog a few years ago when the API was released.

If you're not one of the of the cool kids who uses <a href="http://www.google.com/ig">iGoogle</a>, you'll need to set yourself up to use this code. I just looked at the <a href="http://code.google.com/apis/gadgets/docs/dev_guide.html">developer's guide</a>, and it seems a bit more fleshed out than it was when I first took a whack at the code :) The really cool thing about these gadgets is that they are essentailly just an XML file with some JavaScript/HTML thrown in.

I thought it might be a nice feature to just provide a search box for people to launch a catalog search. This is just a simple HTML form.


~~~html
<form target=”_parent” name=”searchform” action=”http://lion.wm.edu/uhtbin/cgisirsi/0/0/057/5” id=”searchform”> 
  <input id=”searchInput” style=”width: 100%;” name=”searchdata1” type=”text” accesskey=”f” /> 
  <input id=”library” name=”library” type=”hidden” value=”SWEM” /> 
  <input id=”user_id” name=”user_id” type=”hidden” value=”SWEPUB” /> 
  <input id=”sourceid” name=”sourceid” type=”hidden” value=”gadget” /> 
</form>
~~~

This is just HTML code that you would use on any search page. Nothing fancy. Now on to creating the gadget..

There are two parts to the XML code for the spec. The root node (Module) has two elements, ModulePrefs and Content. The ModulePrefs element is relatively straight-forward:

~~~xml
<ModulePrefs
  title="Swem Catalog Search"
  height="40"
  description="Search Swem's online catalog from iGoogle"
  author="Wayne Graham"
  author_email="dontspamme@gmail.com" screenshot=""
  author_location="Williamsburg, Virginia"
  title_url="http://swem.wm.edu"
  Require feature="analytics" />
~~~

The attributes of the ModulePrefs element (title, height, description, etc.) should be pretty self explanitory. I wanted to be able to track usage of the gadget, so I eneabled Google analytics for the widget by requiring the analytics feature. Now for the meat.

What I did was write a short CSS definition and some JavaScript to actually display a form in the Content element of the Module.


~~~xml



<Content type="html"><![CDATA[
<style>
    #subLibrary {
        font-family:arial, sans-serif;
        font-size:10px;
        color:#676767;
    }
    #link {
        font-family:Garamond, serif;
        font-size:32px;
        color:black;
        text-decoration:none;
    }
    #searchGoButton {
        font-weight:bold;
    }
</style>
<script>
function displaySearchBar (prefs) {
    var lang = prefs.getString("mylang");

    if (lang == "") {
        lang = prefs.getString(".lang");
    }

    var html =
        '<form target="_parent" name="searchform" action="http://lion.wm.edu/uhtbin/cgisirsi/0/0/0/57/5" id="searchform">' +
        '<table style="width:100%">' +
        '<tr>' +
        '<td style="padding-bottom:4px">' +
        '<a target="_parent" id="link" href="http://lion.wm.edu/uhtbin/webcat">Catalog</a>' +
        '<span style="vertical-align: sub;">Swem</span>' +
        '</td>' +
        '<td width=100%>' +
        '<input id="searchInput" style="width:100%" name="searchdata1" type="text" accesskey="f" value="" />' +
        '<input id="library" name="library" type="hidden" value="SWEM" />' +
        '<input id="user_id" name="user_id" type="hidden" value="SWEPUB" />' +
        '<input id="sourceid" name="sourceid" type="hidden" value="gadget" />' +
        '</td>' +
        '<td>' +
        '<input type="submit" name="go" id="searchGoButton" value="Search" />' +
        '</td>' +
        '<td>' +
        '&amp;amp;amp;nbsp;' +
        '</td>' +
        '</tr>' +
        '</table>'
        '<form>';
    document.write(html);
}

displaySearchBar(new _IG_Prefs(__MODULE_ID__));
_IG_Analytics("analytics-id", "/google-gadget");
</script>
]]>
</Content>
~~~

Once you're done, you can test everything with the directions on the <a href="http://code.google.com/apis/gadgets/docs/tools.html">Developer Tools page</a>. There are even really nice resources to tell you how to <a href="http://code.google.com/apis/gadgets/docs/tools.html#Host">host this on Google Code</a>.

As a finished product, this is what the gadget looks like in iGoogle:

<img class="alignnone size-medium wp-image-235" title="gadget" src="http://www.liquidfoot.com/wp-content/uploads/2009/01/gadget-300x46.png" alt="gadget" width="300" height="46" />

For the folks that use iGoogle as their home page, this can be valuable tool for them. Next up, I need to brush off my code for generating Sherlock/Opensearch extensions for Firefox and IE...
