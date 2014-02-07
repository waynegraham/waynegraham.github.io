---
layout: post
status: publish
published: true
title: Openlayers and Mobile Devices
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 326
wordpress_url: http://www.liquidfoot.com/?p=326
date: 2009-11-25 08:03:09.000000000 -05:00
categories:
- Programming
- Projects
- Computing
- gis
tags:
- openlayers
- mobile
- gis
comments:
- id: 276
  author: Jaimin
  author_email: addonblackberry2010@gmail.com
  author_url: ''
  date: '2011-08-12 05:01:29 -0400'
  date_gmt: '2011-08-12 12:01:29 -0400'
  content: Do you have any sample code .html page &amp; javascript &amp; css file
    for using the mobile working OpenLayers for iphone.
- id: 277
  author: Wayne
  author_email: wayne@liquidfoot.com
  author_url: http://liquidfoot.com
  date: '2011-08-12 05:08:37 -0400'
  date_gmt: '2011-08-12 12:08:37 -0400'
  content: "Jaimin,\n\nHere's an older version of something I worked up before the
    mobile stuff started being integrated in to OpenLayers. \n\nhttp://multitouchmap.heroku.com/index.html\n\nNow
    there are better ways to do this; see:\n\nhttp://openlayers.org/dev/examples/mobile.html"
- id: 278
  author: Jaimin
  author_email: addonblackberry2010@gmail.com
  author_url: ''
  date: '2011-08-12 05:25:19 -0400'
  date_gmt: '2011-08-12 12:25:19 -0400'
  content: "Wayne,\r\n\r\nThanks for reply\r\nok thanx but as i said i need sample
    code means the source code for this functionality because i am going to create
    an application for iphone which include OpenLayers so i have to do that all things
    programmatically. so can you please provide me the index.html page source code
    with its JavaScripts and StyleSheet CSS Files. \r\nor please provide me proper
    guidance."
- id: 279
  author: Jaimin
  author_email: addonblackberry2010@gmail.com
  author_url: ''
  date: '2011-08-12 05:59:03 -0400'
  date_gmt: '2011-08-12 12:59:03 -0400'
  content: "I have implemented OpenLayer Map but it has only move events as you have
    mentioned above in your code. \r\n\"function touchHandler(event)\"\r\nbut i want
    to zoom with that step as iphone zoom facility because this application is in
    iphone and user should not know that the map is comes from other functionality
    (OpenLayer) so please give guidance for zoom functionality."
---
After some really good conversations last week at the Institute on Enabling Geospatial Scholarship about mobile devices and mapping as an interpretive device, I mocked up a quick page to see how <a href="http://openlayers.org/">OpenLayers</a> looked on the Safari mobile browser. The theory to test out here was that you could pretty easily pull up your current location and plot your (approximate) location on a historic map (or any map for that matter) without having to install an application (like <a href="http://emergencestudios.com/historicearth/">Old Map App</a>). There are various hurdles in higher education to actually releasing software application through vendors like Apple's App Store (restrictions on individual employees entering into contractual agreements), so we thought we'd explore using the browser to provide some of this functionality to users.

We have a few historic maps from our McGregor collection available through our <a href="http://geoserver.org">Geoserver</a> installation, so I looked up their layer ids and manually added them into a page with OpenLayers. Nothing fancy here, just a test to see what it looks like.

{% highlight javascript %}

var lat, long layer;
var zoom = 10;

var lat, lon, layer;
 var zoom = 10;

 map = new OpenLayers.Map('map');
 map.addControl(new OpenLayers.Control.LayerSwitcher());

 layer1 = new OpenLayers.Layer.WMS("Map of the Southern States",
 "http://lat.lib.virginia.edu:8080/geoserver/gwc/service/wms",
 {layers: "McGregor:000003056_00011"}
 );
 layer2 = new OpenLayers.Layer.WMS("Nova Virginae tabula",
 "http://lat.lib.virginia.edu:8080/geoserver/gwc/service/wms",
 {layers: "McGregor:000003482_00011"}
 );
 layer3 = new OpenLayers.Layer.WMS("A map of the most inhabited part of Virginia",
 "http://lat.lib.virginia.edu:8080/geoserver/gwc/service/wms",
 {layers: "McGregor:000003012_st1"}
 );
 layer4 = new OpenLayers.Layer.WMS("Carte de la campagne en Virginie du Major General Mis. de la Fayette",
 "http://lat.lib.virginia.edu:8080/geoserver/gwc/service/wms",
 {layers: "McGregor:000003013_st1"}
 );
 layer5 = new OpenLayers.Layer.WMS("Carte de la campagne en Virginie du Major General Mis. de la Fayette",
 "http://lat.lib.virginia.edu:8080/geoserver/gwc/service/wms",
 {layers: "McGregor:000003019_00011"}
 );

 map.addLayer(layer1);
 map.addLayer(layer2);
 map.addLayer(layer3);
 map.addLayer(layer4);
 map.addLayer(layer5);

if(navigator.geolocation){
 navigator.geolocation.getCurrentPosition(function(position){
 lat = position.coords.latitude;
 lon = position.coords.longitude;
 map.setCenter(new OpenLayers.LonLat(lon, lat), zoom);

 var vectorLayer = new OpenLayers.Layer.Vector("Overlay");
 var feature = new OpenLayers.Feature.Vector(
 new OpenLayers.Geometry.Point(lon, lat),
 {some:'data'},
 {externalGraphic: 'http://geocoder.ca/marker.png', graphicHeight: 64, graphicWidth: 48});
 vectorLayer.addFeatures(feature);
 map.addLayer(vectorLayer);
 });
 }

map.addControl(new OpenLayers.Control.PanZoomBar());

{% endhighlight %}

This actually worked surprisingly well the first time I launched it. With Firefox 3.5 I tested it on my laptop. At first I wasn't using the <a href="http://geoserver.org/display/GEOSDOC/5.+GWC+-+GeoWebCache">geowebcache</a> we had set up, so it was a bit slow. I changed to the geowebcache WMS service and things in the browser were noticeably faster.

At lunch, I handed an iPhone to <a href="http://iconocla.st/">Schuyler Erle</a> who's first instinct was to try to drag things around and zoom-in and out. Well, there was a fail as the controls you normally use in OpenLayers were far too small to actually be useful and it just didn't feel right.

I then attempted to add in a touchHandler function to help with the interactions from the user. I found Ross Boucher's post "<a title="Permanent Link: iPhone Touch Events in JavaScript" rel="bookmark" href="http://rossboucher.com/2008/08/19/iphone-touch-events-in-javascript/">iPhone Touch Events in JavaScript</a>" and used his code to get the sliding working:

{% highlight javascript %}

function touchHandler(event)
{
   var touches = event.changedTouches,
   first = touches[0],
   type = "";

   switch(event.type)
   {
     case "touchstart": type = "mousedown"; break;
     case "touchmove":&nbsp; type="mousemove"; break;
     case "touchend":&nbsp;&nbsp; type="mouseup"; break;
     default: return;
 }

 // initMouseEvent(type, canBubble, cancelable, view, clickCount,
 // screenX, screenY, clientX, clientY, ctrlKey,
 // altKey, shiftKey, metaKey, button, relatedTarget);

    var simulatedEvent = document.createEvent("MouseEvent");
    simulatedEvent.initMouseEvent(type, true, true, window, 1,
    first.screenX, first.screenY,
    first.clientX, first.clientY, false,
    false, false, false, 0/*left*/, null);

    first.target.dispatchEvent(simulatedEvent);
    event.preventDefault();
 }

 document.addEventListener("touchstart", touchHandler, true);
 document.addEventListener("touchmove", touchHandler, true);
 document.addEventListener("touchend", touchHandler, true);
 document.addEventListener("touchcancel", touchHandler, true);

{% endhighlight %}


Now the scrolling worked, but you could no longer zoom into the map (and we want real zoom, not just making the image bigger). I haven't found a fix for this yet, but I have to say that this is a kind of cool way of interacting with these materials.

Something I need to talk with Joe about next week making your location a query to <a href="http://geonetwork-opensource.org/">Geonetwork</a> and then using the top n maps returned to build this interface. It's a little like a coverage map for your current location.

