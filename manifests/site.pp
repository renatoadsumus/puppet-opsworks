node 'infodevops1.ogmaster.local' {		
		
	include role::server_ci::onpremise
}

node 'infodevops2.ogmaster.local' {  
              		
	include role::agent_ci_cd::onpremise::install		
}

node 'infodevops3.ogmaster.local'{

	include role::server_ci_cd::onpremise::run
}

node 'ip-10-30-20-70.ec2.internal'{

	include java::java8
	#include role::server_ci_cd::aws::run
}
