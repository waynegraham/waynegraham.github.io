---
layout: post
status: publish
published: true
title: Solr Schema
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 178
wordpress_url: http://www.liquidfoot.com/?p=178
date: 2007-10-05 13:27:02.000000000 -04:00
categories:
- Programming
- Projects
tags:
- solr
- coldfusion
- Apache
- XML
comments: []
---
If you've ever worked on a project that involved Coldfusion's bundled version of Verity, you've no doubt run into the issue of trying to confine your fields into the structure that Verity imposes, and those custom fields are really precious in these instances. About 6 months ago, I ran into an issue with a search project where I had about 125,000 documents to index. Since we also wanted to be able to use the indexes for some other projects, I was a bit nervous to commit almost the entire allotment of indexable objects to one collection. This launched me into writing a custom search engine and indexer using Lucene and slapping Coldfusion around the responses to do things that Verity did. However, once the projects were complete, I never really got around to making it easy to use. It does cool stuff like search across multiple collections, context highlighting, relevancy calculations, term vector calculations, "did you mean", etc. Essentially everything I think all good search engines need to be able to do. Something this system lacked was an easy way to define the fields that you wanted indexed (along with a knowledge of Java to actually make the changes).

The ability to create any number of fields to index in different ways (along with faceting) is a real strong point of Solr. Not only can you add fields and choose how that data is analyzed, you can create your own field types that process the information in your index the way you want them to be.

This is done in the <code>$SOLR_HOME/config/schema.xml</code> file. The first section (<types>) defines the types of fields that you will be using, and how Solr should process them with Lucene. If you look at some of the fieldtypes, you'll get an idea of what's possible. For instance, the fieldtype for "string" is an untokenized field that doesn't normalize the fields and sorts missing information last.

~~~xml
<fieldtype name="string" class="solr.StrField" sortMissingLast="true" omitNorms="true"/>

~~~

However, if you need a more robust fieldtype, look at the fieldtype for "text". This uses a whitespace tokenizer (splits words with whitespace) and uses the stopwords defined in the stopwords.txt file. It does some other processing (filters words, converts them to lowercase, runs a porter stemmer, and then removes duplicates). This fieldtype also defines what to do when a query is passed to it (uses the same filters). This is slightly different than the defined "textTight" which does not perform any further analysis on the text when being queried. You'll probably find that most of these work for most instances, but if you need to, you can build your own fieldtype that has very specific indexing and query filters.

The next section contains the actual fields you want to use in the aptly named "fields" element. This is where you actually define the fields that will be in your index, the type of analysis to perform on the field, if it should be indexed, stored, have term vectors, or be multivalued (have multiple instances of the same field in the index).

Let's say you're wanting to develop an indexing schema for books (hey, I work in a library). At a very basic level, you'd want a field for an id, title, author, reviews, and a set of topics (or tags). Your fields element would contain something along the lines of:

~~~xml
<field name=“id” type=“string” indexed=“true” stored=“true”/> 
<field name=“title” type=“text” indexed=“true” stored=“true” termVectors=“true” /> 
<field name=“titleStr” type=“string” indexed=“true” stored=“false” multiValued=“true”/> 
<field name=“author” type=“text” indexed=“true” stored=“true”termVectors=“true” /> 
<field name=“authorStr” type=“string” indexed=“true” stored=“false” multiValued=“true”/> 
<field name=“review” type=“text” indexed=“true” stored=“true” multiValued=“true”/> 
<field name=“topic” type=“text” indexed=“true” stored=“true” multiValued=“true” termVectors=“true”/> 
<field name=“topicStr” type=“string” indexed=“true” stored=“false” multiValued=“true”/>
~~~

You'll notice that I have a couple of extra fields for title, author, and topic, these are for the faceting info and are just untokenized fields to make the calculations for facets a little more efficient.

Now, we're almost done with creating the schema. We just need to declare a unique key, default search field, and default search operator.

~~~xml
<uniqueKey>id</uniqueKey>
<defaultSearchField>title</defaultSearchField>
<solrQueryParser defaultOperator="OR"/>
~~~

Remember when I made the fields with the "Str" suffix? We can use a really cool feature of Solr called a "copyField" that literally copies the information from one field to another.

~~~xml
<copyField source=“author” dest=“authorStr”/>
<copyField source=“title” dest=“titleStr”/>
<copyField source=“topic” dest=“topicStr”/>
~~~

It's worth mentioning here that Solr indexes are not databases! While there are some similarities in the way that Solr allows you to add, update, select, store, and delete information from the index, Solr isn't an RDBMS. I've seen a few discussions where there is some confusion as to why Solr can't do the equivalent of a stored procedure, or some other function of a database.

Now, your index server is ready to receive documents to search against. The server, in with the above example as the schema, will expect information to be in the following format:

~~~xml
<field name="id">1</field>
<field name="title">Solr Rocks!</field>
<field name="author">Barr, Foo</field>
<field name="review">This book rocks!</field>
<field name="review">This book is horrible!</field>
<field name="topic">information retrieval systems</field>
<field name="topic">xml <field name="topic">search</field>
<field name="topic">apache foundation</field>
~~~

Next week when I get some time, I'll write about creating facet queries...
