class role::server_ci_cd_onpremise {
	include profile::server_ci_cd_onpremise
	include profile::agent_gocd_onpremise
	
	file {'creating_db_and_artifacts_folder':
        ensure => 'directory',
        path => [	'/opt/gocd_server/',
					'/opt/gocd_server/db/',
					'/opt/gocd_server/artifacts/',],
		#owner  => "go",
		#group  => "go",		
	}
	
}
