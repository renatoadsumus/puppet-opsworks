class profile::agent_gocd_onpremise inherits profile::base{		
	
	::docker::image { 'renatoadsumus/gocd_agent':	
		ensure    => 'present',
		image_tag => 'latest',		
	}  

	
	::docker::run { 'gocd_agent':
		image   => 'renatoadsumus/gocd_agent',		
		require => Docker::Image['renatoadsumus/gocd_agent'],		
	}	 
}