---
layout: post
status: publish
published: true
title: CakePHP Authentication
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 81
wordpress_url: http://www.liquidfoot.com/?p=81
date: 2008-09-12 12:47:18.000000000 -04:00
categories:
- Programming
tags:
- php
- cakephp
- authentication
comments: []
---
I found some great tutorials on implementing ACL authentication in CakePHP. However, for the longest time I couldn't get the actual example code to work. The way to authenticate everything in your application is to create an app_controller.php file in your app folder (see <a href="http://book.cakephp.org/view/643/Preparing-to-Add-Auth">Preparing to Add Auth</a>). In every other controller I've created in CakePHP, you follow this convention:

~~~php
<?php

class FooBarsController extends AppController
{
  var $name = 'FooBars';
}

?>
~~~

I followed the same convention (didn't read the docs very closely) and just got all kinds of errors. After digging a bit deeper, turns out AppController extends Controller...apparently it can't extend itself :)

Hopefully this'll save some time for someone, but the full controller for the example in the cookbook for the app_controller.php is this:

~~~php
<?php

class AppController extends Controller {
  var $components = array('Auth', 'Acl');

  function beforeFilter() {
    //Configure AuthComponent
    $this->Auth->authorize = 'actions';
    $this->Auth->loginAction = array('controller' => 'users', 'action' => 'login');
    $this->Auth->logoutRedirect = array('controller' => 'users', 'action' => 'login');
    $this->Auth->loginRedirect = array('controller' => 'posts', 'action' => 'add');
  }
}
?>
~~~
