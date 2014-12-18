# nginx-globals

## Summary
My nginx configuration files that were crafted security in mind, combined into seperate conf files to simplify locking down sites. Benefit from my years of tweaking nginx, and fortify your webserver with more vitamins and nutriuents than ever before!

## Usage
* Install nginx (yes, but someone had to say it)

* Checkout the project

```
git clone https://github.com/philcryer/nginx-globals.git
```

* Copy the globals into place

```
cp -R nginx-globals/globals /etc/nginx/
```

* Activate them within a 'sites-enabled' config

```
server {
  ...
  include       globals/cache.conf;
  include       globals/drop.conf;
  include       globals/secure.conf;
  include       globals/ssl.conf;
  ...
}
```

* Test the config changes

```
nginx -t
```

* Errors? Fix them. No errors? Restart nginx

## Feedback
These are my tried and true nginx configs, some crafted from trial and error, some snarfed from various sites online (credit given where known, see individual files for details). Having said that, there's no way they're all perfect and I'm sure others could improve on them. Please feel free to open an issue, or make a pull request - Thanks!

## License
The MIT License (MIT)

Copyright (c) 2014 philcryer::fak3r

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

