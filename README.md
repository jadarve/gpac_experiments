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
