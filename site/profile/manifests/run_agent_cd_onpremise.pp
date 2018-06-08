class profile::run_agent_cd_onpremise {

#### ALTERANDO PERMISSAO  /var/run/docker.sock PARA RODAR DinD

	file{"/var/run/docker.sock/":		
		mode => "666",
	}
	
	
  ### CRIANDO PASTA PARA ARMAZENAR OS ARTEFATOS GERADOS E SER UM VOLUME PARA DinD
  file{"/opt/agents/pipelines":
		ensure  => "directory",
		owner => "go",
		group => "go",
	}
	
	::docker::image { 'renatoadsumus/gocd_agent':	
		ensure    => 'present',
		image_tag => 'latest',		
	}  

	
	::docker::run { 'gocd_agent1':
		image   => 'renatoadsumus/gocd_agent',		
		volumes => ['/var/run/docker.sock:/var/run/docker.sock','/opt/agents/pipelines:/var/lib/go-agent/pipelines/','/opt/scripts_cd:/opt/scripts_cd'],
		require => Docker::Image['renatoadsumus/gocd_agent'],		
	}	
	
	::docker::run { 'gocd_agent2':
		image   => 'renatoadsumus/gocd_agent',		
		volumes => ['/var/run/docker.sock:/var/run/docker.sock','/opt/agents/pipelines:/var/lib/go-agent/pipelines/','/opt/scripts_cd:/opt/scripts_cd'],
		require => Docker::Image['renatoadsumus/gocd_agent'],		
	}


}