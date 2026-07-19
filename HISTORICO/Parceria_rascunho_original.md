# Contexto
	Realinhar a parceria por que ele ficou parecido como eu pensei num sistema anterior, mas ficou muito engessada.
	
# Objetivo
	Torna-la um pouco mais dinamica, concentrando tudo em apenas uma tabela tb_partnership.
		
# Conceito da parceira
	A parceira nao nasce pela simples criacao de um registro.
	Ela nasce somente se tivermos um parceiro que trouxe para a empresa um cliente
		Analise essa Script alterado....
		CREATE TABLE `tb_partnership` (
		  `tb_institution_id` int(11) NOT NULL,
		  `tb_customer_id` int(11) NOT NULL,
		  `tb_collaborator_id` int(11) NOT NULL,
		  `rate` decimal(10,2) DEFAULT NULL,
		  `created_at` datetime NOT NULL,
		  `updated_at` datetime NOT NULL,
		  `deleted` char(1) NOT NULL DEFAULT 'N'
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
		
		Apenas trocando tb_partnership_id por tb_customer, podemos remover as outras tabelas e aliviar a estrutura
		O acesso a criacao da PArceira deve ser feita atraves de uma aba do cliente chamada Parceria.
			So informamos os colaboradores involvidos e os percentuais...as outras regras permancem
			
# Conceito Estrutural no desenvolvimento

		Como estamos falando de um sistema altamente complexo, que pode ser ramificado de varias maneiras, sempre me preocupo com conceitos e nomeclaturas
			Este tipo de parceria tem um contexto/conceito....
				Colaborador traz um cliente 
				Verificamos quantos colaboradores precisamos para atender o cliente
				Feito isso combinamos um percentual para cada um deles, de acordo com a interacao de cada.
				
		Entao quando surgir um novo coneito de parceria, gostaria pode poder agregar e/ou combinar objetos, mantendo a visao orientada a objeto.
		Estude um modelo em que temos varios pecas de lego(objeto) mas nao temos um formato final, pois cada nova peca da mais poder para o ERP
			A melhor visuailzacao seria comparar como uma nuvem. Nuvem é sempre nuvem, com infinitos formatos, e qualquer um que a veja sabe que é uma nuvem
		Vamos criar um agente/skill que possa entrar na orquestracao, pois é um pensamento muito profundo que tenho sobre a construcoes de software
	
# REsultado Esperado
	1 - Reorganizacao da estrutura da parceira, com foco na angariacao do cliente e na na criacao de um parceria previa
	
	2 - Criacao de um agente/Skills que me ajude a manter o a estrutura bem conceituada, co nomenclaturas bem definidas dao clareza sobre cada processo