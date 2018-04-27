class profile::docker_container_onpremise inherits profile::base{		
	
	::docker::image { 'renatoadsumus/gocd':	
		ensure    => 'present',
		image_tag => 'latest',		
	}  	
	
	::docker::run { 'gocd_server':
		image   => 'renatoadsumus/gocd:latest',
		ports   => ['8153:8153','8154:8154'],
		require => Docker::Image['renatoadsumus/gocd'],
  }  
 
}