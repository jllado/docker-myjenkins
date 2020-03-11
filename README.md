This a pre-configured jenkins image (with a set of predefined plugins). No additional jenkins plugins or linux packages is needed from the start.

### Installed Packages
Below packages are pre-installed:
- Java 11 JDK
- Git
- Docker


#### Docker *by* Docker
Finally, we want our image to able to build docker images. Instead of using [docker in docker](https://github.com/jpetazzo/dind) we can mount the unix socket file of the host docker deamon to this container, and build our images there. You can read more about how to access host docker, and why it is better than "docker in docker" in [this blog post](http://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/).

### Running

Build and run the image:
```language-bash
./install.sh
```

or you can stop and remove the image:
```language-bash
./uninstall.sh
```
By default, this will store image data in `/opt/servers/jenkins`directory of the host.

### Plugins

You can check jenkis plugin list from the following url:
https://docs.cloudbees.com/plugins

