gpac -i rtmp://:1935/live:gpac:rtmp_listen=1 \
    reframer:rt=on \
    cecrypt:cfile="/tmp/workdir/gpac-drm-dash.xml":#video:#audio \
    -o /tmp/workdir/content/playlist.mpd:dmode=dynamic:segdur=1:cdur=0.2:asto=0.8:cmaf=cmfc:profile=dashif.ll:pssh=m:utcs=https://time.akamai.com/?iso \
    -graph
