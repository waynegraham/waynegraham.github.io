---
layout: post
status: publish
published: true
title: More on Omeka Packaging
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 316
wordpress_url: http://www.liquidfoot.com/?p=316
date: 2009-11-20 08:42:11.000000000 -05:00
categories:
- Programming
- Projects
- Computing
tags:
- omeka
- fedora
- rpm
- howto
comments: []
image:
  feature: abstract-3.jpg
  credit: dargadgetz
  creditlink: http://www.dargadgetz.com/ios-7-abstract-wallpaper-pack-for-iphone-5-and-ipod-touch-retina/

---
I had meant to get this info out there a bit earlier, but we were sponsoring an <a href="http://www2.lib.virginia.edu/scholarslab/geospatial/">NEH Institute on Enabling Geospatial Scholarship</a>. That's a different post, but I did want to get back to Omeka and flush out building the RPM for Omeka.

What I'm going to do here is go through the setup for building the RPM and the spec file. This <em>should</em> work on just about any OS that uses RPM for installing software, but this isn't tested very extensively.

So I guess the first thing to cover is what exactly an RPM is. RPM is the Redhat Package Manager and is an implementation of a container for other files. It allows you to quickly install software, including necessary programs to run the program, provides information about the program you are installing, informs users about potential conflicts between your program and the software currently installed on the system, and provides a path to install, upgrade, and remove the software.

Now, in the case of Omeka, you don't really need a package manager if you're a seasoned system administrator. However, if you're wanting to run this yourself, and you have to convince others to manage the software for you (e.g. you're running it at an institution), have an RPM that your systems administrator installs will save a lot of headaches, especially since upgrades to the software can be integrated into scheduled maintenance with kernel and other software upgrades.

Building RPMs requires two things, the source you want to install and a specification (spec) file that tells the software what to do. You'll need to first set your system up to have the tools to build software which you can do with a couple of lines (as the root user):

{% highlight bash %}
yum groupinstall "Development Tools"
yum install rpmdevtools
{% endhighlight %}

Next we need the directory hierarchy for building the RPMs. You can do this manually, but there's a handy tool for helping out called rpmdev-setuptree. In the terminal, if you run this command, it will create a new folder in your home directory named "rpmbuild" with the correct directories made for you.

{% highlight bash %}
rpmdev-setuptree
{% endhighlight %}

If you want these in a different location, say omeka_rpm, you can manually create the following hierarchy:

{% highlight bash %}
mkdir -p ~/omeka_rpm/BUILD
mkdir -p ~/omeka_rpm/BUILDROOT
mkdir -p ~/omeka_rpm/RPMS
mkdir -p ~/omeka_rpm/SOURCES
mkdir -p ~/omeka_rpm/SPECS
mkdir -p ~/omeka_rpm/SRPMS
{% endhighlight %}

For our purposes, we're really going to be dealing in the SOURCES and SPEC directories. Let's start with the setup for the source files. First you need to get the source files from <a href="http://omeka.org/download">Omeka's website</a> and put it into your SOURCES folder. We have to do some additional work with this file since it's packaged using zip and the RPM is expecting a gzipped tarball. The following code snip assumes you're using the default structure from the rpmdev-setuptree command and if a release after Omeka 1.1 is the most current, you will need to update the revision numbers.

~~~bash
cd ~/rpmbuild/SOURCES
wget http://omeka.org/files/omeka-1.1.zip
unzip omeka-1.1.zip
mv omeka-1.1 omeka
tar -czvf omeka-1.1.tar.gz omeka
~~~

Now if take a look at the directory, you should see a new file named "omeka-1.1.tar.gz" which is in the correct format for using it to build our RPM. There are two more files we need in here, an httpd configuration file and a readme for its use. Let's just touch these so they exist and we can come back and add content to them a little later after I discuss them.

~~~bash
cd ~/rpmbuild/SOURCES
touch fedora-http-conf
touch README.fedora.omeka
~~~

Ok, let's look at the real meat of this now. You need to create an omeka.spec file in the SPECS directory. This is the script that tells the rpmbuild tool how to set up the system.

I use gedit when I have a GUI, but emacs or vi work just as well (better if you're good at the commands).

The idea behind this setup is to set up Omeka much like other software on the system is set up. This assumes that there will be only one installation of Omeka running on the system and takes into account that MySQL may be running on another server, so only the php &amp;gt;= 5.2.4, httpd, php-mysql, and ImageMagick packages are required. The configuration for the database connection is set in /etc/omeka/db.ini and uses a symbolic link to the application files in /usr/share/omeka (though this isn't quite working yet). Themes and the archive folder shouldn't get overwritten, so those directories stay in place. An httpd configuration for omeka (which aliases "/omeka") is added into the httpd.conf directory. Since this software does not actually need to be compiled for a processor architecture type, the build archicture is set to noarch.

~~~bash
Summary: Omeka web publishing software
URL: http://omeka.org
Name: omeka
Version: 1.1
Group: Application/Publishing
Release: 1%{?dist}
License: GPL
Source0: %{name}-%{version}.tar.gz
Source1: omeka-http-conf
Source2: README.fedora.omeka
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
Requires: php &amp;gt;= 5.2.4, httpd, php-mysql, ImageMagick
BuildArch: noarch

%description
Omeka is a free and open source collections based web-based publishing platform for scholars, librarians, archivists, museum professionals, educators, and cultural enthusiasts.

%prep
%setup -q -n omeka

%install
 mkdir -p ${RPM_BUILD_ROOT}%{_datadir}/omeka
 mkdir -p ${RPM_BUILD_ROOT}%{_sysconfdir}/omeka
 install -m 0644 -D -p %{SOURCE1} ${RPM_BUILD_ROOT}%{_sysconfdir}/httpd/conf.d/omeka.conf
 cp -pr * ${RPM_BUILD_ROOT}%{_datadir}/omeka
 #cat db.ini | sed -e "s|dirname(__FILE__).'/'|'/usr/share/omeka/!|g" &amp;gt; ${RPM_BUILD_ROOT}%{_sysconfdir}/omeka/db.ini
 #/bin/ln -sf ../../../etc/omeka/db.ini ${RPM_BUILD_ROOT}%{_datadir}/omeka/db.ini
 /bin/cp %{SOURCE2} ./README.fedora
 # Remove empty files for rmplint
 find ${RPM_BUILD_ROOT} -empty -exec rm -f {} \;
 # These are docs; remove and docify later
 rm -f ${RPM_BUILD_ROOT}%{_datadir}/omeka/{readme.txt,license.txt,release.txt,changelog.txt}

%clean
 rm -rf ${RPM_BUILD_ROOT}

%files
 %defattr(-,root,root,-)
 %config(noreplace) %{_sysconfdir}/httpd/conf.d/omeka.conf
 %dir %{_datadir}/omeka
 %{_datadir}/omeka/admin
 %{_datadir}/omeka/application
 %{_datadir}/omeka/archive
 %doc changelog.txt
 %config(noreplace) %{_sysconfdir}/omeka/db.ini
 %{_datadir}/omeka/index.php
 %doc license.txt
 %{_datadir}/omeka/paths.php
 %{_datadir}/omeka/install
 %{_datadir}/omeka/plugins
 %doc readme.txt
 %doc release.txt
 %{_datadir}/omeka/robots.txt
 %{_datadir}/omeka/themes
 %dir %{_sysconfdir}/omeka

%changelog
* Mon Nov 09 2009 Wayne Graham &amp;lt;wayne dot graham at virginia dot edu&amp;gt; - 1.1
- Initial build
~~~

Now we can add in the httpd configuration that will get written. Open up SOURCES/omeka-http-conf and add

~~~bash

Alias /omeka /var/www/omeka

<Directory /var/www/omeka>
 AllowOverride Options
</Directory>

And README.fedora.omeka

~~~bash

Omeka is a database driven web publishing program.

Once this package is installed, there are a few configuration items which need
to be performed before Omeka is usable.&nbsp; First, you need to establish a
username and password with which to connect to your MySQL database. You also need to make both
MySQL and Omeka aware of this configuration.&nbsp; Let's start by creating the database and the
username / password inside MySQL first:

 # mysql
 mysql&amp;gt; create database omeka;
 Query OK, 1 row affected (0.00 sec)

 mysql&amp;gt; grant all privileges on omeka.* to omeka identified by '1superPrivateOmekaPassword!';
 Query OK, 0 rows affected (0.00 sec)

 mysql&amp;gt; flush privileges;
 Query OK, 0 rows affected (0.00 sec)

 mysql&amp;gt; exit
 Bye
 #

Under certain curcumstances, you may need to run variations of the "grant"
command:
mysql&amp;gt; grant all privileges on omeka.* to omeka@localhost identified by 'omeka';
 OR
mysql&amp;gt; grant all privileges on omeka.* to omeka@'%' identified by 'omeka';

This has created an empty database named 'omeka', created a user named
'omeka' with a password of '1superPrivateOmekaPassword!', and given the 'omeka' user total
permission over the 'omeka' database.&nbsp; Obviously, you'll want to select a
different password, and you may want to choose different database and user
names depending on your installation.&nbsp; The specific values you choose are
not constrained, they simply need to be consistent between the database and the
config file.

Next, you need to edit your /var/www/omeka/db.ini file to reflect the
values you've chosen.&nbsp; These values will go in the appropriate places at the
beginning of that file.

Once that's done and the database server and web server have been started,
open a web browser to http://localhost/omeka/install/ and
follow the instructions given to you on the pages you see to set up the
database tables and begin publishing your Omeka instace.

~~~

Now everything is in place. Let's try to build this thing. Go in to the SPEC directory and build the binary for the rpm.

~~~bash
cd ~/rpmbuild/SPECS
rpmbuild -bb omeka.spec
~~~

This takes a while, and if you're running this through VMWare of VirtualServer, this process will demand some pretty hefty system resources and your system will slow down.

If everything has gone correctly, you should now have a nice new RPM package named omeka-1.1.fc11.noarch.rpm in the RPMS/noarch directory. You can test it out by installing the package with

~~~bash
rpm -Uvh omeka-1.1.fc11.noarch.rpm
~~~

<h2>What's Next</h2>
For packaging RPMs like this, a few more infrastructure elements need to be in place. The following outlines some of them (if you have more, leave a comment).
<ul>
    <li>Put the build files into SCM (currently only in our private SVN repo)</li>
    <li>Auto-install dependencies</li>
    <li>Set up an RPM repository to work with yum
<ul>
    <li>Target specific Linux builds</li>
</ul>
</li>
    <li>Automate build</li>
    <li>Run MySQL setup script after initial install</li>
    <li>Build aptitude package (using <a href="http://packages.debian.org/lenny/alien">alien</a>?)</li>
</ul>
<h2>Additional Resources</h2>
<ul>
    <li><a href="http://docs.fedoraproject.org//developers-guide/ch-rpm-building.html">Chapter 4. Building RPM Packages</a></li>
    <li><a title="How To Build RPM Packages on Fedora" rel="bookmark" href="http://www.g-loaded.eu/2006/04/05/how-to-build-rpm-packages-on-fedora/">How To Build RPM Packages on Fedora</a></li>
    <li><a href="http://fedoraproject.org/wiki/Packaging/ScriptletSnippets">RPM scriptlet recipes</a></li>
    <li><a href="http://fedoraproject.org/wiki/Packaging/NamingGuidelines">Package Naming Guidelines</a></li>
    <li><a href="http://fedoraproject.org/wiki/Packaging/Guidelines">Packaging Guidelines</a></li>
</ul>

