#ip-10-30-20-70.ec2.internal
node 'ip-10-30-20-70.ec2.internal'{

	### CRIANDO PASTA PARA SALVAR OS DADOS DO MONGODB EM VOLUME	
		file{ '/opt/mongo/':
        ensure  => 'directory',        
    }
	#include role::server_ci_cd::aws::run
}
