class profile::server_ci_cd_onpremise inherits profile::base{		
	
	
	file{ '/etc/docker/':
        ensure  => 'directory',
        #require => Package['docker-ce'],
    }
	
	### ALTERANDO O CAMINHO DEFAULT DOCKER PARA OPT
	file {'daemon.json':
        ensure => 'file',
        path => '/etc/docker/daemon.json',
        content => '{"graph":"/opt/docker/","storage-driver":"overlay","disable-legacy-registry": true}',
		require  => File['/etc/docker'],
       
    }
	
	::docker::image { 'renatoadsumus/gocd_server':	
		ensure    => 'present',
		image_tag => 'latest',		
	}  


	::docker::image { 'renatoadsumus/mongodb':	
		ensure    => 'present',
		image_tag => 'latest',		
	} 
	
	::docker::run { 'gocd_server':
		image   => 'renatoadsumus/gocd_server:latest',
		ports   => ['8153:8153','8154:8154'],
		volumes => ['/opt/gocd_server/artifacts/:/var/lib/go-server/artifacts', '/opt/gocd_server/db/:/var/lib/go-server/db'],
		require => Docker::Image['renatoadsumus/gocd_server'],
		
	}
		
	::docker::run { 'mongodb':
		image   => 'renatoadsumus/mongodb:latest',
		ports   => ['27017:27017'],
		require => Docker::Image['renatoadsumus/mongodb'],
  }  
  
 
}