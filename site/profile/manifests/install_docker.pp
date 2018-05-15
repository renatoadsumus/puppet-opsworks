class profile::install_docker{
		
	service { 'docker':
        ensure  => running,
        enable  => true,
        subscribe => [Package['docker'], File['/etc/docker'], File['daemon.json']],
    }

    package{'docker':
        ensure => present,
   }
	
	file{ '/etc/docker':
        ensure  => 'directory',  				
    }
	
    file {'daemon.json':
        ensure => 'file',
        path => '/etc/docker/daemon.json',
        content => '{"bip":"10.66.33.10/24"}',  
		require => [Package['docker']],
	}
	
	exec {'add_user_docker_groupo':
        command  => 'usermod -aG docker ec2-user',   
		path => ['/usr/bin'],
		require => [File['daemon.json']],
		onlyif  => 'test ! -e /etc/docker/daemon.json',
    }
	
}

	#https://www.puppetcookbook.com/posts/install-basic-docker-daemon.html
	#https://www.puppetcookbook.com/posts/run-a-basic-docker-container.html