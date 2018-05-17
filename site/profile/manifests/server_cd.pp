class profile::server_cd {	

### CRIANDO AS PASTAS DB E ARTIFACTS PARA SER VOLUME PARA GO-CD
  file {[	'/opt/gocd_server/',
					'/opt/gocd_server/db/',
					'/opt/gocd_server/artifacts/',]:
        ensure => 'directory',					
	}
		

}