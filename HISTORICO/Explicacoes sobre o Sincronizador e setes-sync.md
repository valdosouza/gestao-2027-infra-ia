# Contexto
	O trabalho diz repeito a sincronizador que le banco de dados Firebird.
	Ele deve enpactor os dados no formato que setes-sync espera para a api fazer a gravacao no banco setes_+schemas
	
# Planejamento a medio prazo
	Clientes atuais usam o sistema na versao  Gestao2016 (versao DElphi desktop)
	O sincronizador fara um trabalho temporario levando os dados locais para a web.
	Com os dados na web, o comercial vai fazer uma trabalho para vender novos produtos mobiles.
	E com o tempo aposentar o Gestao2016 e usar inteiramente o ERP vi web

# Elemento intermdiario
	Foi criado um sistema web ainda usando Delphi com framework unigui que gera javascript sencha.
	## Resultados
		1 - Banco de dados	
				O banco de dados que estamos usando hoje para o Gestao2027 é 95% derivado dele. nao do Firebird.
				Muito bem montado e e este banco ja tem 12 anos de maturacao
		2 - Sistema web usando unigui	
				A intencao de criar o sistema web com unigui, foi que ele gerava telas muito parecidas com as telas do desktop.
				Isso iria me ajudar na transicao e reduzindo o tempo de treinamento
			### Por que nao deu certo.
				Muito codigo, poucos colaboradores a entrega ficou lenta.
				O que nos levou a outro problema, o mobile tomou muita forca a partir de 2014/2015.
				Como uniqui nao tinha condicoes de construir telas responsivas. o produto ficou somente na web
				Somente na web o produto perderu aderencia e poucos clientes que entraram sairam rapidamente.
				
	## Referencias deste projeto
		Devem ser usadas com muita cautela.
		Temos muitos exemplos que funcionam, algumas solucoes demoram para serem elaboaradas, mas nao tem cliente usando.
		Esse modelo nao trabalha com api, mas os models e controller podem ser usados como referencia.
		
		Obs. Esse alerta foi feito por que li em uma de nossas conversas a referencia ao d:\gestaoweb que se trata deste sistema intermediario
			
# Projetos
	1 - Gestao2016 	- Delphi desktop
		##Importante
			O banco de dados é muito diferente por isso o sincronizador deve ter extra cuidado para as indexacoes na montagem dos pacotes json
	2 - GestaoWeb 	- Delphi Web com Unigui
	3 - Gestao2027  - Flutter WebApp com api node TS
	
# Indexacoes
	tb_empresa no firebird foi dividido na nova estrutura em
		tb_entity
		tb_person ou tb_company
		tb_mailing
		tb_social_media
	
	Aqui e o calcanhar de aquiles do sistema, devido a centralizacao de entidas no setes_central para evitar duplicacoes
		Ex: CNPJ 07.742.094/0001-13
			Cada cliente da setes registrou esse cnpj como fornecedor e obviamente tb_empresa.emp_codigo com codigo diferente
				Sendo assim se torna obvio que nao podemos usar emp_codigo como referencia.
		
		Aqui entra um trabalho pesado da setes-sync que ao receber pacotes contendo cpf/cnpj devem reindexar o codigo para a entity.ID
			Caso nao encontre ele deve seguir o mesmo passo de registro de nova entity person ou company
			
	tb_marca_produto vira tb_brand
	tb_embalagem vira tb_package
	tb_medida vira tb_measure
		Para os tres casos vamos centralizar essas tabelas em setes_central como regitros unicos baseado na descricao.
		Os clientes poderao usar marca/embalagem e medidas usando tabelas vinculadas
			tb_institution_has_brand
			tb_institution_has_package
			tb_institution_has_measure
		Os clientes podem inativar ou usar o Soft delete.
		
# setes-sync
	Muito do que estou explicando ja existe codigo, preciso que anote cada regra para revisar e grarantir que isso eseja fazendo de melhor maneira possivel.
	
# Suas questoes apontados	
	
. Escopo: Padrão Novo vs. Legado
O sincronizador precisa entender o padrão novo completo (Entidade Única, CPF/CNPJ em central, tb_no_doc com UUID)?
	No Firebird tem muitos cadastros que foram feitos sem documentos, mas precisamos sincronizar para levar historico.
	Coloque nas tarefas que teremos que automatizar a criacao de um campo em tb_empresa.externalCode para receber esse UUID apos a sincronizacao para registros sem documentos.
		Isso deve permitir que outras sincronizacoes possam ser feitas sem o risco de criar o mesmo cliente novamente 
			Levando em conta que o codigo nao e indexador e si cpf/cnpj e o UUID passa a ser o indexador quando gerado pela primeira vez na web
			
Ou continua com IDs locais do Firebird e mapeamento simples?
	ja tem instrucoes sobre o uso de Id locais, alguns casos serao desconsiderados.
		PReciso que tenha um local para memorizar isso, pois teremos casos em que o id do Firebird podera ser usado.
		
01. TBrandSendWeb
02. TCategorySendWeb
03. TMeasureSendWeb
04. TPackageSendWeb
05. TMerchandiseSendWeb
06. TPriceListSendWeb
07. TPriceSendWeb
08. TStockListSendWeb
09. TStockBalanceSendWeb
10. TPromotionSendWeb
11. TFinancialPlansSendWeb
12. TPaymentTypeSendWeb

13. TCustomerSendWeb
14. TProviderSendWeb
15. TSalesManSendWeb

16. TBankAccountSendWeb - aqui temos que revisar para ter certeza de que isso vai funcionar

17. TOrderSaleSendWeb
18. TOrderPurchaseSendWeb
19. TOrderStockAdjustSendWeb

20. TInvoiceSendWeb
21. TInvoiceMerchandiseSendWeb
22. TStockStatementSendWeb

23. TFinancialSendWeb
24. TFinancialStatementSendWeb

25. TCashierSendWeb

Temos que tratar o envio de retorno de notas fiscais eletronicas 
	Notas de mercadoria no modelo 55
	Notas de mercadoria no modelo 65
	Notas de servico classe ja encontrada TInvoiceReturnServiceSendWeb
	Arquivos que hoje sao gravados no banco mas no servidor web devem ser gravados em discos, devidamente indexados por cnpj - TFileSendWeb

3. Autenticação & Soft Delete
	Como resolver a ausência de autenticação nos POST do sync?
		Precisamos implementar o melhor modelo de autenticacao entre sistema...
			Configurar no sincronizar e evitar acesso indevido no setes-sync
			

	Soft delete continua (campo DELETED)? Ou muda de estratégia?
		Sim, outra situacao e que vamos criar um campo DELETED para cada tabela no Firebrid
			Isso vai nos permitir a sincronizacao perfeita dos dados
			Essa alteracao estrutural no sisstema atual e necessario e vamos alterar o comportamente no GEstao2016
			
4. Dados Legados em Produção
	Vocês têm dados ATIVOS no Firebird que precisam ser migrados com sucesso?
		Conforme explicaoes iniciais, a sincronizacao e temporaria mas vai depender de cada cliente, ate a troca definitiva vamos dia a dia de tempos em tempo sincronizar
	
	Será dual-write (Delphi + sistema novo rodando paralelos) ou cutover puro?
		Vamos ter casos em que pedidos na web precisaram ser sincronizados no Firebird
			Aplicativos de vendas em mobiles estao acontecendo em alguns clientes.
			
	Há janela de sincronização (só noites) ou é 24/7?
		O sincronizador devera fazer isso de 5 em 5 minutos..
		
5. Sequência de Implementação
	A ordem esperada é:

	1. DDL: realinhar tabelas Firebird (adicionar DELETED, realinhar FKs cross-schema?)
			Somente adicionar DELETED....
	2. Sincronizador: novos endpoints, auth, mapeamentos atualizados
		o sincronizador precisa de um autenticador entre sistemas apenas 
	3. setes-api: consumir novos payloads + valida financial/OS
		setes-api trabalha somente com setes-app nao altera nada nela...Nao
	4. setes-app: telas (settlements, service-orders) já prontas aguardam Correto?
		nao vamos alterar nada em setes-app....
			VAmos separar em dois grupos distintos - Grave isso como regra canonica
				setes-app consome setes-api
				Sincronizador consome setes-sync
				
				
6. Software House — Bloqueio Real?
	Nao fazer nada, por que o software house desktop tem muitos buracos em relacao ao novo sistma web
	
