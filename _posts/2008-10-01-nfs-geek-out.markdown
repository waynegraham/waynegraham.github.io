---
layout: post
status: publish
published: true
title: NFS Geek Out
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 112
wordpress_url: http://www.liquidfoot.com/?p=112
date: 2008-10-01 16:23:34.000000000 -04:00
image:
  feature: abstract-3.jpg
  credit: dargadgetz
  creditlink: http://www.dargadgetz.com/ios-7-abstract-wallpaper-pack-for-iphone-5-and-ipod-touch-retina/

categories:
- Projects
- Computing
tags:
- nfs
- geek
- storage
comments: []
---
And that's not Need for Speed :)

A while back I got a couple of Sun Thumpers (24TB each) to help out with our storage needs in the library. I've gotten to the point to deploy them. I have to admit I really dig the Solaris admin tools (web based ILOM) and the ZFS configuration tools.

The idea for the first Thumper is to make that the primary storage for of content for our institutional repository (we're running DSpace). The last couple of days I've been getting down to a really geeky level in systems administration. I created an NFS share, but the question was on how to mount it. We use nfs3 in the integrated graphics labs to mount the high performance computing clusters, so I did this for DSpace and added an fstab entry


~~~bash
<server>:/dspace /dspace_nfs nfs rw,nosuid,hard,intr,rsize=32768,wsize=32768,tcp 0 0
~~~

I then ran some test to see what kind of throughput I could get.

~~~bash
$ time dd if=/dev/zero of=/dspace_nfs/dspace/testfile bs=16 count=16384
~~~

I got a result of

~~~bash
262144 bytes (262 kB) copied, 0.088866 seconds, 2.9 MB/s
~~~

Then, just to compare it against normal disk I/O, I did the same on the local hard drive

~~~bash
time dd if=dev/zero of=~/testfile bs=16 count=16384
~~~

This was quite a bit faster (as you probably would guess)

~~~bash
262144 bytes (262 kB) copied, 0.041865 seconds, 6.3 MB/s
~~~

To test the read speed, I took the same file and brought it back.

~~~bash
time dd if=/dspace_nfs/dspace/testfile of=/dev/null bs=16
~~~

On the NFS mount I got

~~~bash
262144 bytes (262 kB) copied, 0.017822 seconds, 14.7 MB/s
~~~

and on the local file system I got

~~~bash
262144 bytes (262 kB) copied, 0.015867 seconds, 16.5 MB/s
~~~

I was kind of surprised at how close the reads were. It's not a huge file it's moving (our larger files are around 350MB), but it's reasonably consistence with an arbitrary file size of the PDFs we have in the collection.

I was corresponding with a colleague who's been doing this way longer than I have and he suggested using a larger blocksize and writing/reading some files larger than the RAM size. I also wanted to test against NFS4 (I was using NFS3 in the fstab entry).

To do this, I just created a mount point and mounted the filesystem.

~~~bash
mkdir /mnt/nfs4
mount -t nfs4 <server>:/dspace /mnt/nfs4
~~~


I ran the same test on the new mount and got a result of

~~~bash
262144 bytes (262 kB) copied, 0.055023 seconds, 4.8 MB/s
~~~

and for the read

~~~bash
262144 bytes (262 kB) copied, 0.014205 seconds, 18.5 MB/s
~~~

So, it looks like NFSv4 is much improved over NFSv3!
