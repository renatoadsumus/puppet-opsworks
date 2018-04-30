class role::server_ci_cd_onpremise {
	include profile::server_ci_cd_onpremise
	include profile::agent_gocd_onpremise
	
	file {[	'/opt/gocd_server/',
					'/opt/gocd_server/db/',
					'/opt/gocd_server/artifacts/',]:
        ensure => 'directory',					
	}
	
	file {'/etc/firewalld/zones/public_copia.xml':
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
		
}
