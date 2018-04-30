class role::server_ci_cd_onpremise {
	include profile::server_ci_cd_onpremise
	include profile::agent_gocd_onpremise
	
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
