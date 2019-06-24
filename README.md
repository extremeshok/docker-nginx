# nginx-pagespeed-build
Nginx Pagespeed Build environment.

Uses the latest official mainline, automatically triggered by nginx releases

## Features
OpenSSL 1.1.1 latest
Nginx Patched to enable with SPDY, HTTP2 HPACK, Dynamic TLS Records, Prioritize chacha

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
pagespeed
Redis2
set-misc
Srcache
upload-progress
vts

## Not included
ngx_http_image_filter_module
ngx_http_js_module
ngx_http_xslt_filter_module-debug
ngx-fancyindex
lua-nginx-module
lua-upstream-nginx-module
nchan
nginx-upstream-fair
nginx-rtmp-module
nginx-vod-module

## Testing
docker pull extremeshok/nginx-pagespeed-build:latest && docker run --rm -ti extremeshok/nginx-pagespeed-build:latest /bin/bash
