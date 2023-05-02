FROM  ubuntu:20.04
LABEL MAINTAINER="GeniusLive"

# Environment variable to configure timezone
ENV TZ=Etc/UTC \
    FFMPEG_VERSION=4.4

WORKDIR /tmp/workdir

RUN apt update \
    && apt install -y \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

# Install GPAC build dependencies
RUN apt update \
    && apt install -y \
    build-essential \
    ccache \
    cmake \
    curl \
    debhelper \
    dvb-apps \
    fonts-open-sans \
    g++ \
    git \
    liba52-0.7.4-dev \
    libaom-dev \
    libasound2-dev \
    libass-dev \
    libavc1394-dev \
    libcdio-cdda-dev \
    libcdio-dev \
    libcdio-paranoia-dev \
    libdrm-dev \
    libfaad-dev \
    libfdk-aac-dev \
    libfreetype6-dev \
    libgl1-mesa-dev \
    libiec61883-dev \
    libjack-dev \
    libjpeg62-dev \
    libmad0-dev \
    libmp3lame-dev \
    libogg-dev \
    libopenal-dev \
    libopencore-amrnb-dev \
    libopencore-amrwb-dev \
    libopus-dev \
    libpng-dev \
    libpulse-dev \
    libraw1394-dev \
    libsdl2-dev \
    libsrt-dev \
    libssl-dev \
    libssl1.1 \
    libtheora-dev \
    libvorbis-dev \
    libvpx-dev \
    libwebp-dev \
    libx264-dev \
    libx265-dev \
    libxcb-shape0-dev \
    libxcb-shm0-dev \
    libxcb-xfixes0-dev \
    libxv-dev \
    libxvidcore-dev \
    mesa-utils \
    pkg-config \
    scons \
    wget \
    x11proto-gl-dev \
    x11proto-video-dev \
    yasm \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

## Build ffmpeg https://ffmpeg.org/
RUN  \
    DIR=/tmp/ffmpeg && mkdir -p ${DIR} && cd ${DIR} && \
    curl -sLO https://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.bz2 && \
    tar -jx --strip-components=1 -f ffmpeg-${FFMPEG_VERSION}.tar.bz2 && \
    ./configure \
    --disable-debug \
    --disable-doc \
    --disable-ffplay \
    --enable-fontconfig \
    --enable-gpl \
    --enable-libaom \
    --enable-libass \
    --enable-libfdk_aac \
    --enable-libfreetype \
    --enable-libmp3lame \
    --enable-libopencore-amrnb \
    --enable-libopencore-amrwb \
    --enable-libopus \
    --enable-libsrt \
    --enable-libtheora \
    --enable-libvorbis \
    --enable-libvpx \
    --enable-libwebp \
    --enable-libx264 \
    --enable-libx265 \
    --enable-libxcb \
    --enable-libxvid \
    --enable-nonfree \
    --enable-openssl \
    --enable-postproc \
    --enable-shared \
    --enable-small \
    --enable-version3 \
    --extra-libs=-ldl \
    --extra-libs=-lpthread && \
    make -j && \
    make install

RUN wget https://download.tsi.telecom-paristech.fr/gpac/new_builds/linux64/gpac/gpac_2.3-DEV-rev218-g3af33cd3-master_amd64.deb \
    && dpkg -i --force-all gpac_2.3-DEV-rev218-g3af33cd3-master_amd64.deb

RUN apt update \
    && apt --fix-broken -y install \
    && rm -rf /var/lib/apt/lists/*
