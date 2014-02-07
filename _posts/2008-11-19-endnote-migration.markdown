---
layout: post
status: publish
published: true
title: EndNote Migration
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 121
wordpress_url: http://www.liquidfoot.com/?p=121
date: 2008-11-19 13:03:24.000000000 -05:00
image:
  feature: abstract-3.jpg
  credit: dargadgetz
  creditlink: http://www.dargadgetz.com/ios-7-abstract-wallpaper-pack-for-iphone-5-and-ipod-touch-retina/

categories:
- General
- Programming
- Projects
tags: []
comments: []
---
I've been working with the folks over at the <a href="http://web.wm.edu/wmcar/">Center for Archaeological Research</a> with a bibliography of their research reports. It's a bit of an offshoot of the NEH Slave Quarters research I've been working on, but I wanted to have a way to work through their research reports, just to have an idea of what they have available.

The first thing I did is get them to give me the file in the crappy EndNote XML format. I was having issues bringing it into Zotero, so I installed the bibutils package (sudo apt-get install bibutils) and then ran the endx2xml program on it. This created a nice MODS file for me to start crunching on. What I wanted to do is make a tag cloud using some of the categories they created. I created a database with two tables to store the citation and author information. I'm on my development box, so this is MySQL


~~~sql
--
-- Create schema archaeology
--

CREATE DATABASE IF NOT EXISTS archaeology;
USE archaeology;

--
-- Definition of table `archaeology`.`authors`
--

DROP TABLE IF EXISTS `archaeology`.`authors`;
CREATE TABLE&nbsp; `archaeology`.`authors` (
`id` char(36) NOT NULL,
`citation_id` char(36) NOT NULL,
`given` varchar(50) NOT NULL,
`family` varchar(50) NOT NULL,
`role` varchar(50) NOT NULL,
PRIMARY KEY&nbsp; (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Definition of table `archaeology`.`citations`
--

DROP TABLE IF EXISTS `archaeology`.`citations`;
CREATE TABLE&nbsp; `archaeology`.`citations` (
`id` char(36) NOT NULL,
`ref_id` varchar(25) NOT NULL,
`title` varchar(500) NOT NULL,
`year` int(11) NOT NULL,
`publisher` varchar(500) NOT NULL,
`added` timestamp NOT NULL default CURRENT_TIMESTAMP,
`genre` varchar(50) NOT NULL,
`subject` varchar(500) NOT NULL,
PRIMARY KEY&nbsp; (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
~~~

I next needed to write the XSLT to actually transform the modsCollection into the schema. I haven't worked with XSLT in a while and was (very) rusty :) Here's a sampling of the output of converting the EndNote XML to MODS

~~~xml
<?xml version="1.0" encoding="UTF-8"?>
  <modsCollection>
    <mods ID="Andre2007a">
    <titleInfo>
      <title>Heritage Education and Interpretive Plan for the Smith River Blueway and Pedestrian Trails, Henry County, Virginia</title>
    </titleInfo>
    <name type="personal">
      <namePart type="given">Elizabeth</namePart>
      <namePart type="family">Andre</namePart>
      <role>
        <roleTerm authority="marcrelator" type="text">author</roleTerm>
      </role>
    </name>
    <name type="personal">
      <namePart type="given">Stephanie</namePart>
      <namePart type="family">Sapp</namePart>
      <role>
        <roleTerm authority="marcrelator" type="text">author</roleTerm>
      </role>
    </name>
  <originInfo>
    <dateIssued>2007</dateIssued>
    <publisher>William and Mary Center for Archaeological Research, Williamsburg, Virginia. &amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp; Submitted to Virginia Department of Historic Resources, Roanoke</publisher>
  </originInfo>
  <typeOfResource>text</typeOfResource>
  <genre>report</genre>
  <subject>
    <topic>06-25/L-WMCAR Reports/Henry Co/Interp/18th/19th/20th/</topic>
  </subject>
  <identifier type="citekey">Andre2007a</identifier>
  </mods>
  <mods ID="Andre2007b">
    <titleInfo>
      <title>Architectural Evaluation of the Anderson Farm (047-0034-0010) for the Proposed Anderson-Hughes Development Project in Norge, Virginia</title>
    </titleInfo>
    <name type="personal">
    <namePart type="given">Elizabeth</namePart>
    <namePart type="given">M</namePart>
    <namePart type="family">Andre</namePart>
    <role>
      <roleTerm authority="marcrelator" type="text">author</roleTerm>
    </role>
    </name>
    <originInfo>
      <dateIssued>2007</dateIssued>
      <publisher>William and Mary Center for Archaeological Research, Williamsburg, Virginia. &amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp; Submitted to Anderson-Hughes, LLC, Newport News, Virginia</publisher>
    </originInfo>
    <typeOfResource>text</typeOfResource>
    <genre>report</genre>
    <subject>
      <topic>07-22/L-WMCAR Reports/ARCeval/19th/20th/James City Co/</topic>
    </subject>
    <identifier type="citekey">Andre2007b</identifier>
  </mods>
  <modsCollection>
~~~


What I wanted to do is take each citation and insert it into the database, then relate the last-entered citation with its authors. At first I thought I could use MySQL's last_insert_id() function...turns out those are only for auto-increment fields and I always use UUIDs for primary keys. What I ended up doing is adding in the added field with a timestamp (with a default value of CURRENT_TIMESTAMP). Then, I just went through the nodes and put the data where it needed to go.


~~~xml
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="text" />
<xsl:strip-space elements="*"/>

<xsl:template match="/">
  DELETE FROM citations;
  DELETE FROM authors;

  <xsl:for-each select="modsCollection/mods">
    INSERT INTO citations ( id, ref_id, title, year, publisher, genre, subject)
    VALUES (
    UUID(),
    '<xsl:value-of select="@ID" />',
    '<xsl:call-template name="escapesinglequotes">
      <xsl:with-param name="arg1">
        <xsl:value-of select="titleInfo/title"/>
      </xsl:with-param>
    </xsl:call-template>',
    '<xsl:value-of select="originInfo/dateIssued"/>',
    '<xsl:call-template name="escapesinglequotes">
        <xsl:with-param name="arg1">
    <xsl:value-of select="originInfo/publisher"/>
      </xsl:with-param>
    </xsl:call-template>',
    '<xsl:value-of select="genre"/>',
    '<xsl:call-template name="escapesinglequotes">
      <xsl:with-param name="arg1">
    <xsl:value-of select="subject/topic"/>
    </xsl:with-param>
    </xsl:call-template>'
    );

    <xsl:for-each select="name">
      INSERT INTO authors (id, citation_id, given, family, role)
      VALUES(
      UUID(),
      (SELECT id FROM citations ORDER BY added desc limit 1),
      <xsl:for-each select=".">
      '<xsl:value-of select="namePart[@type='given']"/> ',
      '<xsl:value-of select="namePart[@type='family']"/>',
      '<xsl:value-of select="role/roleTerm"/>'
    </xsl:for-each>each
    );
    </xsl:for-each>
    </xsl:for-each>
    </xsl:template>
    <xsl:template name="escapesinglequotes">
    <xsl:param name="arg1" />
    <xsl:variable name="apostrophe">'</xsl:variable>
    <xsl:choose>
    <xsl:when test="contains($arg1, $apostrophe)">
    <xsl:if test="string-length(normalize-space(substring-before($arg1, $apostrophe))) > 0"><xsl:value-of select="substring-before($arg1, $apostrophe)" disable-output-escaping="yes"/>''</xsl:if>
    <xsl:call-template name="escapesinglequotes">
    <xsl:with-param name="arg1"><xsl:value-of select="substring-after($arg1, $apostrophe)" disable-output-escaping="yes"/></xsl:with-param>
    </xsl:call-template>
    </xsl:when>
    <!-- No quotes found in string, just print it -->
    <xsl:when test="string-length(normalize-space($arg1)) > 0"><xsl:value-of select="normalize-space($arg1)"/></xsl:when>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
~~~

I noticed that I also had to write a template to escape single quotes in the title, publisher, and topic because of some possesive language in those fields. It took the longest time to actually write the code for that (like I said, I was really rusty and forgot all about XSL branching).

In the end, what gets generated is a nice SQL script (this one pushes 30,000 lines) like this


~~~sql
DELETE FROM citations;
DELETE FROM authors;

INSERT INTO citations ( id, ref_id, title, year, publisher, genre, subject)
VALUES (
  UUID(),
  'Andre2007a',
  'Heritage Education and Interpretive Plan for the Smith River Blueway and Pedestrian Trails, Henry County, Virginia',
  '2007',
  'William and Mary Center for Archaeological Research, Williamsburg, Virginia. Submitted to Virginia Department of Historic Resources, Roanoke',
  'report',
  '06-25/L-WMCAR Reports/Henry Co/Interp/18th/19th/20th/'
);

INSERT INTO authors (id, citation_id, given, family, role)
VALUES(
UUID(),
(SELECT id FROM citations ORDER BY added desc limit 1),
  'Elizabeth ',
  'Andre',
  'author'
);

INSERT INTO authors (id, citation_id, given, family, role)
VALUES(
UUID(),
(SELECT id FROM citations ORDER BY added desc limit 1),
  'Stephanie ',
  'Sapp',
  'author'
);

INSERT INTO citations ( id, ref_id, title, year, publisher, genre, subject)
VALUES (
UUID(),
  'Andre2007b',
  'Architectural Evaluation of the Anderson Farm (047-0034-0010) for the Proposed Anderson-Hughes Development Project in Norge, Virginia',
  '2007',
  'William and Mary Center for Archaeological Research, Williamsburg, Virginia. Submitted to Anderson-Hughes, LLC, Newport News, Virginia',
  'report',
  '07-22/L-WMCAR Reports/ARCeval/19th/20th/James City Co/'
);

INSERT INTO authors (id, citation_id, given, family, role)
VALUES(
UUID(),
(SELECT id FROM citations ORDER BY added desc limit 1),
  'Elizabeth ',
  'Andre',
  'author'
);
~~~

There's still a lot of cleaning up to do (normalizing the authors table, exploding the subjects, generating the tags), but it did give me pause to remember how beautifully maddening XSLT can be.

I'll post some screenshots when this gets a bit further along, but I thought this may save someone some time at some point.
