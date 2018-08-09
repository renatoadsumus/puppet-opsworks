class profile::run_server_cd_aws {

include docker::install_docker
  
### MOUNT VOLUME AWS - vol-02b4b672a6a1a8bbf - umount /opt/gocd_server_volume
	file{ '/opt/gocd_server_volume/':
        ensure  => 'directory',        
    }

	#mount { 'montando_volume_aws_artefato_go_cd':
		#name => '/opt/gocd_server_volume',
		#device => '/dev/xvdf',
		#fstype => 'ext4',
		#remounts => false,
		#ensure => 'mounted',
	#}
   


  ### MATANDO TODOS OS CONTAINERS CASO NAO EXISTA O ARQUIVO "container_gocd_server_execucao.TXT"
	exec {'removendo_todos_containers':
        command  => 'docker kill $(docker ps -q)',       	
		path => ['/usr/bin',],
		onlyif  => 'test ! -e /etc/docker/container_gocd_server_execucao.txt',
    }
	
	
	exec {'gocd_server':
        command  => 'docker run --rm -d -p 8154:8154 --dns=172.17.32.98 --dns-search=ogmaster.local -v /opt/gocd_server/cruise-config.xml:/etc/go/cruise-config.xml -v /opt/gocd_server/db/:/var/lib/go-server/db renatoadsumus/gocd_server:latest',       	
		path => ['/usr/bin',],
		onlyif  => 'test ! -e /etc/docker/container_gocd_server_execucao.txt',
		
		#-v /opt/gocd_server/artifacts/:/var/lib/go-server/artifacts   
    }
	
	
	exec {'mongodb':
        command  => 'docker run --rm -d -p 27017:27017 --dns=172.17.32.98 --dns-search=ogmaster.local renatoadsumus/mongodb:latest',       	
		path => ['/usr/bin',],
		onlyif  => 'test ! -e /etc/docker/container_gocd_server_execucao.txt',
    }
	

	### CRIANDO ESSE ARQUIVO PARA NAO RODAR "DOCKER RUN..." TODA VEZ QUE FOR PROVISIONADO A INSTANCIA
	file {'container_gocd_server_execucao':
        ensure => 'file',
        path => '/etc/docker/container_gocd_server_execucao.txt',
        content => 'Container com GO SERVER em execucao',  
		require => [Exec['gocd_server','mongodb']],
	}

}