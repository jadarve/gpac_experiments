# GPAC Experiments

Experiments on using GPAC https://github.com/gpac/gpac/

## Container build

```bash
docker build -t gpac_experiments:http_origin -f containers/http_origin.dockerfile .
docker build -t gpac_experiments:gstreamer -f containers/gstreamer.dockerfile .
docker build -t gpac_experiments:gpac -f containers/gpac.dockerfile .
docker build -t gpac_experiments:ffmpeg -f containers/ffmpeg.dockerfile .
docker build -t gpac_experiments:srtlivetransmit -f containers/srtlivetransmit.dockerfile .
```

## DRM keys

DRM keys are not published in this repository. Once the keys are generated, they should be placed in each folder that performs an experiment using DRM.

* `drm/index.html`: Add the widevine and playready URLs for the player to download the keys.

```javascript
player.configure({
    drm: {
        servers: {
            // both URLs ar avaiable in the EZDRM XML file.
            // For widevine, it corresponds to the ServerURL element.
            'com.widevine.alpha': '...',

            // For playready, it corresponds to the LAURL element.
            'com.microsoft.playready': '...'
        }
    }
});
```

## Experiments

### GStreamer transcoder + DASH in GPAC

```bash
# from this repo's root
cd 0-dash
docker-compose up
```

It produces errors like:

```
gpac           | Filter ffdmx PID text1 event PLAY but PID is already playing, discarding
gpac           | Filter rfnalu PID video1 processed event ENCODE_HINTS - canceled no
gpac           | Filter rfnalu PID video1 event PLAY but PID is already playing, discarding
gpac           | Filter rfnalu PID video1 processed event ENCODE_HINTS - canceled no
gpac           | Filter rfnalu PID video1 event PLAY but PID is already playing, discarding
gpac           | Filter rfnalu PID video1 processed event ENCODE_HINTS - canceled no
gpac           | Filter rfnalu PID video1 event PLAY but PID is already playing, discarding
gpac           | Filter ufnalu PID video1 processed event ENCODE_HINTS - canceled no
gpac           | Filter ufnalu PID video1 processed event ENCODE_HINTS - canceled no
gpac           | Filter ufnalu PID video1 processed event ENCODE_HINTS - canceled no
gpac           | Filter ffdmx PID video1 processed event ENCODE_HINTS - canceled no
gpac           | Filter ffdmx PID video1 processed event ENCODE_HINTS - canceled no
gpac           | Filter ffdmx PID video1 processed event ENCODE_HINTS - canceled no
gpac           | Filter rfnalu PID video1 property changed at this packet, triggering reconfigure
gpac           | [Dasher] PID video1 config changed during active period, forcing period switch
gpac           | [Dasher] AS-1 Rep 3 segment 1 done 997 ms before UTC due time
gpac           | [Dasher] updated period DID1 duration 0 MPD time 0
gpac           | EOS signaled on PID video1 in filter dasher
gpac           | Segmentation fault (core dumped)
```

then, GPAC segfaults.

### GStreamer transcoder + DASH with DRM in GPAC

```bash
# from this repo's root
cd 1-drm
docker-compose up
```
