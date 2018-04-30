class role::server_ci_cd_onpremise {
	include profile::server_ci_cd_onpremise
	include profile::agent_gocd_onpremise
	
	file {[	'/opt/gocd_server/',
					'/opt/gocd_server/db/',
					'/opt/gocd_server/artifacts/',]:
        ensure => 'directory',					
	}
	
	file_line {"/etc/firewalld/zones/public_copia.xml":
		path => "/etc/firewalld/zones/public_copia.xml",
		line => '<rule family="ipv4"><source address="172.18.0.0/16"/>\n<accept/>\n</rule></zone>',
		match => "^</zone>.*$",		
	}
	
	
}
