class profile::agent_gocd_aws inherits profile::base{		
	
	include profile::install_docker
  
  exec {'gocd_agent':
        command  => 'docker run --rm -d --name gocd_agent --add-host=infodevops3:172.17.37.109 --dns=172.17.32.98 --dns-search=ogmaster.local renatoadsumus/gocd_agent:latest',       	
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