class devops::go_server {


        package{'go-server':
                ensure => present,
                require  => [Exec["repositorio"]],
        }
		
        exec{'repositorio':
				command => "curl https://download.gocd.org/gocd.repo -o /etc/yum.repos.d/gocd.repo",
				user    => 'root',
				path => '/usr/bin',
				#unless => $test_se_plugins_jenkins_estao_instalados,
         }	 
		
		
        service { 'go-server':
                ensure => running,
        }

}
