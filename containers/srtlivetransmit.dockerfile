FROM  ubuntu:20.04
LABEL MAINTAINER="GeniusLive"

RUN apt update && apt install tzdata -y && rm -rf /var/lib/apt/lists/*

# Environment variable to configure timezone
ENV TZ=Etc/UTC \
    LIBSRT_VERSION=1.4.1

WORKDIR /tmp/workdir

RUN apt update \
    && apt install -y \
    build-essential \
    cmake \
    curl \
    dvb-apps \
    g++ \
    git \
    liba52-0.7.4-dev \
    libaom-dev \
    libasound2-dev \
    libass-dev \
    libavc1394-dev \
    libavcodec-dev \
    libavdevice-dev \
    libavformat-dev \
    libavutil-dev \
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
    librtmp-dev \
    libsdl2-dev \
    libsrt-dev \
    libssl-dev \
    libssl1.1 \
    libswscale-dev \
    libtheora-dev \
    libvorbis-dev \
    libvpx-dev \
    libwebp-dev \
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

RUN \
    DIR=/tmp/srt && \
    mkdir -p ${DIR} && \
    cd ${DIR} && \
    curl -sLO https://github.com/Haivision/srt/archive/v${LIBSRT_VERSION}.tar.gz && \
    tar -xz --strip-components=1 -f v${LIBSRT_VERSION}.tar.gz && \
    cmake . && \
    make && \
    make install && \
    rm -rf ${DIR}

