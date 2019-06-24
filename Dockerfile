FROM nginx:mainline AS BASE

LABEL mantainer="Adrian Kriel <admin@extremeshok.com>" vendor="eXtremeSHOK.com"

ENV OSSL_VERSION 1.1.1

ENV DEBIAN_FRONTEND noninteractive

# ENFORCE en_us UTF8
ENV SHELL=/bin/bash \
  LC_ALL=en_US.UTF-8 \
  LANG=en_US.UTF-8 \
  LANGUAGE=en_US.UTF-8

RUN echo "**** install packages ****" \
  && apt-get update && apt-get install -y \
  autoconf \
  automake \
  build-essential \
  ca-certificates \
  curl \
  dpkg-dev \
  git \
  libcurl4-openssl-dev \
  libgd-dev \
  libjansson-dev \
  libjpeg-dev \
  libjpeg62-turbo-dev \
  libpcre3 \
  libpcre3-dev \
  libpng-dev \
  libssl-dev \
  libtool \
  libwebp-dev \
  libxml2-dev \
  libxslt1-dev \
  locale-gen \
  python-pip \
  tar \
  unzip \
  uuid-dev \
  wget \
  zlib1g-dev

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
  locale-gen

RUN  echo "**** Add Nginx Repo ****" \
  && CODENAME=$(grep -Po 'VERSION="[0-9]+ \(\K[^)]+' /etc/os-release) \
  && wget http://nginx.org/keys/nginx_signing.key \
  && apt-key add nginx_signing.key \
  && echo "deb http://nginx.org/packages/mainline/debian/ ${CODENAME} nginx" >> /etc/apt/sources.list \
  && echo "deb-src http://nginx.org/packages/mainline/debian/ ${CODENAME} nginx" >> /etc/apt/sources.list \
  && apt-get update

RUN echo "**** Prepare Nginx ****" \
  && mkdir -p /usr/local/src/nginx && cd /usr/local/src/nginx/ \
  && apt source nginx

RUN echo "**** Add OpenSSL 1.1.1 ****" \
  && cd /usr/local/src \
  && git clone --recursive https://github.com/openssl/openssl.git \
  && cd openssl \
  && git checkout OpenSSL_1_1_1-stable \
  && sed -i 's|--with-ld-opt="$(LDFLAGS)"|--with-ld-opt="$(LDFLAGS)" --with-openssl=/usr/local/src/openssl|g' /usr/local/src/nginx/nginx-${NGINX_VERSION}/debian/rules

RUN echo "**** Add Nginx Development Kit ****" \
  && cd /usr/local/src \
  && git clone --recursive https://github.com/simplresty/ngx_devel_kit.git \
  && sed -i 's|--with-ld-opt="$(LDFLAGS)"|--with-ld-opt="$(LDFLAGS)" --with-openssl=/usr/local/src/ngx_devel_kit|g' /usr/local/src/nginx/nginx-${NGINX_VERSION}/debian/rules

RUN echo "**** Add set misc ****" \
  && cd /usr/local/src \
  && git clone --recursive https://github.com/openresty/set-misc-nginx-module.git \
  && sed -i 's|--with-ld-opt="$(LDFLAGS)"|--with-ld-opt="$(LDFLAGS)" --with-openssl=/usr/local/src/set-misc-nginx-module|g' /usr/local/src/nginx/nginx-${NGINX_VERSION}/debian/rules

RUN echo "*** Add libbrotli ****" \
  && cd /usr/local/src \
  && git clone https://github.com/bagder/libbrotli.git \
  && cd libbrotli \
  && ./autogen.sh \
  && ./configure \
  && make -j $(nproc) \
  && make install \
  && ldconfig

RUN echo "**** Add Brotli ****" \
  && cd /usr/local/src \
  && git clone --recursive https://github.com/yverry/ngx_brotli.git \
  && sed -i 's|--with-ld-opt="$(LDFLAGS)"|--with-ld-opt="$(LDFLAGS)" --add-module=/usr/local/src/ngx_brotli|g' /usr/local/src/nginx/nginx-${NGINX_VERSION}/debian/rules

RUN echo "**** Add More Headers ****" \
  && cd /usr/local/src \
  && git clone --recursive https://github.com/openresty/headers-more-nginx-module.git \
  && sed -i 's|--with-ld-opt="$(LDFLAGS)"|--with-ld-opt="$(LDFLAGS)" --add-module=/usr/local/src/headers-more-nginx-module|g' /usr/local/src/nginx/nginx-${NGINX_VERSION}/debian/rules

RUN echo "**** Add Upload Progress ****" \
  && cd /usr/local/src \
  && git clone --recursive https://github.com/masterzen/nginx-upload-progress-module.git \
  && sed -i 's|--with-ld-opt="$(LDFLAGS)"|--with-ld-opt="$(LDFLAGS)" --add-module=/usr/local/src/nginx-upload-progress-module|g' /usr/local/src/nginx/nginx-${NGINX_VERSION}/debian/rules

RUN echo "**** Add Cache Purge ****" \
  && cd /usr/local/src \
  && git clone --recursive https://github.com/nginx-modules/ngx_cache_purge.git \
  && sed -i 's|--with-ld-opt="$(LDFLAGS)"|--with-ld-opt="$(LDFLAGS)" --add-module=/usr/local/src/ngx_cache_purge|g' /usr/local/src/nginx/nginx-${NGINX_VERSION}/debian/rules

RUN echo "*** Add libmaxminddb ****" \
  && cd /usr/local/src \
  && git clone --recursive https://github.com/maxmind/libmaxminddb.git \
  && cd libmaxminddb \
  && ./bootstrap \
  && ./configure \
  && make -j $(nproc) \
  && make install \
  && ldconfig

RUN echo "**** Add Geoip2 ****" \
  && cd /usr/local/src \
  && git clone --recursive https://github.com/leev/ngx_http_geoip2_module.git \
  && sed -i 's|--with-ld-opt="$(LDFLAGS)"|--with-ld-opt="$(LDFLAGS)" --add-module=/usr/local/src/ngx_http_geoip2_module |g' /usr/local/src/nginx/nginx-${NGINX_VERSION}/debian/rules

RUN echo "**** Add Redis2 ****" \
  && cd /usr/local/src \
  && git clone --recursive https://github.com/openresty/redis2-nginx-module.git \
  && sed -i 's|--with-ld-opt="$(LDFLAGS)"|--with-ld-opt="$(LDFLAGS)" --add-module=/usr/local/src/redis2-nginx-module |g' /usr/local/src/nginx/nginx-${NGINX_VERSION}/debian/rules

RUN echo "**** Add Webdav ****" \
  && cd /usr/local/src \
  && git clone --recursive https://github.com/arut/nginx-dav-ext-module.git \
  && sed -i 's|--with-ld-opt="$(LDFLAGS)"|--with-ld-opt="$(LDFLAGS)" --with-http_dav_module --add-module=/usr/local/src/nginx-dav-ext-module |g' /usr/local/src/nginx/nginx-${NGINX_VERSION}/debian/rules

RUN echo "**** Memc ****" \
  && cd /usr/local/src \
  && git clone --recursive https://github.com/openresty/memc-nginx-module.git \
  && sed -i 's|--with-ld-opt="$(LDFLAGS)"|--with-ld-opt="$(LDFLAGS)" --add-module=/usr/local/src/memc-nginx-module |g' /usr/local/src/nginx/nginx-${NGINX_VERSION}/debian/rules

RUN echo "**** Srcache ****" \
  && cd /usr/local/src \
  && git clone --recursive https://github.com/openresty/srcache-nginx-module.git \
  && sed -i 's|--with-ld-opt="$(LDFLAGS)"|--with-ld-opt="$(LDFLAGS)" --add-module=/usr/local/src/srcache-nginx-module |g' /usr/local/src/nginx/nginx-${NGINX_VERSION}/debian/rules

RUN echo "**** echo ****" \
  && cd /usr/local/src \
  && git clone --recursive https://github.com/openresty/echo-nginx-module.git \
  && sed -i 's|--with-ld-opt="$(LDFLAGS)"|--with-ld-opt="$(LDFLAGS)" --add-module=/usr/local/src/echo-nginx-module |g' /usr/local/src/nginx/nginx-${NGINX_VERSION}/debian/rules

RUN echo "**** http concat ****" \
  && cd /usr/local/src \
  && git clone --recursive https://github.com/alibaba/nginx-http-concat.git \
  && sed -i 's|--with-ld-opt="$(LDFLAGS)"|--with-ld-opt="$(LDFLAGS)" --add-module=/usr/local/src/nginx-http-concat |g' /usr/local/src/nginx/nginx-${NGINX_VERSION}/debian/rules

RUN echo "**** Add pagespeed ****" \
  && pip install lastversion \
  && THISVERSION="$(lastversion apache/incubator-pagespeed-ngx)" \
  && curl --silent -o /tmp/ngx-pagespeed.tar.gz -L "https://github.com/apache/incubator-pagespeed-ngx/archive/v${THISVERSION}-stable.tar.gz" \
  && mkdir -p /usr/local/src/ngx-pagespeed \
  && tar xfz /tmp/ngx-pagespeed.tar.gz -C /usr/local/src/ngx-pagespeed \
  && rm -f /tmp/ngx-pagespeed.tar.gz \
  && mv -f /usr/local/src/ngx-pagespeed/*/* /usr/local/src/ngx-pagespeed \
  && curl --silent -o /tmp/psol.tar.gz -L "https://dl.google.com/dl/page-speed/psol/${THISVERSION}-x64.tar.gz" \
  && tar xfz /tmp/psol.tar.gz -C /usr/local/src/ngx-pagespeed \
  && rm -f /tmp/psol.tar.gz \
  && sed -i 's|--with-ld-opt="$(LDFLAGS)"|--with-ld-opt="$(LDFLAGS)" --add-module=/usr/local/src/ngx-pagespeed |g' /usr/local/src/nginx/nginx-${NGINX_VERSION}/debian/rules

RUN echo "*** Patch Nginx Build Config ***" \
  && NGINX_VERSION=$(nginx -v 2>&1 | nginx -v 2>&1 | cut -d'/' -f2) \
  && sed -i 's|CFLAGS="$CFLAGS -Werror"|#CFLAGS="$CFLAGS -Werror"|g' /usr/local/src/nginx/nginx-${NGINX_VERSION}/auto/cc/gcc \
  && sed -i 's|dh_shlibdeps -a|dh_shlibdeps -a --dpkg-shlibdeps-params=--ignore-missing-info|g' /usr/local/src/nginx/nginx-${NGINX_VERSION}/debian/rules

RUN echo "*** Build Nginx ***" \
  && NGINX_VERSION=$(nginx -v 2>&1 | nginx -v 2>&1 | cut -d'/' -f2) \
  && cd /usr/local/src/nginx/nginx-${NGINX_VERSION}/ \
  && apt build-dep nginx -y  \
  && dpkg-buildpackage -b \
  && cd /usr/local/src/nginx \
  && dpkg -i nginx*.deb

RUN echo "**** configure ****"
RUN mkdir -p /var/cache/pagespeed \
&& mkdir -p /var/cache/nginx

WORKDIR /var/www/html

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
