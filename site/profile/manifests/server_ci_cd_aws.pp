class profile::server_ci_cd_aws inherits profile::base{	
  
  include profile::install_docker
  
  exec {'gocd_server':
        command  => 'docker run --rm -d -p 8154:8154 --name gocd_server --dns=172.17.32.98 --dns-search=ogmaster.local -v /opt/gocd_server/artifacts/:/var/lib/go-server/artifacts -v /opt/gocd_server/db/:/var/lib/go-server/db renatoadsumus/gocd_server:latest',       	
		path => ['/usr/bin',],
		onlyif  => 'test ! -e /etc/docker/container_gocd_server_execucao.txt',
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
		
		
	#scp -i devopsec2.pem anaconda-post.log ec2-user@18.205.34.123:/home/ec2-user
	### ALTEREI O ESPAÇO AVALIAR ERRO
	#Modify the docker config in /etc/sysconfig/docker-storage to add the line:
	#DOCKER_STORAGE_OPTIONS= - -storage-opt dm.basesize=20G
}



