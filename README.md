## View stream from Docker container
### RTSP (H.264)
`vlc rtsp://127.0.0.1:9950/live/cam_1080.rtsp`
`vlc rtsp://127.0.0.1:9950/live/cam_720.rtsp`
 
### JPG:
`http://127.0.0.1:9951/live/cam_1080_10fps.jpg`
`http://127.0.0.1:9951/live/cam_720_10fps.jpg`

Build docker image:
```
docker build -t restreamer .
```

Run `ffserver -d` inside container:
##### Once
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
##### Forever
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

