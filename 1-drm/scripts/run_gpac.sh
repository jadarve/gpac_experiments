gpac -i rtmp://:1935/live:gpac:rtmp_listen=1 \
    cecrypt:cfile="/tmp/workdir/gpac-drm-dash.xml" \
    -o /tmp/workdir/content/playlist.mpd:segdur=2:cdur=0.2:asto=1.8:cmaf=cmfc:profile=dashif.ll:dmode=dynamic:template=segment_dash:rdirs=gmem:hmode=push:pssh=mv:nosync=false:utcs=inband
