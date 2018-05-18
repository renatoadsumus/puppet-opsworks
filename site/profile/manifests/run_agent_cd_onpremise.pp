class profile::run_agent_cd_onpremise {

  ### CRIANDO PASTA PARA ARMAZENAR OS ARTEFATOS GERADOS E SER UM VOLUME PARA DinD
  file{"/opt/agents/pipelines":
		ensure  => "directory",		
	}
	
	::docker::image { 'renatoadsumus/gocd_agent':	
		ensure    => 'present',
		image_tag => 'latest',		
	}  

	
	::docker::run { 'gocd_agent':
		image   => 'renatoadsumus/gocd_agent',		
		volumes => ['/var/run/docker.sock:/var/run/docker.sock','/opt/agents/pipelines:/var/lib/go-agent/pipelines/'],
		require => Docker::Image['renatoadsumus/gocd_agent'],		
	}	


}