class profile::slave_ci {

group { "jenkins":
  		ensure => "present",			 
  		gid    => 995,
     }
	 
user{"jenkins":
		ensure => "present",
		groups  => ["jenkins","docker"],
		gid     => 995,
		uid     => 997,		
		managehome => true,
	}	
	
###### NECESSARIO EXECUTAR O JENKINS PRIMEIRO, POIS O GO CD PEGA UID GID DO JENKINS		
include jenkins::install_jenkins_slave

}