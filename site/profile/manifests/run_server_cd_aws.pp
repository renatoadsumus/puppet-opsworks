class profile::run_server_cd_aws {

include profile::install_docker
  
  exec {'gocd_server':
        command  => 'docker run --rm -d -p 8154:8154 --name gocd_server --dns=172.17.32.98 --dns-search=ogmaster.local -v /opt/gocd_server/artifacts/:/var/lib/go-server/artifacts -v /opt/gocd_server/db/:/var/lib/go-server/db  renatoadsumus/gocd_server:latest',       	
		path => ['/usr/bin',],
		onlyif  => 'test ! -e /etc/docker/container_gocd_server_execucao.txt',
		#-v /opt/gocd_server/cruise-config.xml:/etc/go/cruise-config.xml
    }
	
	exec {'mongodb':
        command  => 'docker run --rm -d -p 27017:27017 --name mongodb --dns=172.17.32.98 --dns-search=ogmaster.local renatoadsumus/gocd_server:latest',       	
		path => ['/usr/bin',],
		onlyif  => 'test ! -e /etc/docker/container_gocd_server_execucao.txt',
    }
	
	file {'container_gocd_server_execucao':
        ensure => 'file',
        path => '/etc/docker/container_gocd_server_execucao.txt',
        content => 'Container com GO SERVER em execucao',  
		require => [Exec['gocd_server','mongodb']],
	}

}