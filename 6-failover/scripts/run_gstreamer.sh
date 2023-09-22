# gst-launch-1.0 -e \
#     fallbacksrc uri="srt://34.224.246.216:10001?mode=caller" fallback-uri="srt://54.215.51.97:10001?mode=caller" name="decodebin" \
#     decodebin. ! video/x-raw ! queue name="decodebin_video_queue" ! input-selector name=input_selector ! clockoverlay time-format="%T %Z" ! tee name="video_raw_tee" \
#     videotestsrc is-live=true pattern=ball motion=wavy animation-mode=frames foreground-color=0xFF0000 ! "video/x-raw,height=1080,width=1920,framerate=25/1" ! input_selector.sink_1 \
#     decodebin. ! audio/x-raw ! queue name="decodebin_audio_queue" ! tee name="audio_raw_tee" \
#     audio_raw_tee. ! queue name="audio_enc_queue" ! audioconvert ! audioresample ! audio/x-raw ! tee name="audio_resample_tee" \
#     audio_resample_tee. ! queue ! audioconvert ! "audio/x-raw,channels=2" ! avenc_aac name="audio_encoder" ! "audio/mpeg" ! aacparse ! tee name="audio_encoder_tee" \
#     video_raw_tee. ! queue name="video_scale_queue" ! videoscale ! "video/x-raw,height=480,width=854" ! x264enc bitrate=512 byte-stream=true key-int-max=25 bframes=0 aud=true tune=zerolatency pass=cbr speed-p\
# reset=ultrafast threads=4 analyse=i4x4 sliced-threads=true ! "video/x-h264,profile=baseline,stream-format=byte-stream" ! h264parse ! tee name="video_transcoded_enc_tee" \
#     video_transcoded_enc_tee. ! queue name="video_transcoded_queue_mpegts" ! mpegtsmux m2ts-mode=false name="mpegts_mux_transcoded" ! tee name="mpegts_mux_transcoded_tee" \
#     audio_encoder_tee. ! queue ! mpegts_mux_transcoded. \
#     mpegts_mux_transcoded_tee. ! queue ! udpsink host="${UDP_HOST}" port=${UDP_PORT} name="udp_sink_transcoded"

# multiqueue
gst-launch-1.0 -e \
    fallbacksrc uri="srt://34.224.246.216:10001?mode=caller" fallback-uri="srt://54.215.51.97:10001?mode=caller" name="decodebin" \
    decodebin. ! video/x-raw ! multiqueue name="decodebin_multiqueue" ! input-selector name=input_selector ! clockoverlay time-format="%T %Z" ! tee name="video_raw_tee" \
    videotestsrc is-live=true pattern=ball motion=wavy animation-mode=frames foreground-color=0xFF0000 ! "video/x-raw,height=1080,width=1920,framerate=25/1" ! input_selector.sink_1 \
    decodebin. ! audio/x-raw ! decodebin_multiqueue. decodebin_multiqueue. ! tee name="audio_raw_tee" \
    audio_raw_tee. ! queue name="audio_enc_queue" ! audioconvert ! audioresample ! audio/x-raw ! tee name="audio_resample_tee" \
    audio_resample_tee. ! queue ! audioconvert ! "audio/x-raw,channels=2" ! avenc_aac name="audio_encoder" ! "audio/mpeg" ! aacparse ! tee name="audio_encoder_tee" \
    video_raw_tee. ! queue name="video_scale_queue" ! videoscale ! "video/x-raw,height=480,width=854" ! x264enc bitrate=512 byte-stream=true key-int-max=25 bframes=0 aud=true tune=zerolatency pass=cbr speed-p\
reset=ultrafast threads=4 analyse=i4x4 sliced-threads=true ! "video/x-h264,profile=baseline,stream-format=byte-stream" ! h264parse ! tee name="video_transcoded_enc_tee" \
    video_transcoded_enc_tee. ! queue name="video_transcoded_queue_mpegts" ! mpegtsmux m2ts-mode=false name="mpegts_mux_transcoded" ! tee name="mpegts_mux_transcoded_tee" \
    audio_encoder_tee. ! queue ! mpegts_mux_transcoded. \
    mpegts_mux_transcoded_tee. ! queue ! udpsink host="${UDP_HOST}" port=${UDP_PORT} name="udp_sink_transcoded"

# # multiqueue and videorate/audiorate
# gst-launch-1.0 -e \
#     fallbacksrc uri="srt://34.224.246.216:10001?mode=caller" fallback-uri="srt://54.215.51.97:10001?mode=caller" name="decodebin" \
#     decodebin. ! video/x-raw ! multiqueue name="decodebin_multiqueue" ! imagefreeze allow-replace=true is-live=true ! "video/x-raw,framerate=25/1" ! videorate ! "video/x-raw,framerate=25/1" ! input-selector name=input_selector ! clockoverlay time-format="%T %Z" ! tee name="video_raw_tee" \
#     videotestsrc is-live=true pattern=ball motion=wavy animation-mode=frames foreground-color=0xFF0000 ! "video/x-raw,height=1080,width=1920,framerate=25/1" ! input_selector.sink_1 \
#     decodebin. ! audio/x-raw ! decodebin_multiqueue. decodebin_multiqueue. ! audiorate ! "audio/x-raw,rate=44100" ! tee name="audio_raw_tee" \
#     audio_raw_tee. ! queue name="audio_enc_queue" ! audioconvert ! audioresample ! audio/x-raw ! tee name="audio_resample_tee" \
#     audio_resample_tee. ! queue ! audioconvert ! "audio/x-raw,channels=2" ! avenc_aac name="audio_encoder" ! "audio/mpeg" ! aacparse ! tee name="audio_encoder_tee" \
#     video_raw_tee. ! queue name="video_scale_queue" ! videoscale ! "video/x-raw,height=480,width=854" ! x264enc bitrate=512 byte-stream=true key-int-max=25 bframes=0 aud=true tune=zerolatency pass=cbr speed-p\
# reset=ultrafast threads=4 analyse=i4x4 sliced-threads=true ! "video/x-h264,profile=baseline,stream-format=byte-stream" ! h264parse ! tee name="video_transcoded_enc_tee" \
#     video_transcoded_enc_tee. ! queue name="video_transcoded_queue_mpegts" ! mpegtsmux m2ts-mode=false name="mpegts_mux_transcoded" ! tee name="mpegts_mux_transcoded_tee" \
#     audio_encoder_tee. ! queue ! mpegts_mux_transcoded. \
#     mpegts_mux_transcoded_tee. ! queue ! udpsink host="${UDP_HOST}" port=${UDP_PORT} name="udp_sink_transcoded"