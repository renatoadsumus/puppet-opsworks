class role::server_ci_cd_aws { 
  include profile::server_ci_cd_aws
  include profile::agent_gocd_aws
  
  file {'creating_db_folder':
        ensure => 'directory',
        path => '/opt/gocd_server/db',
		#owner  => "go",
		#group  => "go",		
	}
	
	file {'creating_artifacts_folder':
        ensure => 'directory',
        path => '/opt/gocd_server/artifacts',
		#owner  => "go",
		#group  => "go",		
	}
} 
