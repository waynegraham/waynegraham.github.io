---
layout: post
status: publish
published: true
title: Form Validation
author: Wayne
author_login: admin
author_email: wayne@liquidfoot.com
author_url: http://liquidfoot.com
wordpress_id: 202
wordpress_url: http://www.liquidfoot.com/?p=202
date: 2006-09-21 09:17:42.000000000 -04:00
categories:
- General
tags:
- coldfusion
- JavaScript
- Web
- AJAX
comments: []
image:
  feature: abstract-3.jpg
  credit: dargadgetz
  creditlink: http://www.dargadgetz.com/ios-7-abstract-wallpaper-pack-for-iphone-5-and-ipod-touch-retina/

---

I've been playing with some form validation stuff for CF. I had been usign , but I wanted the HTML interface to act a bit more like the Flash interface, but I don't really want to use Flash. I've also been doing a lot more work with some of the DHTML libraries that AJAX has made popular, so I figured there had to be a relatively elegent way to do form validations with something like <a href="http://prototype.conio.net/%3Eprototype%3C/a%3E.%3C/p%3E%3Cp%3EI%20remembered%20seeing%20something%20on%20%3Ca%20href=">Ajaxian</a> about easy form validation and decided to give it a try. The article on <a href="http://tetlaw.id.au/view/blog/really-easy-field-validation-with-prototype/">Dexagogo</a> shows how they created a library to handle form-validations that doesn't require any other work than creating a form. This was just what I was looking for!


Basically, you just need the latest files from <a href="http://script.aculo.us/">script.aclo.us</a> with the latest prototype version (the 1.5 release candidate is included in the latest script.aculo.us lib folder), and the validation library. Convienently, they're all included <a href="http://tetlaw.id.au/upload/dev/validation/validation1.5.3.zip">in the demo file on the site</a>.

To use this, you really only need prototype and the validation library (script.aculo.us adds a nice effect &ndash; much like the Flash format in cfform). For me, I made these calls:

~~~html
<head>
  <script type="text/javascript" src="/scripts/scriptaculous/lib/prototype.js"></script>
  <script type=“text/javascript” src=“/scripts/validator.js”></script>
  <script type=“text/javascript” src=“/scripts/scriptaculous/scriptaculous.js?load=effects”></script>
</head>
~~~

This is slightly different than the example on their page; they load the effects.js file directly, I'm calling the library via script.aculo.us with the load parameter. This isn't really a big deal for one library, but it is convenient when you want to use several, but not all, of the libraries (e.g. scriptaculous.js?load=effects,dragdrop,slider).

Anyway, to actually use this, you need to create a form with an id attribute:

~~~html
<form name="feedback" id="feedback" action="#cgi.script_name#" method="post"> 
  ...
</form>
~~~

Now, we add some fields and use the class attribute to call the validator:

~~~html
<div class="code">
    Name: <input type=“text” name=“name” id=“name” class=“required” />
    Email: <input type=“text” name=“email” id=“email” class=“required validate-email” /> 
    <input type=“submit” />
</div>
~~~

There are 11 options for use in the validation library (this is directly off their page):

<ul>
	<li>required (not blank)</li>
	<li>validate-number (a valid number)</li>
	<li>validate-digits (digits only)</li>
	<li>validate-alpha (letters only)</li>
	<li>validate-alphanum (only letters and numbers)</li>
	<li>validate-date (a valid date value)</li>
	<li>validate-email (a valid email address)</li>
	<li>validate-url (a valid URL)</li>
	<li>validate-date-au (a date formatted as; dd/mm/yyyy)</li>
	<li>validate-currency-dollar (a valid dollar value)</li>
	<li>validate-one-required (At least one textbox/radio element must be selected in a group)</li>
</ul>

This is really nice, because if you want to allow an optional field, but validate it, you can do:

~~~html
<input type="text" name="email" class="validate-email" />
~~~

There's one more piece of the pie...to call the validation library. At the bottom of your page add:

~~~html
<script type=“text/javascript”>
  new Validation('feedback', {immediate:true});
</script>
~~~


The first argument is the id attribute of the form you're wanting to validate. The second tells the Validator object what to do. This particular example enables validation on each field as you leave it (which I find useful). Some of the other options are:
<ul>
	<li>stopOnFirst (boolean): Stop on the first validation failure; default: false</li>
	<li>onSubmit (boolean): Override the default behavior of adding an even listener to the onsubmit event (set to false if you want to make sure your onsubmit method gets called no matter what); default: true</li>
	<li>immediate (boolean): validate when the cursor leaves the field; default: false</li>
	<li>focusOnError (boolean): place the focus on the first field with an error; default: true</li>
	<li>useTitles (boolean): make field validators use form element title attributes as error advice message; default: false</li>
	<li>onFormValidate (string function): call a function when the form is validated</li>
	<li>onElementValidate (string function): call a function when an element is validated</li>
</ul>

What I thought was really cool was the ability to add custom validation types via an API. Say you only want folks to use capital letters for their names, you simply add a new validation type like:

~~~html
<script type="javascript"> 
  Validation.add(
    'validate-ucase',
    'Please only use upper-case letters (A-Z) in this field.',
     function(v){ return Validation.get('IsEmpty').test(v) || /^[A-Z]+$/.test(v);
  );
}

~~~

Want to add several? You can do that too:

~~~html
<script type=“javascript”>
  Validation.addAllThese(
    [ 
      [
        'validate-lcase',
        'Please only use lower-case (a-z) letters in this field',
         function(v){ return Validation.get('IsEmpty').test(v) || /^[a-z]+$/.test(v); }
      ],
      [
        'validate-zip',
        'Please check your zip code',
        function(v){ return Validation.get('IsEmpty').test(v) || /^(\d{5})(( |-)?(\d{4}))?$/.test(v); }
      ],
      [
        'validate-phone',
        'Please check your phone number',
        function(v){ return Validation.get('IsEmpty').test(v) || /^(([0-9]{3}-)|([0-9]{3}) ?)?[0-9]{3}-[0-9]{4}$/.test(v); }
      ],
      [
        'validate-ssn',
        'Please check the Social Security Number. It should follow the format 999-99-9999',
        function(v){ return Validation.get('IsEmpty').test(v) || /^([0-9]{3}(-?)[0-9]{2}(-?)[0-9]{4})$/.test(v); }
      ],
      [
        'validate-ip',
        'Please check the IP address',
        function(v){ return Validation.get('IsEmpty').test(v) || /^(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]).(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]).(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]).(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])$/.test(v); }
      ],
      [
        'validate-uuid',
        'Please check the UUID',
        function(v){ return Validation.get('IsEmpty').test(v) || /^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$/.test(v); }
      ],
      [
        'validate-guid',
        'Please check the GUID',
        function(v){ return Validation.get('IsEmpty').test(v) || /^[0-9a-f]{8,8}-[0-9a-f]{4,4}-[0-9a-f]{4,4}-[0-9a-f]{4,4}-[0-9a-f]{12,12}]$/.test(v); }
      ],
      [
        'validate-float',
        'Please only use floating point numbers in this field',
        function(v){ return Validation.get('IsEmpty').test(v) || /^(\b[0-9]+.([0-9]+\b)?|.[0-9]+\b)$/.test(v); }
      ],
      [
        'validate-visa',
        'Please check your credit card number',
         function(v){ return Validation.get('IsEmpty').test(v) || /^4\d{3}-?\d{4}-?\d{4}-?\d{4}$/.test(v); }
      ],
      [
        'validate-mastercard',
        'Please check your credit card number',
        function(v){ return Validation.get('IsEmpty').test(v) || /^5[1-5]\d{2}-?\d{4}-?\d{4}-?\d{4}$/.test(v); }
      ],
      [
        'validate-discovery',
        'Please check your credit card number',
        function(v){ return Validation.get('IsEmpty').test(v) || /^6011-?\d{4}-?\d{4}-?\d{4}$/.test(v); }
      ],
      [
        'validate-amex',
        'Please check your credit card number',
        function(v){ return Validation.get('IsEmpty').test(v) || /^3[4,7]\d{13}$/.test(v); }
      ],
      [
        'validate-diners',
        'Please check your credit card number',
        function(v){ return Validation.get('IsEmpty').test(v) || /^3[0,6,8]\d{12}$/.test(v); }
      ],
      [
        'validate-time',
        'Please only use time in this field',
        function(v){ return Validation.get('IsEmpty').test(v) || /^\d{1,2}[:]\d{2}([:]\d{2})?( [aApP][mM]?)?$/.test(v); }] 
      ]
  );

</script>
~~~

This should be all of the normal items included in  (plus a couple extra for good measure). Now the only thing left is to make it look pretty. One of the nice things about the Flash format in  is that it color codes required fields with the different halo effects. To obtain a similar effect in the forms, we'll use style sheets instead.

This is a rather light stylesheet, but it'll give you something to start with (based on the default haloGreen skin):

~~~html
<style>

input.required, textarea.required {
  border: 1px solid #ffbf2b;
}

input.validation-failed, textarea.validation-failed{
  border: 1px solid #ff3300;
  color: #ff3300;
}

input.validation-passed, textarea.validation-passed{
  border: 1px solid #00cc00;
  color: #000;
}

.validation-advice {
  margin: 5px 0;
  padding: 5px;
  background-color: #FF3300;
  color: #fff;
  font-weight: bold;
}

.custom-advice {
  margin: 5px 0;
  padding: 5px;
  background-color: #c8aa00;
  color: #fff;
  font-weight:bold;
}
</style>
~~~

I made a short example of some of the validations at <a href="http://swem.wm.edu/blogs/waynegraham/examples/validation/">http://swem.wm.edu/blogs/waynegraham/examples/validation/</a>. I have to say that I've found this to be a bit better solution (at least for my needs) than using !</div>
