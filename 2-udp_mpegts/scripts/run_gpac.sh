gpac -i udp://0.0.0.0:5000/:gpac:listen=true:tsprobe=true \
    reframer:rt=on \
    -o /tmp/workdir/content/playlist.mpd:dmode=dynamic:utcs=https://time.akamai.com/?iso \
    -graph
