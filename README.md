# Docker Salt-Master

A Docker image which allows you to run a containerised Salt-Master server.

## Running the Container

You can easily run the container like so:

    docker run --rm -it soon/salt-master

## Environment Variables

The following environment variables can be set:

* `LOG_LEVEL`: The level to log at, defaults to `error`

## Volumes

There are several volumes which can be mounted to Docker data container as
described here: https://docs.docker.com/userguide/dockervolumes/. The following
volumes can be mounted:

 * `/etc/salt/pki` - This holds the Salt Minion authentication keys
 * `/var/cache/salt` - Job and Minion data cache
 * `/var/logs/salt` - Salts log directory
 * `/etc/salt/master.d` - Master configuration include directory
 * `/srv/salt` - Holds your states, pillars etc

### Data Container

To create a data container you are going to want the thinnest possible docker
image, simply run this docker command, which will download the simplest possible
docker image:

    docker run -v /etc/salt/pki -v /var/salt/cache -v /var/logs/salt -v /etc/salt/master.d -v /srv/salt --name salt-master-data busybox true

This will create a stopped container wwith the name of `salt-master-data` and
will hold our persistant salt master data. Now we just need to run our master
container with the `--volumes-from` command:

    docker run --rm -it --volumes-from salt-master-data soon/salt-master

### Sharing Local Folders

To share folders on your local system so you can have your own master
configuration, states, pillars etc just alter the `salt-master-data`
command:

    docker run -v /etc/salt/pki -v /var/salt/cache -v /var/logs/salt -v /path/to/local:/etc/salt/master.d -v /path/to/local:/srv/salt --name salt-master-data busybox true

Now `/path/to/local` can hold your states and master configuration.

## Ports

The following ports are exposed:

 * `4505`
 * `4506`

These ports allow minions to communicate with the Salt Master.

## Running Salt Commands

Docker will hopefully soon ship with a `docker exec` command which will allow you to run commands in a running container.
See this pull request: https://github.com/docker/docker/pull/7409.

But until then you will need to run another docker container which runs a program called `nsenter` which allows
you to connect to running containers. Follow the instructions here: https://github.com/jpetazzo/nsenter

Once installed run:

    $ CONTAINER_ID=$(docker run -d soon/salt-master)
    $ docker-enter $CONTAINER_ID
    $ root@CONTAINER_ID:~# salt '*' test.ping
    $ root@CONTAINER_ID:~# salt '*' grains.items
