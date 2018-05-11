class profile::install_svn{
	package{"subversion":
		ensure   => present,
	}
}
