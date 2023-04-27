
## Container build

Run the following commands from this directory:

```bash
docker build -t gstreamer_drm:http_origin -f containers/http_origin.dockerfile .
docker build -t gstreamer_drm:gstreamer -f containers/gstreamer.dockerfile .
docker build -t gstreamer_drm:gpac -f containers/gpac.dockerfile .
```

## Run the docker-compose

```bash
docker-compose up
```

You should be able to open http://localhost:8080/ and see the video player.