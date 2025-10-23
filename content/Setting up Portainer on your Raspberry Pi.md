
2025-10-13 15:06

Status: #child

Tags: [[RaspberryPi]] [[Docker]] [[Database]] [[Server]] [[BSLI]]

# Setting up Portainer on your Raspberry Pi


Portainer is a web-based container management tool that enables you to easily set up and manage your containers. This guide will show you how you can easily install this management tool and also walk you through how you can use the tool to add your first Docker container to your Raspberry Pi.

Start by making sure your Pi is up to date:
```
sudo apt update
sudo apt upgrade
```

Check that you have Docker installed with
```
docker --version
```

If the response is docker with a version # you are ok to proceed.

Begin by pulling Portainer from the Docker Repository:
```
docker pull portainer/portainer-ce:latest
```

next create a docker volume:
```
docker volume create portainer_data
```

Next, start up docker with the following criteria:
- `-d`**:** This option tells Docker to detach from the command line and run in the background once Portainer is up and running on your Raspberry Pi.
- –`p 8000:8000`**:** This opens up port 8000 from the software. The software uses this for setting up an SSH tunnel between Portainer and its edge agents.
- `-p 9443:9443`**:** With this option, we are exposing port 9443. This particular port is used by Portainers web interface and is the port you will need to use when accing the software.
- `--restart=always`**:** By using this option, you can ensure Docker will automatically restart Portainer if it ever crashes on your Raspberry Pi
- `-v /var/run/docker.sock:/var/run/docker.sock`**:** This mounts your host machines Docker socket so that Portainer can interact with it. This is what Portainer will use to manage your containers.
- `-v portainer_data:/data`**:** With this option we are mapping the named volume we created earlier called “`portainer_data`” to the path “`/data`” within the container.
- `portainer/portainer-ce:latest:` With this final line we tell Docker the image we want to use to launch Portainer on our Pi.
```
docker run -d -p 8000:8000 -p 9443:9443 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
```

Verify that it is running by sending:
```
docker ps
```

Now lets set up the Web inteface

Gather you machines IP Address with:
```
hostname -I
```

Once you have the IP, on your web browser type in the following:
```
https:(IP Address):9443

```

You will be brough to Portainer.IO sign in. If its your first time create the username and password

For this example:
username: piadmin
password: adminadmin123456

This will log you into the Poratainer.io Dashboard. Select Home to view the list the list of docker containers. In the home dashboard select the local environment. 


## References

[[BSLI Raspberry Pi Data Acquisition Server]]

https://www.youtube.com/watch?v=9DfmG9P2wps&t=1s
