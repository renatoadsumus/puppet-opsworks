class profile::agent_cd ( $user_local = "go", $group_local = "go" ){

#### DEFAULT USUARIO GO, NECESSIDADE QUANDO EXECUTAMOS O AGENT EM CONTAINER, PARA QUE O CONTAINER POSSA TER ACESSO NAS PASTAS DOS VOLUMES NO HOST, A COMUNNICAO ENTRE CONTAINER GO-AGENT E HOST É ATRAVES USUARIO "GO" SE O AGENT ESTIVER INSTALADO SERA RECEBIDO PELA CLASSE O USUARIO TFSSERVICE

notify{ " Colocando nas pastas para Usuario...:  ${$user_local} a Grupo...: ${$user_local}": }
	
### CRIANDO NOVA PASTA PARA VOLUMES DE REPOSITORIOS MAVEN E GRAILS DEVIDO A PROBLEMAS DE PERMISSIONAMENTO DAS IMAGENS DOCKER COM GO
	file { ["/opt/repositories/",
			"/opt/repositories/maven",
			"/opt/repositories/grails",
			"/opt/repositories/gradle"]:
		ensure => "directory",
		owner  => "${user_local}",
		group  => "${group_local}",
	}
	
### CRIANDO A PASTA ARA ARMAZENAR OS ARTEFATOS GERADOS E SER UM VOLUME PARA DinD /OPT/AGENTS/GO-AGENT
	file{"/opt/agents/":
		ensure  => "directory",
		owner   => "${user_local}",
		group   => "${group_local}",		
	}  
	
### CRIANDO A PASTA PARA ARMAZENAR OS SCRIPS DE CONTINUOUS DELIVERY
	file{"/opt/scripts_cd":
		ensure  => "directory",
		owner   => "${user_local}",
		group   => "${group_local}",
	}
}