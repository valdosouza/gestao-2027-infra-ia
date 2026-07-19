# Contexto

**Escopo**: setes

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
	
	
	