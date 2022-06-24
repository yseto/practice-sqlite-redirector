FROM debian:11-slim

RUN apt-get -y update
RUN apt-get -y install git
RUN apt-get -y install curl
RUN apt-get -y install rake
RUN apt-get -y install ruby ruby-dev
RUN apt-get -y install bison
RUN apt-get -y install libcurl4-openssl-dev libssl-dev
RUN apt-get -y install libhiredis-dev
RUN apt-get -y install libmarkdown2-dev
RUN apt-get -y install libcap-dev
RUN apt-get -y install libcgroup-dev
RUN apt-get -y install make
RUN apt-get -y install libpcre3 libpcre3-dev
RUN apt-get -y install libsqlite3-dev
RUN apt-get -y install gcc
RUN apt-get -y install wget
RUN apt-get -y install zlib1g-dev

RUN cd /usr/local/src/ && git clone https://github.com/matsumotory/ngx_mruby.git
RUN cd /usr/local/src/ngx_mruby && git checkout b9febb822e1efe6a3416daf64760a096ef75e16f
COPY build_config.rb /usr/local/src/ngx_mruby/build_config.rb
ENV NGINX_CONFIG_OPT_ENV --with-http_stub_status_module --with-http_ssl_module --prefix=/usr/local/nginx --with-http_realip_module --with-http_addition_module --with-http_sub_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_random_index_module --with-http_secure_link_module
RUN cd /usr/local/src/ngx_mruby && sh build.sh && make install

EXPOSE 80
EXPOSE 443

CMD ["/usr/local/nginx/sbin/nginx"]
