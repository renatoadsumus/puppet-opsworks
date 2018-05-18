class jenkins::install_jenkins_slave {

	$nome_exibicao_slave = "globo_extra"
	$nome_servico = "jenkins_slave_puppet_ge"
	$arquivo_servico = "/etc/init.d/$nome_servico"
	$path_slaves = "/opt/slaves_jenkins"

	file{"$path_slaves":
		ensure  => "directory",
		owner   => "jenkins",
		group   => "jenkins",
		mode    => "0755",
		require => [Group["jenkins"],User["jenkins"]],
	}

	exec{"download_plugin_swarm":
		command => "curl -k https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/3.3/swarm-client-3.3.jar -o ${path_slaves}/swarm-client.jar",
		user    => "root",
		path    => "/usr/bin",
		require  => [File["${path_slaves}"]],
		unless  => "ls ${path_slaves}/swarm-client.jar",
	}
	
	### CRIAR PATH /opt/slaves_jenkins/${nome_exibicao_slave}
	file{"${path_slaves}/${nome_exibicao_slave}":
		ensure  => "directory",
		owner   => "jenkins",
		group   => "jenkins",
		mode    => "0755",
		require => [File["${path_slaves}"]],
	}

	### PEGAR ARQUIVO DO SERVER "service_slave_template" PARA $arquivo_servico - START JAR COMO SERVICO
	file{"${arquivo_servico}":
		ensure  => "file",
		owner   => "jenkins",
		group   => "jenkins",
		mode    => "0755",
		source  => "puppet://infodevops1.ogmaster.local/modules/jenkins/service_slave_template",
	}

	### ALTERAR O TEXTO NOME_SLAVE PELO VALOR DA VARIAVEL $nome_exibicao_slave - START JAR COMO SERVICO
	exec{"alterando_nome_exibicao_slave":
		command => "sed -i 's/NOME_SLAVE/${nome_exibicao_slave}/' ${arquivo_servico}",
		user    => "root",
		path    => "/usr/bin",
		require => [File["${arquivo_servico}"]],
		unless  =>  "grep ${nome_exibicao_slave} ${arquivo_servico}",
	} 
	
	service {"${nome_servico}":
		ensure    => running,
		enable    => true,
		subscribe => [Exec["alterando_nome_exibicao_slave"]],
	}	
	
	### CRIANDO NOVA PASTA PARA VOLUMES DE REPOSITORIOS MAVEN E GRAILS DEVIDO A PROBLEMAS DE PERMISSIONAMENTO DAS IMAGENS DOCKER COM JENKINS
	file { ["/opt/repositories_jenkins/","/opt/repositories_jenkins/maven","/opt/repositories_jenkins/grails"]:
		ensure => "directory",
		owner  => "jenkins",
		group  => "jenkins",
	}
}
