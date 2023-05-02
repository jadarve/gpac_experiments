gpac -i rtmp://:1935/live:gpac:rtmp_listen=1 \
    reframer:rt=on \
    -o /tmp/workdir/content/playlist.mpd:dmode=dynamic:utcs=https://time.akamai.com/?iso \
    -graph
