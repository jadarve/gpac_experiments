gpac -i udp://0.0.0.0:5000/:gpac:listen=true:tsprobe=true \
    reframer:rt=on \
    -o /tmp/workdir/content/playlist.mpd:dmode=dynamic:segdur=1:cdur=0.5:asto=0.8:cmaf=cmfc:profile=dashif.ll:utcs=https://time.akamai.com/?iso \
    -graph
