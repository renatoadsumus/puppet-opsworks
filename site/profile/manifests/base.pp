class profile::base{
	include java::java8
	#include docker::install
    #include docker::install_compose
	#include elk::install_filebeat
    #include s2i::install
	#include maven	
	#include scm	
	#include basic_packages
	
	#group { "suporte":
  		#ensure => "present",			 
  		#gid    => 4000,
     #}	 
	 
	group {"docker":
		ensure => "present",
		gid => 993,
	}
	
	user{"docker":
		ensure => "present",
		groups  => ["docker"],
		gid     => 993,
		uid     => 995,		
		managehome => true,
	}
	
	#user{"tfsservice":
		#ensure => "present",
		#groups  => ["suporte","docker"],
		#gid     => 4000,
		#uid     => 4011,		
		#managehome => true,
	#}	
	
	group { "go":
  		ensure => "present",			 
  		gid    => 2000,
     }
	 
	user{"go":
		ensure => "present",
		groups  => ["docker"],
		gid     => 2000,
		uid     => 2001,		
		managehome => true,
	}
	 
	
}
