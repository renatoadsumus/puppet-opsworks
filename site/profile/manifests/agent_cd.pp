class profile::agent_cd {

### CRIANDO PASTA PARA ARMAZENAR BIBLIOTECAS MAVEN - EVITANDO QUE BAIXAR A TODA EXECUÇAO DE UM CONTAINER
  file {[	'/opt/maven/',
					'/opt/maven/repository/',
					]:
        ensure => 'directory',					
	}
	
### CRIANDO PASTA PARA ARMAZENAR OS ARTEFATOS GERADOS E SER UM VOLUME PARA DinD
  file {[	'/opt/gocd_agent/',
					'/opt/gocd_agent/pipelines',
					]:
        ensure => 'directory',					
	}


}