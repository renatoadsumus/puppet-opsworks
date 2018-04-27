class profile::docker_container inherits profile::base{	
  
  exec {'gocd_server':
        command  => 'docker run --rm -d -p 8154:8154 --name gocd_server --dns=172.17.32.98 --dns-search=ogmaster.local renatoadsumus/gocd:latest',       	
		path => ['/usr/bin',],
		onlyif  => 'test ! -e /etc/docker/container_gocd_server_execucao.txt',
    }
	
	file {'container_gocd_server_execucao':
        ensure => 'file',
        path => '/etc/docker/container_gocd_server_execucao.txt',
        content => 'Container com GO SERVER em execucao',  
		require => [Exec['gocd_server']],
	}
		
		
	#scp -i devopsec2.pem anaconda-post.log ec2-user@18.205.34.123:/home/ec2-user
}



