FROM alpine:3.7

RUN apk add --update varnish && \
    rm -rf /var/cache/apk/*

WORKDIR /etc/varnish

COPY start.sh /etc/varnish/start.sh

ENV VCL_CONFIG      /etc/varnish/default.vcl
ENV CACHE_SIZE      64m
ENV VARNISHD_PARAMS -p default_ttl=3600 -p default_grace=3600

VOLUME /var/lib/varnish

EXPOSE 80

ENTRYPOINT ["./start.sh"]
