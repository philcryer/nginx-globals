I found that howtoforge has some updated ideas, let's compare [their setup](https://www.howtoforge.com/tutorial/nginx-with-letsencrypt-ciphersuite/#step-ssl-configuration) with this to see if there are better ways to go

their ssl.conf

```
# Specify the TLS versions
ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
ssl_prefer_server_ciphers on;

# Ciphersuites recommendation from the chiper.li
# Use this chipersuites to get 100 points of the SSLabs test
# Some device will not support
#ssl_ciphers "ECDHE-RSA-AES256-GCM-SHA512:DHE-RSA-AES256-GCM-SHA512:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-SHA384";

# Mozilla Ciphersuits Recommendation
# Use this for all devices supports
ssl_ciphers 'ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256';

# Use the DHPARAM key and ECDH curve >= 256bit
ssl_ecdh_curve secp384r1;
ssl_dhparam /etc/nginx/dhparam.pem;

server_tokens off;
ssl_session_timeout 1d;
ssl_session_cache shared:SSL:50m;
ssl_session_tickets off;

# Enable HTTP Strict-Transport-Security
# If you have a subdomain of your site,
# be carefull to use the 'includeSubdomains' options
add_header Strict-Transport-Security "max-age=63072000; includeSubdomains; preload";

# Enable OSCP Stapling for Nginx web server
# If you're using the SSL from Letsencrypt,
# use the 'chain.pem' certificate
ssl_stapling on;
ssl_stapling_verify on;
ssl_trusted_certificate /etc/letsencrypt/live/hakase-labs.io/chain.pem;
resolver 8.8.8.8 8.8.4.4 valid=300s;
resolver_timeout 5s;

# XSS Protection for Nginx web server
add_header X-Frame-Options DENY;
add_header X-XSS-Protection "1; mode=block";
add_header X-Content-Type-Options nosniff;
add_header X-Robots-Tag none;
```

basic nginx.conf

```
server {
    listen 80;
    listen [::]:80;
    server_name hakase-labs.io;

    return 301 https://$host$request_uri;
}

server {
        listen 443 ssl http2;
        listen [::]:443 ssl http2;

        root   /var/www/site01;
        index index.html index.php index.htm;

        server_name  hakase-labs.io;
        error_log /var/log/nginx/hakase-error.log warn;

        ssl_certificate /etc/letsencrypt/live/hakase-labs.io/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/hakase-labs.io/privkey.pem;

        #SSL Configuration
        include snippets/ssl.conf;

        location ~ /.well-known {
                allow all;
        }


        location / {
            try_files $uri $uri/ =404;
        }


        location = /favicon.ico {
                log_not_found off;
                access_log off;
        }

        location = /robots.txt {
                allow all;
                log_not_found off;
                access_log off;
        }

        location ~* \.(js|css|png|jpg|jpeg|gif|ico)$ {
                expires max;
                log_not_found off;
        }

}
```
