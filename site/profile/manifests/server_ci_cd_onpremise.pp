class profile::server_ci_cd_onpremise inherits profile::base{		
	
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