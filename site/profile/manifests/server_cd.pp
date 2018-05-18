class profile::server_cd {	

### CRIANDO AS PASTAS DB E ARTIFACTS PARA SER VOLUME PARA GO-CD
  file {[	'/opt/gocd_server/',
					'/opt/gocd_server/db/',
					'/opt/gocd_server/artifacts/',]:
        ensure => 'directory',					
	}
		
### CRIANDO A PASTA DOCKER DENTRO DA ETC PARA ALTERAR CONFIGURACOES DEFAULT 
### AWS - ALTERAR A REDE DEFAULT DE 172.0.0.1 PARA 10.66.33.10
### ONPREMISE - ALTERAR ONDE DOCKER ARMAZENA IMAGENS E CONTAINER PARA /OPT/DOCKER
	file{ '/etc/docker/':
        ensure  => 'directory',        
    }
	
}