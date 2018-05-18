class jenkins::install_jenkins_master {

	$test_se_java_ja_instalado = 'ls /usr/lib/jvm/jre-1.8.0-openjdk'	
	
	package{'jenkins':
		ensure => present,		
	}
	
	service { 'jenkins':
			ensure => running,	
			require  => [Package["java-1.8.0-openjdk"],Exec["JAVA_HOME","JRE_HOME","carregar_profile","jenkins_repo_to_install","rpm"],Exec["instalando_plugins"]],
	}
	
	package{'java-1.8.0-openjdk':
		ensure => present,
	}
	
	exec{'JAVA_HOME':
		command => "echo 'export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk' | sudo tee -a /etc/profile",
		user    => 'root',
		path => '/usr/bin',
		unless => $test_se_java_ja_instalado,	
	}
	
	exec{'JRE_HOME':
		command => "echo 'export JRE_HOME=/usr/lib/jvm/jre' | sudo tee -a /etc/profile",
		user    => 'root',
		path => '/usr/bin',	
		unless => $test_se_java_ja_instalado,
	}
	
	exec{'carregar_profile':
		command => "source /etc/profile",
		user    => 'root',
		path => '/usr/bin',	
		unless => $test_se_java_ja_instalado,
	}
	
	exec{'jenkins_repo_to_install':
		command => "wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo",
		user    => 'root',
		path => '/usr/bin',		
		unless => $test_se_java_ja_instalado,
	}	
	
	exec{'rpm':
		command => "rpm --import http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key",
		user    => 'root',
		path => '/usr/bin',		
		unless => $test_se_java_ja_instalado,
	}	
	
	exec{'instalando_plugins':
		command => "curl -L --silent --output /var/lib/jenkins/plugins/swarm.hpi https://updates.jenkins-ci.org/latest/swarm.hpi",
		user    => 'root',
		path => '/usr/bin',
		unless => 'ls /var/lib/jenkins/plugins/swarm',	
	}	
}


#file {'criando_script_para_instalar_plugins_jenkins':
		#ensure => 'file',
		#path => '/home/vagrant/instalar_plugin_jenkins2.sh',
		#content => '#!/bin/bash \n
					#while read -r line \n
					#do \n
					#plugin="$line" \n
					#curl -L --silent --output /var/lib/jenkins/plugins/"$plugin".hpi https://updates.jenkins-ci.org/latest/"$plugin".hpi \
					#done < /home/vagrant/plugins.txt',			
		#replace => 'yes',
		#owner  => 'root',
		#group  => 'root',
		#mode => '0755',	
	#}
	
	#exec { 'instalar_plugins_jenkins':
		#command => "/bin/bash -c '/home/vagrant/instalar_plugin_jenkins.sh'",	
		#user    => 'root',
		#unless => $test_se_java_ja_instalado,		
	#}


	
#/home/vagrant/instalar_plugin_jenkins.sh
#!/bin/bash
#while read -r line
#do
#    plugin="$line"
#curl -L --silent --output /var/lib/jenkins/plugins/"$plugin".hpi https://updates.jenkins-ci.org/latest/"$plugin".hpi

#done < /home/vagrant/plugins.txt


#https://www.vultr.com/docs/how-to-install-jenkins-on-centos-7
# sudo systemctl start jenkins.service
# sudo systemctl restart jenkins.service
# sudo systemctl enable jenkins.service