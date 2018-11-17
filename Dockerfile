FROM pixpan/steamcmd-wincore

MAINTAINER yamlcase (at) pixpan.com

# Directory for server instance
RUN if not exist "C:\data" mkdir C:\data

# Download Space Engineers Dedicated Server.  For some reason it often fails the first time
RUN powershell $(steamcmd.exe +login anonymous +force_install_dir C:/server/ +app_update 298740 +quit; powershell exit 0)

RUN if not exist "C:\app" mkdir C:\app
COPY app C:/app

CMD powershell.exe c:\app\serverstart.ps1 

EXPOSE 27016/udp
EXPOSE 1973