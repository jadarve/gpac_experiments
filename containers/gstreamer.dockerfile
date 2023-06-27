FROM  ubuntu:22.04
LABEL MANTAINER="GeniusLive"

# Setting bash as the default shell in this container
SHELL ["/bin/bash", "-c"] 

# Environment variable to configure timezone
ENV TZ=Etc/UTC \
    FFMPEG_VERSION=5.1

WORKDIR /tmp/workdir

RUN apt update \
    && apt install -y tzdata \
    && rm -rf /var/lib/apt/lists/*

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
    libsrt-openssl-dev \
    libssl-dev \
    libswscale-dev \
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
    libsrtp2-dev \
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
    make install && \
    ldconfig

ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64

RUN apt update \
    && apt remove -y \
    meson \
    && apt install -y \
    python3-pip \
    flex \
    bison \
    && pip3 install meson ninja \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 --branch 1.22.2 https://github.com/GStreamer/gstreamer.git \
    && cd gstreamer \
    && meson setup --wipe \
    -Dlibav=enabled \
    -Dgood=enabled \
    -Dbad=enabled \
    -Dugly=enabled \
    -Dgpl=enabled \
    -Dgst-plugins-bad:rtmp=enabled \
    -Dgst-plugins-bad:srt=enabled \
    builddir \
    && meson compile -C builddir \
    && cd builddir \
    && meson install \
    && ldconfig

# Install curl and cargo
RUN curl https://sh.rustup.rs -sSf > rustup.sh \
    && chmod +x rustup.sh \
    && ./rustup.sh -y \
    && rm -f rustup.sh

ENV PATH="/root/.cargo/bin:${PATH}"
RUN git clone --depth 1 https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs.git  \
    && cd gst-plugins-rs \
    && cargo build --release

ENV GST_PLUGIN_PATH=/tmp/workdir/gst-plugins-rs/target/release:$GST_PLUGIN_PATH

WORKDIR /usr/lib/geniuslive/gstreamer/plugin

RUN rm -rf sources

# Install fallbackswitch plugin, which has fallbacksrc element
RUN git clone --depth 1 https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs.git \
    && cd gst-plugins-rs \
    && source "$HOME/.cargo/env" \
    && cargo install cargo-c \
    && cargo cbuild --release -p gst-plugin-fallbackswitch

RUN mv gst-plugins-rs/target/x86_64-unknown-linux-gnu/release/libgstfallbackswitch.so . \
    && rm -rf gst-plugins-rs

ENV GST_PLUGIN_PATH=/usr/lib/geniuslive/gstreamer/plugin
