class profile::agent_gocd_onpremise inherits profile::base{		
	
	group { 'go':
  			  ensure => 'present',
  			  gid    => '2000',
     }	
	 
	user { 'go':
		  ensure  => 'present',
		  comment => 'GO User',		 
		  groups  => ['go','suporte'],		
		  shell   => '/bin/bash',
		  uid     => '2001',
	}


	::docker::image { 'renatoadsumus/gocd_agent':	
		ensure    => 'present',
		image_tag => 'latest',		
	}  

	### CRIANDO AS PASTAS PIPELINE PARA GO-AGENT
  file {[	'/opt/gocd_agent/',
			'/opt/gocd_agent/pipelines/',]:
        ensure => 'directory',				
	}
	
	::docker::run { 'gocd_agent':
		image   => 'renatoadsumus/gocd_agent',		
		volumes => ['/var/run/docker.sock:/var/run/docker.sock','/opt/gocd_agent/pipelines/:/var/lib/go-agent/pipelines/'],
		require => Docker::Image['renatoadsumus/gocd_agent'],		
	}	 
 
}