# Contexto
	Sistema de Validacao dos formualarios esta muito fraco/amador, 
	Agora que temos um numero bom de formularios/tela/UI. podemos analisamos de forma geral e criar algo que atenda de forma uniformizada
	
	
# Objetivo
	1 - Criar uma estrutura de validacao que permita o usuario identificar 
		Erro : Para informar ao suporte quando precisar
		Alertas de validacao : Entender por que algo nao está avancando e corrigir, sem precisar do suporte
		Validacao propriamente dito que permita com que o usuario possa avancar em suas intencoes sem gerar problemas as cadeias seguintes.
		
	2 - Um agente deve entrar na orquestracao de para garantir que as validaocoes estao aconecendo;
	
# Estrutura
	Validacoes de UI
		Preechimento de campos
			Campos obrigatorios...
			Informacao invalida como CPF e CNPJ que dependem de calculo especifico para saber se sao validos
			
	Validacoes do Backend
		REgistros em duplicidade, por exemplo CPF ou CNPJ ja existem.
		Basicamente informacoes que a UI nao sabe e precisa recorrer ao Backend, 
		Precisamos de um mecanismo consistente
		
# Resultado esperado
	Baseado na evolucao do ERP que sempre cresce rapidamente, precisamos deste modelo perfeitamente integrado com o sistema
	
# alteracao importante no sistema de mensagem
	A mensagem via Banner no rodape é muito sutil, alem de sumir muito rapidamente
	O Usuario nao tem chance de ler adequadamente.
	Precisamos do velho e bom alerta com dialogo com botoes de ok, ou eventualmente botoes de decicao Sim/Nao/Cancelar
	
	
# questoes no feedBack
R1 - recomendacao aceita

R2 - Acho que podemos utilizar e melhorar algo que ja existe no sistema anterior
	Log na tabela é melhor...
	Verifique se a estrutura atual pode ser melhorada...
	CREATE TABLE `tb_crashlytics` (
	  `id` int(11) NOT NULL,
	  `tb_institution_id` int(11) NOT NULL,
	  `tb_user_id` int(11) NOT NULL,
	  `origen` varchar(100) NOT NULL,
	  `message` blob DEFAULT NULL,
	  `created_at` datetime DEFAULT NULL,
	  `updated_at` datetime DEFAULT NULL,
	  `deleted` char(1) NOT NULL DEFAULT 'N'
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;	
	
R3 - Foca so no campo...Usuarios tem problemas com multiplas validacoes ao mesmo tempo
 
R4 - A estrutura deve prever isso, por que ha casos em que sim gera uma acao, Não gera outra acao, mas o usuario nao consegue decidir...entao ele precisa ter a opcao cancelar...
		Precisar entrar no desenho de alguma forma
R5  - Me explique melhor....
R6 - Vamos descorrer mais sobre esse assunto, quando for criar uma tela, o agente precisa saber das validacoes para ja criar a tela de forma correta...
R7 - ok
R8 - Precisamos de um catalogo de erros conhecidos, vai ajudar em analise futura juntamente com o tb_crashlytics