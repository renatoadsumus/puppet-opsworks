class profile::run_agent_cd_onpremise {

	::docker::image { 'renatoadsumus/gocd_agent':	
		ensure    => 'present',
		image_tag => 'latest',		
	}  

	
	::docker::run { 'gocd_agent':
		image   => 'renatoadsumus/gocd_agent',		
		volumes => ['/var/run/docker.sock:/var/run/docker.sock','/opt/gocd_agent/pipelines:/var/lib/go-agent/pipelines/'],
		require => Docker::Image['renatoadsumus/gocd_agent'],		
	}	


}