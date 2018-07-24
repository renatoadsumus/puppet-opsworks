node 'infodevops1.ogmaster.local' {		
		
	include role::server_ci::onpremise
}

node 'infodevops2.ogmaster.local' {  
              		
	include role::agent_ci_cd::onpremise::install		
}

node 'infodevops3.ogmaster.local'{

	include role::server_ci_cd::onpremise::run
}

node 'devops-ugzwejbgqd3dda6c.us-east-1.opsworks-cm.io'{

	### CRIANDO PASTA PARA SALVAR OS DADOS DO MONGODB EM VOLUME	
		file{ '/opt/mongo/data_db':
        ensure  => 'directory',        
    }
	#include role::server_ci_cd::aws::run
}
