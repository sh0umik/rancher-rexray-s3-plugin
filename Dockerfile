FROM alpine:3.5

RUN apk update
RUN apk add xfsprogs e2fsprogs ca-certificates fuse alpine-sdk automake autoconf libxml2-dev fuse-dev curl-dev

RUN git clone https://github.com/s3fs-fuse/s3fs-fuse.git && cd s3fs-fuse && ./autogen.sh \
    && ./configure --prefix=/usr && make && make install && cd .. && rm -rf s3fs-fuse

RUN rm -rf /var/cache/apk/*

RUN mkdir -p /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
RUN mkdir -p /etc/rexray /run/docker/plugins /var/lib/rexray/volumes

RUN /usr/bin/curl -sSL https://dl.bintray.com/emccode/rexray/install | sh -s stable

ADD config.yml /etc/rexray/config.yml

ADD start-rex.sh /rexray.sh
RUN chmod +x /rexray.sh

ENTRYPOINT [ "/rexray.sh" ]