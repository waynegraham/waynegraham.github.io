---
layout: post
status: publish
published: true
title: MS Access via JDBC
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 198
wordpress_url: http://www.liquidfoot.com/?p=198
date: 2007-02-02 15:23:14.000000000 -05:00
categories:
- General
tags:
- coldfusion
- java
- Server
- Linux
comments:
- id: 220
  author: Adam Beaulne
  author_email: adam.beaulne@virtuo.ca
  author_url: ''
  date: '2009-03-17 06:28:11 -0400'
  date_gmt: '2009-03-17 13:28:11 -0400'
  content: "Hi, I just tried using your JDBC URL,a nd Driver Class, and i'm still
    having difficulty.\r\n\r\nIm using Coldfusion 8, on linux, and I cant see to make
    it work with a mdb,."
- id: 233
  author: Franklin
  author_email: fjgg.gonzales@gmail.com
  author_url: ''
  date: '2009-08-30 17:35:06 -0400'
  date_gmt: '2009-08-31 00:35:06 -0400'
  content: "Can you please add more info for accessing mdb using coldfusion 8 under
    linux (ubunutu9.04)\r\n\r\nThanks!"
- id: 280
  author: Guillaume
  author_email: gsimon@simnetsa.ch
  author_url: ''
  date: '2011-08-17 13:35:22 -0400'
  date_gmt: '2011-08-17 20:35:22 -0400'
  content: "Not working for me .. In Coldfusion datasources administration, the result
    of the test is \"OK\" but when i try to access to my datasource with coldfusion,
    i receive this error \"The result set type is not supported. \".\r\n\r\nI have
    try at same time to access with PHP functions odbc_connect and it's working. JDBC
    error ? What else ?"
- id: 281
  author: Wayne
  author_email: wayne@liquidfoot.com
  author_url: http://liquidfoot.com
  date: '2011-08-17 13:53:20 -0400'
  date_gmt: '2011-08-17 20:53:20 -0400'
  content: "Guillaume,\r\n\r\nI doubt very seriously this would work anymore (it's
    6 years old). I haven't done anything with ColdFusion in a couple of years, but
    what are you trying to do?"


---

We recently made the move from an IIS Windows web server to an Apache *nix based web server as part of our efforts to consolidate our library's server infrastructure. And for reasons I won't expound upon, we had one MS Access DSN that didn't get migrated to MSSQL and that needed to be used still. Since ColdFusion uses a Windows only driver for MS Access, I needed to figure out a way around this. I found a couple of JDBC drivers for Access (Easysoft's <a href="http://www.easysoft.com/products/data_access/jdbc_odbc_bridge/index.html">JDBC-ODBC Bridge</a> and HXTT's <a href="http://www.hxtt.com/access.html">Access Pure Java JDBC Drivers</a>), but these seemed to be a bit on the expensive side for the short amount of time that I'd need to keep Access in production.

I did notice on Easysoft's website that they were using the JdbcOdbc bridge, so after a little bit more digging, I found the syntax to use configure ColdFusion to use MS Access through the JdbcOdbc Bridge; the JDBC URL is

~~~
jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=/path/to/datasource.mdb;DriverID22;
~~~

and the Driver Class

~~~
sun.jdbc.odbc.JdbcOdbcDriver
~~~

For the very basic inserting of data from a seldom-used web form into a single table, this band aid fix has been doing pretty good!
