class profile::agent_gocd_onpremise inherits profile::base{		
	
	::docker::image { 'renatoadsumus/gocd_agent':	
		ensure    => 'present',
		image_tag => 'latest',		
	}  

	
	::docker::run { 'gocd_agent':
		image   => 'renatoadsumus/gocd_agent',		
		volumes => ['/var/run/docker.sock:/var/run/docker.sock'],
		require => Docker::Image['renatoadsumus/gocd_agent'],		
	}	 
}