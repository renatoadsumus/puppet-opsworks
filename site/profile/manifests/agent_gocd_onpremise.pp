class profile::agent_gocd_onpremise inherits profile::base{		
	
	::docker::image { 'renatoadsumus/gocd_agent':	
		ensure    => 'present',
		image_tag => 'latest',		
	}  

	### CRIANDO AS PASTAS PIPELINE PARA GO-AGENT
  file {[	'/var/lib/go-agent',
			'/var/lib/go-agent/pipelines/',]:
        ensure => 'directory',					
	}
	
	::docker::run { 'gocd_agent':
		image   => 'renatoadsumus/gocd_agent',		
		volumes => ['/var/run/docker.sock:/var/run/docker.sock','/var/lib/go-agent/pipelines/:/var/lib/go-agent/pipelines/'],
		require => Docker::Image['renatoadsumus/gocd_agent'],		
	}	 
	
 
}