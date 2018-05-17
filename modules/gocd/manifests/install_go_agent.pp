class gocd::install_go_agent {

	$source_directory_default_go_agent = "/var/lib/go-agent"
	$target_directory = "/opt/agents/go-agent"	
	
	yumrepo { "gocd":
		enabled  => 1,
		descr    => "GoCD YUM Repository",
		baseurl  => "https://download.gocd.io/",		
		gpgcheck => 1,
		gpgkey => "https://download.gocd.io/GOCD-GPG-KEY.asc",
	}

	package{"go-agent":
		ensure  => present,
		require => [Yumrepo["gocd"]],
	}

	#service { "go-agent":
	#	ensure  => running,
	#	enable  => true,
	#	require => [Exec['movendo_go_agent_para_opt'], File_line['go_server_url_go_agent', 'agent_work_dir_go_agent', 'java_home_go_agent'], File['/etc/init.d/go-agent', '/opt/agents/go-agent']],
	#}	
	
	exec{"movendo_go_agent_para_opt":
		command => "mv ${source_directory_default_go_agent} ${target_directory}",
		user    => "root",
		path    => "/usr/bin",
		require => [File["/opt/agents/"]],
		unless  =>  "ls ${target_directory}/config",
	}
	
	### CRIANDO LINK SIMBOLICO PARA A DEFAULT PATH DO "GO AGENT"
	file {"${source_directory_default_go_agent}":
		ensure  => "link",
		target  => "${target_directory}",
		force   => true,
		require => Exec['movendo_go_agent_para_opt'],
	}
	
	### ALTERAR A PROPRIEDADE /VAR/LOG/GO-AGENT
	file {"/var/log/go-agent":
		ensure => "directory",
		owner  => "tfsservice",
		group  => "suporte",
		require => Package['go-agent'],
	}
	
	### ALTERAR A PROPRIEDADE /VAR/RUN/GO-AGENT
	file {"/var/run/go-agent":
		ensure => "directory",
		owner  => "tfsservice",
		group  => "suporte",
		require => Package['go-agent'],
	}
	
	file_line {"go_server_url_go_agent":
		path => "/etc/default/go-agent",
		line => "export GO_SERVER_URL=https://infogocd.ogmaster.local:8154/go",
		match => "^GO_SERVER_URL.*$",
		require => Package['go-agent'],
	}
	
	file_line {"agent_work_dir_go_agent":
		path => "/etc/default/go-agent",
		line => "export AGENT_WORK_DIR=/opt/agents/go-agent",
		match => "^AGENT_WORK_DIR.*$",
		require => Package['go-agent'],
	}
	
	file_line {"java_home_go_agent":
		path => "/etc/default/go-agent",
		line => "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.161-0.b14.el7_4.x86_64/jre/",
		require => Package['go-agent'],
	}
	
	### SOBRESCREVER ARQUIVO GO-AGENT DO PUPPET SERVER PARA /etc/init.d/go-agent - NECESSARIO POR CAUSA DO "GO AGENT" CUSTOMIZADO PARA INICIAR COM TFSSERVICE
	file { "/etc/init.d/go-agent":
		ensure  => "file",
		owner   => "root",
		group   => "root",
		replace => true,
		source  => "puppet://infodevops1.ogmaster.local/modules/gocd/go-agent",
		require => [Package["go-agent"]],
	}

	### ALTERAR PERMISSAO /ETC/DEFAULT/GO_AGENT
	file {"/etc/default/go-agent":
		#ensure => "file",
		ensure => "file",
		mode   => "0644",
		require => Package['go-agent'],
	}
	
	file{"${target_directory}":
		ensure  => "directory",
		owner   => "tfsservice",
		group   => "suporte",
		recurse => true,
		#source  => "file://${source_directory_default_go_agent}",
		require => [Exec["movendo_go_agent_para_opt"]],
	}

	file {"${target_directory}/config/autoregister.properties":
		ensure  => "file",
		owner   => "tfsservice",
		group   => "suporte",
		content => "agent.auto.register.key=dde90ab4-f26c-49bc-8dbb-7bf0b29963fd\nagent.auto.register.resources=linux_docker_infodevops2",
		require => [File["${target_directory}"]],
	}

	### SOBRESCREVER ARQUIVO /etc/default/go-agent - NECESSARIO CONFIGURAR AS VARIAVEIS: AGENT_WORK_DIR, JAVA_HOME E GO_SERVER_URL COM "https://infogocd.ogmaster.local:8154/go"
	#file { "/etc/default/go-agent":
	#	ensure  => "file",
	#	owner   => "root",
	#	group   => "go",
	#	replace => true,
	#	mode   => "0644",
	#	#source  => "puppet://infodevops1.ogmaster.local/modules/gocd/default-go-agent",
	#	require => [Package["go-agent"]],
	#}
	
}

#MULTIPLOS AGENT
#https://docs.gocd.org/15.1.0/advanced_usage/admin_install_multiple_agents.html

### LER SOBRE ORDEM
#https://docs.puppet.com/puppet/5.1/lang_relationships.html#ordering

#### REMOVER DO SERVIDOR
# unlink /var/lib/go-agent
# rm -fr /var/lib/go-agent-2
# rm -fr /opt/agents
# rm -fr /var/log/check_go_agent_install.txt
# rm -fr /var/log/go-agent/
# rm -fr /etc/init.d/go-agent/
# rm -fr /etc/init.d/go-agent-2
# rm -fr /usr/share/go-agent*
# rm -fr /etc/default/go-agent*
# yum remove go-agent
