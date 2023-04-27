FROM python:3.10-alpine
LABEL MAINTAINER="GeniusLive"

WORKDIR /tmp/workdir

RUN mkdir -p /tmp/workdir/content

# CMD ["python3". "-m", "http.server", "8080"]

