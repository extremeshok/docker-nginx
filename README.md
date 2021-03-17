# eXtremeSHOK.com :: nginx

https://hub.docker.com/r/extremeshok/nginx

Custom Nginx Built following the official nginx Debian Stretch Docker

* Follows the latest official mainline, build is automatically triggered by nginx docker releases
* Multistage-build docker for the smallest possible image size.
* All nginx modules static (not dynamic modules)
* Drop-in replacement for nginx:mainline
* Nginx patches are verified and from trusted sources (all patches used, are hosted in this repo)

## About
Used for all our webservers, serving millions of pages a month. First byte times are 0.24s or lower with full SSL.

## Note
If you have any ideas or suggestions, please open an issue or pull request

## Thank you
* chandr1000 (Irina Shinakawa) for mod-security

## Features
* OpenSSL 1.1.1 latest (TLS 1.3) with ec_nistp_64_gcc_128 enabled (speed)
* Nginx Patched to enable with SPDY, HTTP2 HPACK, Dynamic TLS Records, Prioritize chacha (speed)
* zlib-cf (Cloudflare’s Zlib for 25-100% performance increase)
* pcre-jit with the latest pcre release (speed)
* Pagespeed stable branch with psol
* Brotli
* Latest GD with webp
* Legacy modules replaced (redis -> redis2, geoip -> geoip2)

## Nginx Modules , always the latest versions from their respective Repositories
* brotli
* cache-purge
* Dav Ext
* echo
* geoip2
* headers-more
* http concat
* http_substitutions_filter
* Memc (memcached)
* mod_security
* Nginx Development Kit
* ngx_http_image_filter_module **dynamic module**
* ngx_http_xslt_filter_module
* pagespeed-stable
* Redis2
* set-misc
* Srcache
* upload-progress
* vts

Important note: you must include both modsecurity.conf and modsecurity-crs to your server config by yourself (path: /etc/nginx/modsec)

## Not included
* lua-nginx-module
* lua-upstream-nginx-module
* modsecurity-crs
* naxsi
* nchan
* nginx-rtmp-module
* nginx-upstream-fair
* nginx-vod-module
* ngx_http_js_module
* ngx-fancyindex

## Testing
```
docker pull extremeshok/nginx:latest && docker run --rm -ti extremeshok/nginx:latest /bin/bash
```

## Example Nginx -V
```
nginx version: nginx/1.17.x
built by gcc 6.3.0 20170516 (Debian 6.3.0-18+deb9u1)
built with OpenSSL 1.1.1d-dev  xx XXX xxxx
TLS SNI support enabled
configure arguments:
--prefix=/etc/nginx
--sbin-path=/usr/sbin/nginx
--modules-path=/usr/lib/nginx/modules
--conf-path=/etc/nginx/nginx.conf
--error-log-path=/var/log/nginx/error.log
--http-log-path=/var/log/nginx/access.log
--pid-path=/var/run/nginx.pid
--lock-path=/var/run/nginx.lock
--http-client-body-temp-path=/var/cache/nginx/client_temp
--http-proxy-temp-path=/var/cache/nginx/proxy_temp
--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp
--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp
--http-scgi-temp-path=/var/cache/nginx/scgi_temp
--user=nginx
--group=nginx
--with-compat
--with-file-aio
--with-threads
--with-http_addition_module
--with-http_auth_request_module
--with-http_dav_module
--with-http_flv_module
--with-http_gunzip_module
--with-http_gzip_static_module
--with-http_mp4_module
--with-http_random_index_module
--with-http_realip_module
--with-http_secure_link_module
--with-http_slice_module
--with-http_ssl_module
--with-http_stub_status_module
--with-http_sub_module
--with-http_v2_module
--with-mail
--with-mail_ssl_module
--with-stream
--with-stream_realip_module
--with-stream_ssl_module
--with-stream_ssl_preread_module
--with-cc-opt='-g -O2 -fdebug-prefix-map=/usr/local/src/nginx/nginx-1.17.0=. -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fPIC'
--with-ld-opt='-Wl,-z,relro -Wl,-z,now -Wl,--as-needed -pie'
--with-pcre-jit
--with-pcre=/usr/local/src/pcre
--with-zlib=/usr/local/src/zlib-cf
--with-http_v2_hpack_enc
--with-http_xslt_module
--with-http_image_filter_module
--add-module=/usr/local/src/ngx_devel_kit
--add-module=/usr/local/src/ngx-pagespeed
--add-module=/usr/local/src/nginx-http-concat
--add-module=/usr/local/src/ngx_http_substitutions_filter_module
--add-module=/usr/local/src/echo-nginx-module
--add-module=/usr/local/src/srcache-nginx-module
--add-module=/usr/local/src/memc-nginx-module
--with-http_dav_module
--add-module=/usr/local/src/nginx-dav-ext-module
--add-module=/usr/local/src/redis2-nginx-module
--add-module=/usr/local/src/ngx_http_geoip2_module
--add-module=/usr/local/src/ngx_cache_purge
--add-module=/usr/local/src/nginx-upload-progress-module
--add-module=/usr/local/src/headers-more-nginx-module
--add-module=/usr/local/src/ngx_brotli
--add-module=/usr/local/src/nginx-module-vts
--add-module=/usr/local/src/set-misc-nginx-module
--with-openssl=/usr/local/src/openssl
--with-openssl-opt=enable-ec_nistp_64_gcc_128
```

## Build Options Inspired by
https://github.com/nginx/nginx/blob/master/auto/options https://raw.githubusercontent.com/centminmod/centminmod/master/inc/nginx_configure.inc https://github.com/VirtuBox/nginx-ee/blob/master/nginx-build.sh
