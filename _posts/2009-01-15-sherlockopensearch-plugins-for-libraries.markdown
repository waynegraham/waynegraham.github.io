---
layout: post
status: publish
published: true
title: Sherlock/OpenSearch Plugins for Libraries
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
excerpt: Back in the day, I used to work on the <a href="http://mycroft.mozdev.org/">Mycroft
  Project</a>. At the time, only Firefox/Netscape could actually used these plugins
  as they were based on Apple's Sherlock specification (Mycroft is Sherlock Holmes'
  brother, btw). These plugins have been a staple in the Firefox browser, but the
  Sherlock spec was a little arcane. More recently, both Firefox and IE have implemented
  support for the <a href="http://www.opensearch.org/Home">OpenSearch specification</a>.
  I have to say that the OpenSearchDescription is a significant update (at least from
  a readability standpoint) than Sherlock.
wordpress_id: 240
wordpress_url: http://www.liquidfoot.com/?p=240
date: 2009-01-15 12:34:12.000000000 -05:00
image:
  feature: abstract-3.jpg
  credit: dargadgetz
  creditlink: http://www.dargadgetz.com/ios-7-abstract-wallpaper-pack-for-iphone-5-and-ipod-touch-retina/

categories:
- Projects
- Computing
tags:
- opensearch
- firefox
- internet explorer
- library
comments: []
---
<p>Back in the day, I used to work on the <a href="http://mycroft.mozdev.org/">Mycroft Project</a>. At the time, only Firefox/Netscape could actually used these plugins as they were based on Apple's Sherlock specification (Mycroft is Sherlock Holmes' brother, btw). These plugins have been a staple in the Firefox browser, but the Sherlock spec was a little arcane. More recently, both Firefox and IE have implemented support for the <a href="http://www.opensearch.org/Home">OpenSearch specification</a>. I have to say that the OpenSearchDescription is a significant update (at least from a readability standpoint) than Sherlock.</p>

<p>A few years ago, I had written a bunch of Sherlock plugins for <a href="http://swem.wm.edu/resources/tools/">searching various library</a> catalogs. Those pretty much lay dormant until I was talking with my student worker this last semester and he got quite excited about these, and wondered if there might be a way to also search the databases the library subscribes to, and provide off-campus access to these through our proxy server. This code is in a very basic stage right now, but essentially what I did was create a database driven application in PHP that generates OpenSearch XML for various targets to search against.</p>

<p>Right now, this only supports HTTP GET requests (POST parameters require an additional table), but here's the DDL:</p>

{% highlight sql %}

CREATE TABLE `plugins` (
  `id` char(36) NOT NULL,
  `short_name` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL,
  `engine` varchar(25) NOT NULL,
  `image` varchar(25) NOT NULL,
  `input_encoding` varchar(10) NOT NULL,
  `url` varchar(550) NOT NULL,
  `method` varchar(4) NOT NULL default 'get',
  `proxy` tinyint(1) NOT NULL default '1',
  KEY `engine_index` (`engine`),
  KEY `short_name_index` (`short_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
{% endhighlight %}

<p>You don't need all of these fields for every record, and here is some useful records...</p>

{% highlight sql %}
INSERT INTO plugins (id, short_name, engine, input_encoding, method, proxy, url)
VALUES (UUID(), ' JStor', 'jstor', 'UTF-8', 'get', 1, 'http://www.jstor.org/action/doBasicSearch?Query=');

INSERT INTO plugins (id, short_name, engine, input_encoding, method, proxy, url)
VALUES (UUID(), 'Google Your University', 'google', 'UTF-8', 'get', 1, 'http://www.google.com/univ/wm?hl=en&amp;ie=ISO-8859-1&amp;btnG=Google+Search&amp;q=');

INSERT INTO plugins (id, short_name, engine, input_encoding, method, proxy, url)
VALUES (UUID(), 'Google Scholar', 'googlescholar', 'UTF-8', 'get', 1, 'http://scholar.google.com/scholar?&amp;hl=en&amp;lr=&amp;btnG=Search&amp;q=');

INSERT INTO plugins (id, short_name, engine, input_encoding, method, proxy, url)
VALUES (UUID(), 'Ebrary', 'ebrary', 'UTF-8', 'get', 1, 'http://site.ebrary.com/lib//Top?layout=search&amp;nosr=1&amp;sch=sch&amp;frm=smp.x&amp;p00=');

INSERT INTO plugins (id, short_name, engine, input_encoding, method, proxy, url)
VALUES (UUID(), 'EbscoHost', 'ebsco', 'UTF-8', 'get', 1, 'http://search.ebscohost.com/login.aspx?db=aph&amp;direct=true&amp;bQuery=');

INSERT INTO plugins (id, short_name, engine, input_encoding, method, proxy, url)
VALUES (UUID(), 'LexisNexis', 'lexisnexis', 'UTF-8', 'get', 1, 'http://www.lexisnexis.com/us/lnacademic/search/homesubmitForm.do');

INSERT INTO plugins (id, short_name, engine, input_encoding, method, proxy, url)
VALUES (UUID(), 'Proquest UMI', 'umi', 'UTF-8', 'get', 1, 'http://proquest.umi.com/pqdweb?RQT=305&amp;FT=1&amp;DBId=414&amp;SQ=');

INSERT INTO plugins (id, short_name, engine, input_encoding, method, proxy, url)
VALUES (UUID(), 'Science Direct', 'sciencedirect', 'UTF-8', 'get', 1, 'http://www.sciencedirect.com/science/quicksearch?query=');
{% endhighlight %}


<p>Apparently I wrote the queries with MDB2, I've since moved most of my interactions to Zend Db (you should be able to write that part pretty quickly) and just dump the names of the plugins in the tableon a view:</p>

{% highlight php %}

foreach($plugins as $plugin):

    echo('<li>' . $plugin['short_name'] . ': ');
       echo(' <a href="openSearch.php?id=' . $plugin['id'] . '"><img src="images/a9.png" title="OpenSearch" /></a>'); 

        if(strlen($plugin['url']) > 0){
            echo(' <a href="search.php?engine=' . $plugin['engine'] . '&amp;q=regulators">test search');
            echo(' | <a href="#" title="Ref: ' . $plugin['engine'] . '" onClick="addOpenSearch(\'' . $plugin['engine'] . '\', \'gif\', \'Education\', \'' . $plugin['id'] . '\'); return false;">add</a>');
        }

        echo('</li>);

');
endforeach;
{% endhighlight %}


<p>The add code is straight-forward</p>


{% highlight php %}
$result = $result[0];

$short_name = $result['short_name'];
$description = $result['description'];
$engine = $result['engine'];
$id = $result['id']; 

$xml = <<<EOT
<?xml version="1.0" encoding="UTF-8"?>
<OpenSearchDescription xmlns="http://a9.com/-/spec/opensearch/1.1/" 
    xmlns:moz="http://www.mozilla.org/2006/browser/search/">
  <ShortName>$short_name</ShortName>
  <Description>$description</Description>
  <Url type="text/html" method="get" template="http://<your_server>/plugins/proxy.php?engine=$engine&amp;q="/>
  <Contact>libsys@wm.edu</Contact>
  <Image width="16" height="16">http://<your_server>/favicon.ico</Image>
  <Developer>Wayne Graham</Developer>
  <InputEncoding>UTF-8</InputEncoding>
  <moz:SearchForm>http://<your_server>/plugins/search.php?engine=$engine</moz:SearchForm>
  <moz:UpdateUrl>http://<your_server>/plugins/opensearch.php?$id</moz:UpdateUrl>
  <moz:IconUpdateUrl>http://swem.wm.edu/favicon.ico</moz:IconUpdateUrl>
  <moz:UpdateInterval>7</moz:UpdateInterval>
</OpenSearchDescription>
EOT;
header("Content-Type: text/xml");
echo($xml);
{% endhighlight %}


You just need a little JavaScript to add this in to IE and Firefox:

{% highlight javascript %}
function addOpenSearch(name,ext,cat,pid,meth){
  if ((typeof window.external == "object") &#038;&#038; ((typeof window.external.AddSearchProvider == "unknown") || (typeof window.external.AddSearchProvider == "function"))) {
    // See bugs 430058/430067/430070 for Camino
    if (((typeof window.external.AddSearchProvider == "unknown") || (window.navigator.vendor == 'Camino'))&#038;&#038; meth == "p") {
      alert("This plugin uses POST which is not currently supported by your browser's implementation of OpenSearch.");
    } else {
      window.external.AddSearchProvider("http://<your_server>/plugins/install.php?id=" + pid);
    }
  } else {
    alert("You will need a browser which supports OpenSearch to install this plugin.");
  }
}
{% endhighlight %}


If I get some time soon, I'll wrap this up into a package; rudimentary, but a decent start to your own app!
