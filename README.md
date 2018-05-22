# nginx-globals

## Summary
This project contains my current nginx configuration files that were crafted with security in mind, all combined into separate conf files to simplify and standardize configurations. By calling these from include statements in your NGINX configs it makes locking down your nginx server easy - so while this is a simple project, it will help lock down NGINX (likely) more than you have it now. Benefit from my years of tweaking NGINX, and fortify your webserver! All feedback welcome!

__New__ this doc now covers the use of [Let's Encrypt](https://letsencrypt.org/) to include free SSL certificates. So easy!

## Usage
* Install NGINX

* (Optional, but  highly recommended) Install an NGINX version with [naxsi](https://github.com/nbs-system/naxsi) (which stands for Nginx Anti XSS & SQL Injection) enabled to provide WAF style protection. I'm using the OpenBSD version from [Ports](http://ports.su/www/nginx,-naxsi)), otherwise you can [roll your own](https://github.com/nbs-system/naxsi/wiki) to enable it in Linux

* (Optional, but highly recommended) Get a free SSL Cert from [Let's Encrypt](https://letsencrypt.org/getting-started/), if you don't already have one. Use `certbot` to automate this, here's an example, just replace DOMAIN with your FQDN

```
certbot certonly --agree-tos --webroot -w /var/www/htdocs -d DOMAIN -d www.DOMAIN
```

* Checkout the nginx-globals project

```
git clone https://github.com/philcryer/nginx-globals.git
```

* As root, Copy the globals configs into the nginx directory

```
cp -R nginx-globals/globals /etc/nginx/
```

* Edit your nginx site config and activate the globals you want, commenting out anything you don't want to run (if any). If you're running SSL be sure to specify the path and file name of the SSL cert and its key 

```
server {
  ...
  include       globals/cache.conf;
  include       globals/drop.conf;
  include       globals/php.conf;
  include       globals/secure.conf;
  include       globals/ssl.conf;
  ...
}
```

* Test the config changes before running them in nginx

```
nginx -t
```

* Errors? Most are simply duplicate lines from current configs that you can remove/comment out since they're now in the globals. Do that and run `nginx -t` again (repeat as many times as neccessary)

* No errors? Restart nginx with the global configs

```
service nginx restart
```

* (Optional if you're running SSL) test your SSL setup using [Qualys SSL Server Test](https://www.ssllabs.com/ssltest/index.html), then [High-Tech Bridge SSL Server Security Test](https://www.htbridge.com/ssl/), and expect to get an __A+__ on both.

## Further tweaking
Things can always be improved, here are some more tools to help

* [yandex/gixy](https://github.com/yandex/gixy)

## Apache version?

I always thought of making an Apache version of these rules, while I don't use it for personal projects anymore, I do encounter it from time to time on client jobs. I've found a project very similar to mine at [h5bp/server-configs-apache](https://github.com/h5bp/server-configs-apache/), expecially checkout the [security](https://github.com/h5bp/server-configs-apache/tree/master/src/security) configs, excellent work there!

## Feedback
These are my tried and true nginx configs, some crafted from trial and error, while some were snarfed from various sites or posts online, giving credit where due (see individual files for details). Having said that, there's no way they're all perfect and I'm sure others could improve on them, so please do! Open an issue, suggest changes or make a pull request - thanks!

## License
The MIT License (MIT)

Copyright (c) 2018 philcryer

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
