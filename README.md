# nginx-pagespeed-build
Nginx Pagespeed Build environment.

Uses the latest official mainline, automatically triggered by nginx docker releases

## Features
OpenSSL 1.1.1 latest with ec_nistp_64_gcc_128 enabled
Nginx Patched to enable with SPDY, HTTP2 HPACK, Dynamic TLS Records, Prioritize chacha
zlib-cf
pcre-jit

## Nginx Modules , always the latest
brotli
cache-purge
Dav Ext
echo
geoip2
headers-more
http concat
http_substitutions_filter
Memc (memcached)
Nginx Development Kit
ngx_http_image_filter_module
ngx_http_xslt_filter_module
pagespeed
Redis2
set-misc
Srcache
upload-progress
vts

## Not included
ngx_http_js_module
ngx-fancyindex
lua-nginx-module
lua-upstream-nginx-module
nchan
nginx-upstream-fair
nginx-rtmp-module
nginx-vod-module

## Testing
docker pull extremeshok/nginx-pagespeed-build:latest && docker run --rm -ti extremeshok/nginx-pagespeed-build:latest /bin/bash

## Build Options Inspired by
https://github.com/nginx/nginx/blob/master/auto/options
https://raw.githubusercontent.com/centminmod/centminmod/master/inc/nginx_configure.inc
https://github.com/VirtuBox/nginx-ee/blob/master/nginx-build.sh
