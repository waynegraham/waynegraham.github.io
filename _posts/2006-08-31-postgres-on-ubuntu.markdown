---
layout: post
status: publish
published: true
title: Postgres on Ubuntu
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 206
wordpress_url: http://www.liquidfoot.com/?p=206
date: 2006-08-31 08:52:16.000000000 -04:00
categories:
- General
tags:
- Linux
- Databases
comments: []
---

I was setting my computer up for a database systems class I'm taking this semester. I got to the point of getting PostgreSQL 8.1, pgAdmin III, and the JDBC drivers installed, but I couldn't figure out how to connect to the darn thing. I knew it created the account postgres, but since I was installing through apt-get, there wasn't any point that I set the password.

I finally broke down and started reading the documentation (which is excellent by the way), but all of the documents about the initial configuration were on compiling from the sources. I finally got tired of clicking "Next" in the docbook files and stumbled across a post at <a href="http://hocuspok.us/journal/postgresql-on-ubuntu-linux-how-to-updated">hocuspok.us</a>.

The step I was missing (and I'm sure I would have eventually found) was running:

~~~bash
$ sudo su postgres -c psql template1
template1=# ALTER USER postgres WITH PASSWORD '$password$';
template1=# \q
~~~

Even after just playing with this for a couple of hours, I'm seriosly thinking of changing my development DB from MySQL to PostgreSQL. Pretty impressive!
