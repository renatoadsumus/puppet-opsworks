class s2i::install {	
	
	download_uncompress {'download_s2i':
			download_base_url  => "https://github.com/openshift/source-to-image/releases/download/v1.1.8",
			distribution_name  => "source-to-image-v1.1.8-e3140d01-linux-amd64.tar.gz",
			dest_folder   => "/opt/s2i",
			creates       => "/opt/s2i",
			uncompress    => "tar.gz",					
	} -> file { "/opt/":
		ensure  => "directory",
		recurse => true,
		recurselimit => 1,		
		mode	=> "755",		
	}
	
	file { '/usr/bin/s2i':
		ensure => 'link',
		target => '/opt/s2i/sti',
		force => true,
		require => Download_uncompress['download_s2i'],
	}
	
	file { '/usr/bin/sti':
		ensure => 'link',
		target => '/opt/s2i/sti',
		force => true,
		require => Download_uncompress['download_s2i'],
	}
}

#puppet module install dsestero-download_uncompress --version 1.3.2
