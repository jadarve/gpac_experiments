gpac -i udp://0.0.0.0:5000/:gpac:listen=true:tsprobe=true \
    reframer:rt=on \
    cecrypt:cfile="/tmp/workdir/gpac-drm-dash.xml" \
    -o /tmp/workdir/content/playlist.mpd:dmode=dynamic:segdur=1:cdur=0.2:asto=0.8:cmaf=cmfc:profile=dashif.ll:pssh=mv:utcs=https://time.akamai.com/?iso \
    -graph \
    -logs=all@info

# -o /tmp/workdir/content/playlist.mpd:dmode=dynamic:segdur=1:cdur=0.2:asto=0.8:cmaf=cmfc:profile=dashif.ll:pssh=m:utcs=https://time.akamai.com/?iso \
# -graph
