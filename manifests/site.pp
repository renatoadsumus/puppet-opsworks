node 'infodevops3.ogmaster.local'{

	include role::server_ci_cd::onpremise
}

node 'default'{

	include role::server_ci_cd::aws
}