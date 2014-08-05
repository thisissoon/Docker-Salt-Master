Docker Salt-Master
==================

A Docker image which allows you to run a containerised Salt-Master server.

Running the Container
---------------------

You can easily run the container like so:

.. sourcecode::

    docker run --rm -it soon/salt-master

Environment Variables
---------------------

The following environment variables can be set:

* ``LOG_LEVEL``: The level to log at, defaults to ``error``

Volumes
-------

There are several volumes which can be mounted to Docker data container as
described here: https://docs.docker.com/userguide/dockervolumes/. The following
volumes can be mounted:

* ``/etc/salt/pki``
* ``/var/cache/salt``
* ``/var/logs/salt``
* ``/etc/salt/master.d``
* ``/srv/salt``

``/etc/salt/pki``
~~~~~~~~~~~~~~~~~

This directory holds minion authentication keys, for more than one docker
container to operate on the minions you will need to share this directory.

``/var/cache/salt``
~~~~~~~~~~~~~~~~~~~

This directory holds Salt cached data relating to jobs and minion data.

``/etc/salt/master.d``
~~~~~~~~~~~~~~~~~~~~~~

Here you can place your own Salt Master configuration file.

``/srv/salt``
~~~~~~~~~~~~~

This diretory holds your states, pillars and modules.

Data Container
--------------

To create a data container you are going to want the thinnest possible docker
image, simply run this docker command, which will download the simplest possible
docker image:

.. sourcecode::

    docker run -v /etc/salt/pki -v /var/salt/cache -v /var/logs/salt -v /etc/salt/master.d -v /srv/salt --name salt-master-data busybox true

This will create a stopped container wwith the name of ``salt-master-data`` and
will hold our persistant salt master data. Now we just need to run our master
container with the ``--volumes-from`` command:

.. sourcecode::

    docker run --rm -it --volume-from salt-master-data soon/salt-master

Sharing Local Folders
~~~~~~~~~~~~~~~~~~~~~

To share folders on your local system so you can have your own master
configuration, states, pillars etc just alter the ``salt-master-data``
command:

.. sourcecode::

    docker run -v /etc/salt/pki -v /var/salt/cache -v /var/logs/salt -v /path/to/local:/etc/salt/master.d -v /path/to/local:/srv/salt --name salt-master-data busybox true

Now ``/path/to/local`` can hold your states and master configuration.

Ports
-----

The following ports are exposed:

* ``4505``
* ``4506``

These ports allow minions to communicate with the Salt Master.
