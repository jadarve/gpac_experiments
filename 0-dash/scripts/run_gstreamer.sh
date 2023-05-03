gst-launch-1.0 -e \
    videotestsrc ! "video/x-raw,height=720,width=1280,framerate=25/1" ! clockoverlay ! queue ! tee name=video_raw_tee \
    audiotestsrc wave=ticks apply-tick-ramp=true tick-interval=100000000 freq=10000 volume=0.4 marker-tick-period=10 sine-periods-per-tick=20 ! queue ! tee name=audio_raw_tee \
    \
    video_raw_tee. ! queue name=video_scale_queue ! videoscale ! video/x-raw,height=240,width=360 ! tee name=video_scale_tee \
    \
    video_scale_tee. ! queue name=video_transcode_enc_queue ! videoconvert ! "video/x-raw,format=I420" ! \
        x264enc bitrate=2000 byte-stream=true key-int-max=25 bframes=0 aud=true tune=zerolatency pass=cbr ! \
        "video/x-h264,profile=baseline,stream-format=avc" ! h264parse config-interval=-1 ! tee name=video_transcoded_enc_tee \
    \
    audio_raw_tee. ! queue name=audio_enc_queue ! audioresample ! "audio/x-raw,rate=44100" ! tee name=audio_resample_tee \
    audio_resample_tee. ! queue ! audioconvert ! "audio/x-raw,channels=2" ! avenc_aac name=audio_encoder ! "audio/mpeg" ! aacparse ! tee name=audio_encoder_tee \
    \
    video_transcoded_enc_tee. ! queue name=video_transcoded_queue ! flvmux streamable=true name=flv_mux_transcoded ! tee name=flv_mux_transcoded_tee \
    audio_encoder_tee. ! queue ! flv_mux_transcoded. \
    \
    flv_mux_transcoded_tee. ! queue ! rtmpsink location="${PUSH_URL} live=1" name=rtmp_sink_transcoded
