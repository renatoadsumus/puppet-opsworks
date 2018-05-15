class profile::run_agent_cd_aws {

	include profile::install_docker
  
	  exec {'gocd_agent':
			command  => 'docker run --rm -d -v /var/run/docker.sock:/var/run/docker.sock --add-host=infodevops3:172.17.37.109 -v /opt/gocd_agent/pipelines:/var/lib/go-agent/pipelines/ --dns=172.17.32.98 --dns-search=ogmaster.local renatoadsumus/gocd_agent:latest',       	
			path => ['/usr/bin',],
			onlyif  => 'test ! -e /etc/docker/container_gocd_agent_execucao.txt',
		}
		
		file {'container_gocd_agent_execucao':
			ensure => 'file',
			path => '/etc/docker/container_gocd_agent_execucao.txt',
			content => 'Container com GO AGENT em execucao',  
			require => [Exec['gocd_agent']],
		}


}