class docker::install_docker{
		
	### -e retorna True se o arquivo existe
	
	exec {'install_selinux':
        command  => 'yum install -y http://mirror.centos.org/centos/7/extras/x86_64/Packages/container-selinux-2.42-1.gitad8f0f7.el7.noarch.rpm',   
		path => ['/usr/bin'],		
		onlyif  => 'test ! -e /etc/yum.repos.d/docker-ce-stable.repo',
    }
	
	yumrepo { "docker-ce-stable":
        enabled  => 1,
        descr    => "Docker CE Stable - \$basearch",
        baseurl  => "https://download.docker.com/linux/centos/7/\$basearch/stable",      
        gpgcheck => 1,
        gpgkey   => "https://download.docker.com/linux/centos/gpg",
    }	
	
	package{'docker-ce':
        ensure => present,
		require => [Yumrepo['docker-ce-stable'],Exec['install_selinux']],
	}
	
	exec {'add_user_docker_groupo':
        command  => 'usermod -aG docker ec2-user',   
		path => ['/usr/sbin','/usr/bin'],		
		user  => "root",
		onlyif  => 'test ! -e /etc/docker/daemon.json',
    }	
	
	
	file {'daemon.json':
        ensure => 'file',
        path => '/etc/docker/daemon.json',
        content => '{"bip":"10.66.33.10/24"}',  
		require => [Package['docker-ce']],
	}
		
		
	
	
	service { 'docker':
        ensure  => running,
        #enable  => true,
        subscribe => [Package['docker-ce'], File['daemon.json']],
    }
	
	file{"/var/run/docker.sock":		
		mode => "666",
	}
	
}
 ### Remover Docker
 /*sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine
			
*/
# sudo rm -fr /etc/yum.repos.d/docker*
# sudo rm -fr /etc/docker/daemon.json
	#https://www.puppetcookbook.com/posts/install-basic-docker-daemon.html
	#https://www.puppetcookbook.com/posts/run-a-basic-docker-container.html