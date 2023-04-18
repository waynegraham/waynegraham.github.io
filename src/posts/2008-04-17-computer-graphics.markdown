---
layout: post
status: publish
published: true
title: Computer Graphics
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 164
wordpress_url: http://www.liquidfoot.com/?p=164
date: 2008-04-17 08:27:13.000000000 -04:00
image:
  feature: abstract-3.jpg
  credit: dargadgetz
  creditlink: http://www.dargadgetz.com/ios-7-abstract-wallpaper-pack-for-iphone-5-and-ipod-touch-retina/

categories:
- Projects
tags:
- graphics
comments: []
---
As I mentioned in my last post, I've been silent for a while. I've had a major project in deploying some institutional repository software (<a href="http://www.dspace.org/">DSpace</a>) to collect the <a href="http://dspace.swem.wm.edu/">research that students here at William and Mary</a> are doing in a systematic way. Generally this is deployed with more than one person...but you do what you need to do to finish a project ;)

The other major time consuming project has been my idea that taking computer graphics would be fun. Just a short footnote about me, I'm a former historian who got into computers during graduate school. Anyway, the College hired John Van Rosendale, who among other things, funded NVidia to develop those wonderful drivers for Linux when he was at the NSF. I was pretty geeked about the class, and talked with John before the semester started. He said that while I didn't have the math background (his idea of "basic math" is advanced calculus and linear algebra) or the programming background (he wanted us to use C/C++), that I would just have to learn that stuff.

Our first programming assignment (after about a month of linear algebra and vector math review) was to create a wireframe barn in OpenGL. This was the first time I had worked with C/C++ (most of my "real" programming has been in Java), so developing the Vector and Matrix classes to do all the perspective transformations took a little longer than I had expected. After that, generating views using OpenGL line primitives was a snap.

All was good until I got to the second part of the assignment...a non-recursive ray tracer that implemented Gouraud and Phong lighting models on a pyramid. After several weeks of messing with the code and getting no where, I wanted to drop the course. John wouldn't let me, and got me through line-triangle intersections using barycentric coordinates. It didn't look like much at the time, really just a square, but it was a great (though very frustrating) introduction to ray-object intersections, coordinate systems, barycentric coordinate calculations, and lighting models.

Immediately after this, our first project was to implement from scratch, a recursive ray tracer that handled reflection, refraction, specular hightlights, and shading for a scene of spheres on a checkerboard floor. I got the specular highlights and shadows pretty quickly, but had a hard time with refraction (well, I guess I also had a problem with RGB because I was going from 0 to 255 instead of 0 to 1, but that was just a bug).

When all was said and done, I learned a lot in this course and realized how brilliant folks like Ed Catmull (Pixar) are when they were inventing this stuff back in the 1970s!

Anyway, here are a couple of samples of the images I produced using my ray tracing engine. Each has has reflective and refractive surfaces with a maximum recursion depth of 5 with a cylinder texture-mapped with a sky image. Each image took just over a minute to render on a dual quad-core Xeon @ 3.2 GHz.

<img class="alignnone size-thumbnail wp-image-165" title="scene1" src="http://www.liquidfoot.com/wp-content/uploads/2009/01/scene1-150x150.png" alt="scene1" width="150" height="150" />

<img class="alignnone size-thumbnail wp-image-166" title="scene2" src="http://www.liquidfoot.com/wp-content/uploads/2009/01/scene2-150x150.png" alt="scene2" width="150" height="150" />
