Vagrant plugin and puppet manifests for MongoDB
===============================================

Creates one virtual machine (Ubuntu Lucid 10.04, 64-bit) with the following:

 * 1x replica set primary (port 37017)
 * 4x replica set secondaries (ports 37018-21)

Internally, the RS members refer to each other by the common hostname,
`replicaset.local`, and respective port. Forwarding ports are also created on
the host machine, incremented by 100 (i.e. 37117-21).

This allows the user to configure `mongobridge` instances bound to the same
ports that the VM uses internally, to facilitate `mongos` testing. Doing so will
also require that `replicaset.local` resolve to `localhost` on the host
machine.

Usage
-----

Boot up the VM with:

```
$ vagrant up
```

Each time after booting the VM, the RS `mongod` instances must be started:

```
$ vagrant mongo_rs_start
```

The first time `mongod` instances are started (not on successive boots), the RS
must be initialized:

```
$ vagrant mongo_rs_init
```
