## Space Engineers on Docker
[![Build Status](https://travis-ci.com/yamlCase/docker-space-engineers.svg?branch=master)](https://travis-ci.com/yamlCase/docker-space-engineers)
[![GitHub issues](https://img.shields.io/github/issues/yamlCase/docker-space-engineers.svg)](https://github.com/yamlCase/docker-space-engineers/issues)



PixPan Studios presents Space Engineers on Docker.  It utilizes the [microsoft/windowsservercore:1803](https://hub.docker.com/r/microsoft/windowsservercore/) windows container image.  

## Usage

If there is a new Space Engineers server release, simply redeploy the container.
```
docker run \
    -t \
    -i \
    -d \
    -p 27016:27016/udp \
    -p 1973:1973 \
    -v <C:/path/to/server-instance>:C:/data \
    pixpan/space-engineers
```

- Port 1973 is the default port for remote API.
- Port 27016 is the default server port and must be UDP.
- C:\data\ on the container is for saves.

### Data Folder



## Structure

This image is designed to self-update both SteamCMD and Space Engineers everytime a container is created or started.  This is a departure from the "Docker Way", however is necessary due to a current lack of visibility for updates.

## Automated Build
This automated build is done on Travis-CI as it is (currently) the only free-to-use Open Source platform that supports Windows build machines.  If you wish to fork this project, be sure to create `$docker_username` and `$docker_password` on Travis as secret environment variables.