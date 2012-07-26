require 'vagrant'

class MongoRsStartCommand < Vagrant::Command::Base
    def execute
        env = Vagrant::Environment.new
        env.primary_vm.channel.sudo("ulimit -n 20000")
        (37017..37021).each do |p|
            env.primary_vm.channel.execute("mkdir -p /data/db/#{p}")
            env.primary_vm.channel.execute("mongod --port #{p} --replSet rs --dbpath /data/db/#{p} --nojournal --noprealloc --logpath /tmp/mongod.#{p}.log --fork")
        end
    end
end

class MongoRsInitCommand < Vagrant::Command::Base
    def execute
        env = Vagrant::Environment.new
        raise "Must run `vagrant up`" if !env.primary_vm.created?
        raise "Must be running!" if env.primary_vm.state != :running
        primaryPort = 37017
        env.primary_vm.channel.execute("mongo --port #{primaryPort} --eval 'rs.initiate()'")
        env.primary_vm.channel.execute("mongo --port #{primaryPort} --eval 'while (!db.isMaster().ismaster);'")
        (37018..37021).each do |p|
            env.primary_vm.channel.execute("mongo --port #{primaryPort} --eval 'rs.add(\"replicaset.local:#{p}\")'")
        end
    end
end

Vagrant.commands.register(:mongo_rs_start) { MongoRsStartCommand }
Vagrant.commands.register(:mongo_rs_init) { MongoRsInitCommand }
