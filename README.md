## Space Engineers on Docker
[![Build Status](https://travis-ci.com/yamlCase/docker-space-engineers.svg?branch=master)](https://travis-ci.com/yamlCase/docker-space-engineers)[![GitHub issues](https://img.shields.io/github/issues/yamlCase/docker-space-engineers.svg)](https://github.com/yamlCase/docker-space-engineers/issues)



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
</br>

- Port 1973 is the default port for remote API.
- Port 27016 is the default server port and must be UDP.
- C:\data\ on the container is for saves.

### New Scenario
Create a `SpaceEngineers-Dedicated.cfg` file with the `SpaceEngineersDedicated.exe` console program.

### Import Save
Copy the `Saves` directory into `C:\data`.  Edit the `LastSession.sbl` document and change the `<Path>c:\path\to\save</Path>` to take into account the new folder structure.

### Save and Exit Gracefully
Unfortunately the VRage remote client doesn't have a save or quit feature.  you will need to execute the following command on the docker container to prompt a save:

```
C:\> taskkill /IM SpaceEngineersDedicated.exe
```
If this command fails to stop the server, you will just need to wait for the autosave time to pass and then stop the container normally.

### Orchestration Notes
If you're running this container in a Kubernetes pod or some other orchestration engine, Change the Upgrade Policy to `stop old pods, then start new`.  Scaling, HA and FT have not been tested and are not likely a focus for Keen SWH development efforts. 

### More Info
For more information on Space Engineers Dedicated Servers, visit: https://www.spaceengineersgame.com/dedicated-servers.html

## Structure

This image is designed to self-update both SteamCMD and Space Engineers everytime a container is created or started.  This is a departure from the "Docker Way", however is necessary due to a current lack of visibility for updates.

## Limitations

Space Engineers is still in a beta state.  There will be rapid development on the Dedicated Server experience, but for now make note of the current limitations:

- There is no way to manually save your data at this time.  Be sure you exit gracefully (see above)
- SEDS Console runs in a new console that cannot be captured.  The rolling logs you see are exactly that, the log file being tailed.
- There is no way to create a new scenario from the console.  You must create it with a local copy of `SpaceEngineersDedicated.exe` and save the config file as `SpaceEngineers-Dedicated.cfg` to the `C:\data` folder.

## Automated Build
This automated build is done on Travis-CI as it is (currently) the only free-to-use Open Source platform that supports Windows build machines.  If you wish to fork this project, be sure to create `$docker_username` and `$docker_password` on Travis as secret environment variables.