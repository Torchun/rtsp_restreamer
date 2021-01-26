# Get started

## View stream from Docker container
### RTSP (H.264)
##### 1080p
 - vlc rtsp://127.0.0.1:9950/live/cam_1080.rtsp
##### 720p
 - vlc rtsp://127.0.0.1:9950/live/cam_720.rtsp
 
### JPG:
##### 1080p
 - http://127.0.0.1:9951/live/cam_1080_10fps.jpg
##### 720p
 - http://127.0.0.1:9951/live/cam_720_10fps.jpg

Build docker image:
```
docker build -t restreamer .
```

Run `ffserver -d` inside container:
##### ONCE
```
docker run --rm -it \
  --cap-add=NET_ADMIN \
  --device /dev/net/tun \
  --name=restreamer \
  -p 9950:9950 \
  -p 9951:9951 \
  --sysctl net.ipv6.conf.all.disable_ipv6=0 \
  -v /full/path/to/ffserver.conf:/etc/ffserver.conf \
  restreamer:latest /bin/bash
```
##### FOREVER
```
docker run \
  -d --restart=always \
  --cap-add=NET_ADMIN \
  --device /dev/net/tun \
  --name=restreamer \
  -p 9950:9950 \
  -p 9951:9951 \
  --sysctl net.ipv6.conf.all.disable_ipv6=0 \
  -v <host_path>:<container_path> 
  restreamer:latest /bin/bash
```

