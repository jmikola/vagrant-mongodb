class mongodb {

    exec { "get-mongodb":
        path => "/bin:/usr/bin",
        cwd => "/home/vagrant",
        command => "wget http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-2.2.0-rc0.tgz",
        unless => "test -f mongodb-linux-x86_64-2.2.0-rc0.tgz",
    }

    exec { "unpack-mongodb":
        path => "/bin:/usr/bin",
        cwd => "/home/vagrant",
        command => "tar xzf mongodb-linux-x86_64-2.2.0-rc0.tgz",
        unless => "test -d mongodb-linux-x86_64-2.2.0-rc0",
        require => Exec["get-mongodb"],
    }

    exec { "install-mongodb":
        path => "/bin:/usr/bin",
        cwd => "/home/vagrant",
        command => "cp -a mongodb-linux-x86_64-2.2.0-rc0/bin/* /usr/bin",
        require => Exec["unpack-mongodb"],
    }

    file { "/data":
        ensure => directory,
        mode   => 777,
    }

    file { "/data/db":
        ensure => directory,
        mode   => 777,
        require => File["/data"],
    }

}
