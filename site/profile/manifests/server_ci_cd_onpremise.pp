class profile::server_ci_cd_onpremise inherits profile::base{		
	
	### CRIANDO A PASTA DOCKER DENTRO DA ETC
	file{ '/etc/docker/':
        ensure  => 'directory',        
    }
	
	### ALTERANDO O CAMINHO DEFAULT DOCKER PARA OPT
	file {'daemon.json':
        ensure => 'file',
        path => '/etc/docker/daemon.json',
        content => '{"graph":"/opt/docker/","storage-driver":"overlay","disable-legacy-registry": true}',
		require  => File['/etc/docker'],
       
    }
	
	::docker::image { 'renatoadsumus/gocd_server':	
		ensure    => 'present',
		image_tag => 'latest',		
	}  


	::docker::image { 'renatoadsumus/mongodb':	
		ensure    => 'present',
		image_tag => 'latest',		
	} 
	
	::docker::run { 'gocd_server':
		image   => 'renatoadsumus/gocd_server:latest',
		ports   => ['8153:8153','8154:8154'],
		volumes => ['/opt/gocd_server/artifacts/:/var/lib/go-server/artifacts', '/opt/gocd_server/db/:/var/lib/go-server/db', '/opt/gocd_server/cruise-config.xml/:/etc/go/cruise-config.xml'],
		require => Docker::Image['renatoadsumus/gocd_server'],
		
	}
		
	::docker::run { 'mongodb':
		image   => 'renatoadsumus/mongodb:latest',
		ports   => ['27017:27017'],
		require => Docker::Image['renatoadsumus/mongodb'],
  }  
  
  ### CRIANDO AS PASTAS DB E ARTIFACTS PARA SER VOLUME PARA GO-CD
  file {[	'/opt/gocd_server/',
					'/opt/gocd_server/db/',
					'/opt/gocd_server/artifacts/',]:
        ensure => 'directory',					
	}
	
	### RESOLVE O PROBLEMA DOCKER - NO ROUTE TO HOST 
	file {'/etc/firewalld/zones/public.xml':
			ensure => 'file',
			path => '/etc/firewalld/zones/public_copia.xml',
			content => '<?xml version="1.0" encoding="utf-8"?>
<zone>
<short>Public</short>
<description>For use in public areas. You do not trust the other computers on networks to not harm your computer. Only selected incoming connections are accepted.</description>
	<service name="dhcpv6-client"/>
	<service name="ssh"/>
		</zone>
		<rule family="ipv4">
			<source address="172.18.0.0/16"/>
			<accept/>
		</rule>
</zone>',  
			
		}	
		
		#https://forums.docker.com/t/no-route-to-host-network-request-from-container-to-host-ip-port-published-from-other-container/39063/5
		#http://devopslab.com.br/como-instalar-e-configurar-o-puppet-server-puppet-cliente-e-modulos-de-configuracao/
		### FALTA O systemctl restart firewalld
  
 
}