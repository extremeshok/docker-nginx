# nginx-pagespeed-build
Nginx Build environment.

Uses the latest official mainline, automatically triggered by nginx docker releases

## Features
OpenSSL 1.1.1 latest with ec_nistp_64_gcc_128 enabled
Nginx Patched to enable with SPDY, HTTP2 HPACK, Dynamic TLS Records, Prioritize chacha
zlib-cf
pcre-jit

## Nginx Modules , always the latest versions
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
pagespeed-stable
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

## Example Nginx -V
```
nginx version: nginx/1.17.0
built by gcc 6.3.0 20170516 (Debian 6.3.0-18+deb9u1)
built with OpenSSL 1.1.1d-dev  xx XXX xxxx
TLS SNI support enabled
configure arguments: --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --user=nginx --group=nginx --with-compat --with-file-aio --with-threads --with-http_addition_module --with-http_auth_request_module --with-http_dav_module --with-http_flv_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-stream --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-cc-opt='-g -O2 -fdebug-prefix-map=/usr/local/src/nginx/nginx-1.17.0=. -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fPIC' --with-ld-opt='-Wl,-z,relro -Wl,-z,now -Wl,--as-needed -pie' --with-pcre-jit --with-pcre=/usr/local/src/pcre --with-zlib=/usr/local/src/zlib-cf --with-http_v2_hpack_enc --with-http_xslt_module --with-http_image_filter_module --add-module=/usr/local/src/ngx_devel_kit --add-module=/usr/local/src/ngx-pagespeed --add-module=/usr/local/src/nginx-http-concat --add-module=/usr/local/src/ngx_http_substitutions_filter_module --add-module=/usr/local/src/echo-nginx-module --add-module=/usr/local/src/srcache-nginx-module --add-module=/usr/local/src/memc-nginx-module --with-http_dav_module --add-module=/usr/local/src/nginx-dav-ext-module --add-module=/usr/local/src/redis2-nginx-module --add-module=/usr/local/src/ngx_http_geoip2_module --add-module=/usr/local/src/ngx_cache_purge --add-module=/usr/local/src/nginx-upload-progress-module --add-module=/usr/local/src/headers-more-nginx-module --add-module=/usr/local/src/ngx_brotli --add-module=/usr/local/src/nginx-module-vts --add-module=/usr/local/src/set-misc-nginx-module --with-openssl=/usr/local/src/openssl --with-openssl-opt=enable-ec_nistp_64_gcc_128
```
