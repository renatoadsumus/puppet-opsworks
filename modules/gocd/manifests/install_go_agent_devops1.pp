class gocd::install_go_agent_devops1 {

	#service { 'go-agent-devops-1':
		#ensure => running,
		#enable => true,
		#subscribe => [File[
			#"/etc/init.d/go-agent-devops-1",
			#"/usr/share/go-agent-devops-1",
			#"/etc/default/go-agent-devops-1",
			#"/var/log/go-agent-devops-1",
			#"/opt/agents/go-agent-devops-1/config/autoregister.properties",
			#"/opt/agents/go-agent-devops-1/pipelines",
			#"/var/lib/go-agent-devops-1"
			#]],
	#}
	
	## CRIANDO LINK SIMBOLICO SERVICO "GO AGENT DEVOPS - 1"
	file { '/etc/init.d/go-agent-devops-1':
		ensure => 'link',
		target => '/etc/init.d/go-agent',
		force => true,
	}

	file { '/usr/share/go-agent-devops-1':
		ensure => 'link',
		target => '/usr/share/go-agent',
		force => true,
	}

	### COPIA O ARQUIVO DE CONFIGURACAO DO GO AGENT PARA GO AGENT DEVOPS - 1
	file { '/etc/default/go-agent-devops-1':
		ensure => 'file',
		owner => 'tfsservice',
		group => 'suporte',
		#source => "file:///etc/default/go-agent",
	}

	file{ '/var/log/go-agent-devops-1':
		ensure => 'directory',
		recurse => true,
		owner => 'tfsservice',
		group => 'suporte',
	}

	file{ '/opt/agents/go-agent-devops-1':
		ensure => 'directory',
		owner => 'tfsservice',
		group => 'suporte',
	}

	file{ '/opt/agents/go-agent-devops-1/config':
		ensure => 'directory',
		owner => 'tfsservice',
		group => 'suporte',
		require => [File["/opt/agents/go-agent-devops-1"]],
	}
	
	#file {"/opt/agents/go-agent-devops-1/config/autoregister.properties":
	#	ensure   => "file",
	#	owner    => "tfsservice",
	#	group    => "suporte",
	#	content  => "agent.auto.register.key=dde90ab4-f26c-49bc-8dbb-7bf0b29963fd\nagent.auto.register.resources=linux_docker_infodevops2",
	#	require  => [File["/opt/agents/go-agent-devops-1/config"]],
	#}

	## CRIANDO LINK SIMBOLICO CENTRALIZAR WORKINGDIRECTORY ENTRE O AGENT 1 E AGENT 2
	#file { '/opt/agents/go-agent-2/pipelines':
	#	ensure => 'link',
	#	target => '/opt/agents/go-agent/pipelines',
	#	force => true,
	#	require => [File["/opt/agents/go-agent-2"]],
	#}

	## CRIANDO LINK SIMBOLICO PARA A DEFAULT PATH DO "GO AGENT" - EH ULTIMO PASSO
	file { '/var/lib/go-agent-devops-1':
		ensure => 'link',
		target => '/opt/agents/go-agent-devops-1',
		force => true,
		require => [File["/opt/agents/go-agent-devops-1"]],		
	}
	
	file_line {"go_server_url_go_agent_devops_1":
		path => "/etc/default/go-agent-devops-1",
		line => "export GO_SERVER_URL=https://infodevops3.ogmaster.local:8154/go",
		match => "^GO_SERVER_URL.*$",
		require => File['/etc/default/go-agent-devops-1'],
	}
	
	file_line {"agent_work_dir_go_agent_devops_1":
		path => "/etc/default/go-agent-devops-1",
		line => "export AGENT_WORK_DIR=/opt/agents/go-agent-devops-1",
		match => "^AGENT_WORK_DIR.*$",
		require => File['/etc/default/go-agent-devops-1'],
	}
	
	file_line {"java_home_go_agent_devops_1":
		path => "/etc/default/go-agent-devops-1",
		line => "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.161-0.b14.el7_4.x86_64/jre/",
		require => File['/etc/default/go-agent-devops-1'],
	}
	
}


