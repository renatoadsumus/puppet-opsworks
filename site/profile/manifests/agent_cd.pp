class profile::agent_cd {

$user = $role::agent_ci_cd::onpremise::install::user
$group = $role::agent_ci_cd::onpremise::install::group

 if $group == undef {
		$user = "go"
		$group = "go"			
}

notify{ " Colocando nas pastas para Usuario...:  ${$user} a Grupo...: ${$group}": }
	
### CRIANDO NOVA PASTA PARA VOLUMES DE REPOSITORIOS MAVEN E GRAILS DEVIDO A PROBLEMAS DE PERMISSIONAMENTO DAS IMAGENS DOCKER COM GO
	file { ["/opt/repositories/",
			"/opt/repositories/maven",
			"/opt/repositories/grails"]:
		ensure => "directory",
		owner  => "${user}",
		group  => "${group}",
	}
	
### CRIANDO A PASTA ARA ARMAZENAR OS ARTEFATOS GERADOS E SER UM VOLUME PARA DinD /OPT/AGENTS/GO-AGENT
	file{"/opt/agents/":
		ensure  => "directory",
		owner   => "${user}",
		group   => "${group}",		
	}  

}