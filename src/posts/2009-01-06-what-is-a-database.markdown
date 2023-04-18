---
layout: post
status: publish
published: true
title: What Is a Database?
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 146
wordpress_url: http://www.liquidfoot.com/?p=146
date: 2009-01-06 13:13:01.000000000 -05:00
image:
  feature: abstract-3.jpg
  credit: dargadgetz
  creditlink: http://www.dargadgetz.com/ios-7-abstract-wallpaper-pack-for-iphone-5-and-ipod-touch-retina/

categories:
- General
tags: []
comments: []
---
After working on a couple of different projects over the years that lent themselves to using a database, it seems a lot of people have some misconceptions of what exactly a database is...or what it does. Many have confused data stores and databases (when they really mean a database management system -- but not necessarily in a relational model flavor). When they want to build a database, I've found many using the wrong tools (e.g. spreadsheets) and find themselves heading down a road full of headaches that can be time consuming to deal with.

Most of the people I've worked with have a basic understanding of the fact that a database is a store of information. While Excel (and other spreadsheet programs) can do really useful things like crunch numbers and even filter information and do basic lookups (like a database system), there are a few other things they can't do that makes this perhaps not the best way to proceed in a project that needs to collect a lot of information. I'll start this as a first installment on using database management systems for research.

If you can believe it, database systems still adhere to the 13 rules outlined in E. F. Codd's paper "<a href="http://dx.doi.org/10.1145%2F362384.362685"><em>A Relational Model of Data for Large Shared Data Banks</em></a>" written in 1969 while Codd was at IBM (and republished in 1970 in <a href="http://dx.doi.org/10.1145%2F362384.362685">Communications of the ACM</a>). These rules are commonly referred to as Codd's 12 rules (numbered 0 - 12). So, here are the rules (I'll explain them in a bit more detail later).
<ul>
	<li>Rule 0: The system must qualify as relational, as a database, and as a management system.</li>
	<li>Rule 1: All information in the database is to be represented in one and only one way, namely by values in column positions within rows of tables.</li>
	<li>Rule 2: All data must be accessible with no ambiguity.</li>
	<li>Rule 3: The database management system must allow each field to remain null (or empty). Specifically, it must support a representation of "missing information and inapplicable information" that is systematic, distinct from all regular values, and independent of data type.</li>
	<li>Rule 4: The system must support an online, inline, relational catalog that is accessible to authorized users by means of their regular query language.</li>
	<li>Rule 5: The system must support at least one relational language that
<ol>
	<li>Has a linear syntax</li>
	<li>Can be used both interactively and without application programs</li>
	<li>Supports data definition operations (including view definitions), data manipulation operations (update and retrieve), security and data integrity constraints, and transaction management operations.</li>
</ol>
</li>
	<li>Rule 6: All views that are theoretically updateable must be updateable by the system.</li>
	<li>Rule 7: The system must support set-at-a-time insert, update, and delete operators.</li>
	<li>Rule 8: Changes to how the data is stored (its physical level) must not require a change to an application based on the structure.</li>
	<li>Rule 9: Changes to the logical level (tables, columns, rows, etc) must not require a change to an application based on the structure.</li>
	<li>Rule 10: Integrity constraints must be specified separately from application programs and stored in the catalog.</li>
	<li>Rule 11: The distribution of portions of the database to various locations should be invisible to users of the database.</li>
	<li>Rule 12: If the system provides a low-level (record-at-a-time) interface, then that interface cannot be used to subvert the system.</li>
</ul>
There are a bunch of different database managers out there. Most likely you even have at least one already on your computer (Firefox uses <a title="SQLite" href="http://www.sqlite.org/">SQLite</a>). Depending on what you need to do, and how much money you're willing to invest, and the scope of your project, there are an amazing array of products of there. This is a brief list of some of the most popular:
<ul>
	<li><a href="http://www.mysql.com/">MySQL</a> (free): Very popular with web developers; was initially developed for speed over features, but has become very feature rich, though it does require programming to develop an interface</li>
	<li><a href="http://www.postgresql.org/">PostgreSQL</a> (free): Feature-rich database system great for large-scale projects that will handle millions of connections easily; usually overkill for small projects</li>
	<li><a href="http://db.apache.org/derby/">Apache Derby</a>/<a href="http://developers.sun.com/javadb/">Java DB</a> (free): Pure Java relational database management system;</li>
	<li><a href="http://office.microsoft.com/en-us/access/default.aspx">Microsoft Access</a>: In a lot of corporate Office deployments; not good for projects with multiple users though</li>
	<li><a href="http://dba.openoffice.org/">OpenOffice Base</a> (free): Comes bundled with <a href="http://hsqldb.org/">HSQLDB</a>, but also allows you to use MySQL and PostgreSQL.</li>
	<li><a href="http://couchdb.apache.org/">CouchDB</a> (free): Kind of different than the rest in that it is a document-oriented database; it doesn't contain a specific schema, but allows you to create ad-hoc, distributed, RESTful access to information. It's not a relational database management system, but does provide some extra flexability to add "stuff" to a data store quickly.</li>
</ul>
Next up, designing tables so you can get stuff back out easily...
