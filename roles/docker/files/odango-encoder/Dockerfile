FROM alpine:3.4
MAINTAINER spring-raining <harusamex.com@gmail.com>

ARG FFMPEG_VERSION=3.1.3
ARG ENCODER_WORKDIR="/usr/local/odango-encoder"

RUN set -x \
        && echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories \
        && apk upgrade --update \
        && apk add \
                bash \
                'nodejs>=6.2.0' \
                git \
                coreutils \
                ca-certificates \
                zlib-dev \
                yasm-dev \
                faac-dev \
                fdk-aac-dev \
                lame-dev \
                opus-dev \
                libvorbis-dev \
                libvpx-dev \
                x264-dev \
                x265-dev \
                openssl-dev \
        && apk add --virtual .build-deps \
                curl \
                tar \
                make \
                gcc \
                g++ \
                autoconf \
                automake \
                nasm \

        # ffmpeg
        && cd /tmp \
        && curl http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.gz -o ffmpeg.tar.gz \
        && tar xvzf ffmpeg.tar.gz \
        && cd ffmpeg-${FFMPEG_VERSION} \
        && ./configure \
                --enable-gpl \
                --enable-version3 \
                --enable-nonfree \
                --enable-small \
                --enable-libfaac \
                --enable-libfdk-aac \
                --enable-libmp3lame \
                --enable-libopus \
                --enable-libvorbis \
                --enable-libvpx \
                --enable-libx264 \
                --enable-libx265 \
                --enable-openssl \
        && make \
        && make install \
        && make distclean \

        # odango-encoder
        && git clone https://github.com/spring-raining/odango-encoder.git ${ENCODER_WORKDIR} \
        && cd ${ENCODER_WORKDIR} \
        && git checkout master \
        && npm install \
        && npm install -g pm2 \

        # cleaning
        && apk del --purge .build-deps \
        && rm -rf /tmp/* \
        && rm -rf /var/cache/apk/*

ADD services.sh /usr/local/bin
CMD ["/usr/local/bin/serivces.sh"]
EXPOSE 6000

