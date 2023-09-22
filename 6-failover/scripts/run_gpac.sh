gpac -i udp://0.0.0.0:5000/:gpac:listen=true:tsprobe=true \
    @0 reframer:rt=on \
    @0 ffenc:c=avc \
    @1 ffenc:c=aac \
    @0 @1 -o /tmp/workdir/content/playlist.mpd:dmode=dynamic:segdur=2:cmaf=cmfc:profile=live \
    -graph \
    -logs=all@warning

# -o /tmp/workdir/content/playlist.mpd:dmode=dynamic:segdur=1:cdur=0.2:asto=0.8:cmaf=cmfc:profile=dashif.ll:pssh=m:utcs=https://time.akamai.com/?iso \
# -graph
# imagefreeze allow-replace=true is-live=true