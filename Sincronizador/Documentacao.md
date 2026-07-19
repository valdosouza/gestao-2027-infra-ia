# Documentação Técnica — Sistema Sincronizador Delphi

**Projeto:** Sincronizador Firebird 2.5 → MySQL via API Node.js  
**Data da análise:** 2026-05-31  
**Base analisada:** `Sincronizador/` (models, controllers, classes, functions) + `Api/src/data_objetcs/`
**Escopo**: setes

---

## 1. Visão Geral do Sistema

O Sincronizador é uma aplicação Delphi que opera como agente de sincronização bidirecional entre um banco Firebird 2.5 local (origem) e um sistema web cujo backend é uma API Node.js com banco MySQL (destino). A sincronização é disparada por um timer configurável (por minuto do relógio ou por intervalo em segundos). Triggers Firebird inserem automaticamente na tabela `TB_SINCRONIA` cada alteração (INSERT/UPDATE) nas tabelas monitoradas — **não existem deleções físicas**: um campo `Deleted` será adicionado em cada tabela para marcação lógica, e o sincronizador tratará exclusões como atualizações. O componente `TSendToWebServer` lê essa fila, instancia dinamicamente via RTTI — através de uma factory (`TGeneralSendFactory`) — a classe de envio correspondente (ex.: `TCustomerSendWeb`), que instancia o controller de origem, executa o método `GenerateJson` (que lê o registro do Firebird via controller e serializa para JSON), e faz um HTTP POST para a API Node.js. O núcleo do sincronizador é genérico: o que o diferencia por entidade são as classes registradas na factory e as configurações em `TB_LISTA_SINCRONIA`. Os endpoints de destino não são hardcoded: ficam em `TB_LISTA_SINCRONIA.END_POINT`. A URL base da API é lida do registro do Windows (seção `SISWEB`, chave `FPathURL`). No sentido inverso, `TReceiveFromWebServer` busca dados do servidor web e os persiste no Firebird. A tabela `TB_GESTAO_WEB` mapeia IDs locais para IDs web.

---

## 2. Inventário de Componentes

### 2.1 Models de Origem (Firebird)
	Os models sao classes Delphi com notacoes sobre 
		[TableName('')]
	    [KeyField('')]
    	[FieldName('')] 
	Local dos arquivos : C:\migration\Sincronizador\model

### 2.2 Models de Destino (MySQL / API Node)
		Os models de destino estao dividos em
			Simples - podem ser referenciados como um [De => Para ] com pequenos ajustes
				local: C:\migration\Api\src\model
			Complexos - models que precisam ser enviados em grupos devido a relacionamento entre eles
				Local: C:\migration\Api\src\data_objetcs
				

		Os "models de destino" no código Delphi são serializados via `TJson.ObjectToJsonString()`. 
		Cada classe `*_send_web.pas` usa um data object específico, instancia o controller de origem, e executa `GenerateJson` para preencher e serializar o payload.



### 2.3 Controllers de Origem
		Dados
			Controllers de Origem sao responsaveis por coletar os dados da base de origem
			Codigo de Estabelecimentos é injetado via configuracao
			Codigo de Terminal é injetado via configuracao
			Dados nao mapeados pode ser desconsiderados devida a brusca mudanca de estrutura..

		Gerenciamento
			Outros controles sao responsaveis pela estrutura em si
			TSendToWebServer - Orquestra todos os envios: lê TB_LISTA_SINCRONIA, instancia classes via RTTI, executa HTTP POST - URL base + END_POINT de TB_LISTA_SINCRONIA
			TReceiveFromWebServer - Recebe dados do servidor web e persiste no Firebird
|			TGeneralSendFactory - Factory RTTI: instancia classe de envio pelo nome registrado em TB_LISTA_SINCRONIA			SINCRONIA.CLASS_NAME

		Local : C:\migration\Sincronizador\controller

### 2.4 Controllers de Destino

	Não existem controllers de destino como camada separada. O papel de destino é exercido pelo par **classe de envio web** (`classes/*_send_web.pas`) + `TSendToWebServer`:


---

## 3. Mapeamento DE-PARA por Entidade

> **Como funciona o mapeamento:**  
> 1. A factory `TGeneralSendFactory` instancia a classe `*_send_web` pelo nome em `TB_LISTA_SINCRONIA.CLASS_NAME`  
> 2. A classe de envio instancia o controller de origem correspondente  
> 3. O método `GenerateJson` do controller lê o registro do Firebird e popula o data object (`Api/src/data_objetcs/`)  
> 4. O data object é serializado via `TJson.ObjectToJsonString()` e enviado via POST  
	
	### IMPORTANTE	

		Como estrutura generica a prioridade e o funcionamento do processo.
		A geraçao do json pelo GenerateJson, tem Ha uma certa complexidade no GenerateJson pois nao é uma relacao direta, pode haver susgestao, porem pode precisar de intervencao do desenvolvedor 
---

### Entidade: Customer (Cliente)
> Controller responsável: `ControllerCliente.fillDataObjeto` → `TCustomerSendWeb`  
> Data Object: `TObjCustomer` → sub-objetos `TCustomer` (tb_customer) + `TObjEntityFiscal` (tb_entity)

**sub-objeto `Obj.Cliente` (TCustomer → `tb_customer`):**

| Campo Firebird | Tabela | Propriedade JSON | Transformação |
|----------------|--------|-----------------|---------------|
| `CLI_ATIVO` | TB_CLIENTE | `Cliente.Ativo` → `active` | Direto |
| `EMP_CODVDO` | TB_EMPRESA | `Cliente.VendedorExternalCode` | Direto (código externo do vendedor para lookup) |
| `EMP_CODTRA` | TB_EMPRESA | `Cliente.Transportador` → `tb_carrier_id` | Direto |
| `EMP_SITCREDITO` | TB_EMPRESA | `Cliente.SituacaoCredito` → `credit_status` | Direto |
| `EMP_VLCREDITO` | TB_EMPRESA | `Cliente.ValorCredito` → `credit_value` | Direto |
| `EMP_VENDEMC` | TB_EMPRESA | `Cliente.VendeEmCarteira` → `wallet` | Conversão: `> 0 → 'S'`; senão `'N'` |
| `EMP_CONSFINAL` | TB_EMPRESA | `Cliente.ConsumidorFinal` → `consumer` | Direto |
| `EMP_MULTIPLICADOR` | TB_EMPRESA | `Cliente.Multiplicador` → `multiplier` | Direto |
| `EMP_IGNORAST` | TB_EMPRESA | `Cliente.IgnoraST` → `by_pass_st` | Direto |
| — | — | `Cliente.Estabelecimento` → `tb_institution_id` | ⚠️ SEM ORIGEM — injetado: `FInstitutionDestino` |
| — | — | `Cliente.Vendedor` → `tb_salesman_id` | ⚠️ SEM ORIGEM — fixado em `0` (resolvido via `VendedorExternalCode`) |

**sub-objeto `Obj.Fiscal.Juridica` (dados ISS do cliente):**

| Campo Firebird | Tabela | Propriedade JSON | Transformação |
|----------------|--------|-----------------|---------------|
| `CLI_ISSEXIG` | TB_CLIENTE | `Juridica.IndExigibilidadeISS` → `iss_ind_exig` | Direto |
| `CLI_ISSRETIDO` | TB_CLIENTE | `Juridica.RetencaoISS` → `iss_retencao` | Direto |
| `CLI_ISSINC` | TB_CLIENTE | `Juridica.IncentFiscalISS` → `iss_inc_fiscal` | Direto |
| `CLI_ISSNRPROC` | TB_CLIENTE | `Juridica.NumeroProcessoISS` → `iss_process_number` | Direto |
| `CLI_ENVSOMENTEXML` | TB_CLIENTE | `Juridica.EnviarSomenteXMLNFe` → `send_xml_nfe_only` | Direto |

**Dados fiscais (TB_EMPRESA via ControllerEmpresa.fillDataObjeto → TObjEntityFiscal):**  
Nome, fantasia, CNPJ/CPF, endereço, telefones, e-mail, inscrição estadual — ver padrão idêntico em Fornecedor.

**Campos lidos mas NÃO mapeados:**

| Campo | Tabela | Motivo |
|-------|--------|--------|
| `CLI_OBSERNF` | TB_CLIENTE | ⚠️ NÃO MAPEADO |
| `CLI_INDIEDEST` | TB_CLIENTE | ⚠️ NÃO MAPEADO |
| `CLI_ENVEMAILAUT` | TB_CLIENTE | ⚠️ NÃO MAPEADO |
| `CLI_VLENTREGA` | TB_CLIENTE | ⚠️ NÃO MAPEADO |

---

### Entidade: Provider (Fornecedor)
> Controller responsável: `ControllerFornecedor.fillDataObjeto` → `TProviderSendWeb`  
> Data Object: `TObjProvider` → `TProvider` (tb_provider) + `TObjEntityFiscal` (tb_entity)

**sub-objeto `Obj.Fornecedor` (TProvider → `tb_provider`):**

| Campo Firebird | Tabela | Propriedade JSON | Transformação |
|----------------|--------|-----------------|---------------|
| `FOR_CODIGO` | TB_FORNECEDOR | `Fornecedor.Codigo` → `id` | Direto |
| `FOR_ATIVO` | TB_FORNECEDOR | `Fornecedor.Ativo` → `active` | Direto |
| — | — | `Fornecedor.Estabelecimento` → `tb_institution_id` | ⚠️ SEM ORIGEM — propagado de `Obj.Fiscal.Entidade.Estabelecimento` |

**Dados fiscais (TB_EMPRESA via ControllerEmpresa.fillDataObjeto):**  
`EMP_NOME` → `NomeRazao`, `EMP_FANTASIA` → `ApelidoFantasia`, `EMP_CNPJ` → CNPJ/CPF, endereço, telefones, e-mail.  
Padrão idêntico ao cliente — `ControllerEmpresa.fillDataObjeto` é o componente compartilhado.

---

### Entidade: Merchandise (Produto)
> Controller responsável: `ControllerProduto.FillDataObjects` → `TMerchandiseSendWeb`  
> Data Object: `TObjMerchandise` → `TProduct` (tb_product) + `TMerchandise` (tb_merchandise) + `TStock` (tb_stock)

**sub-objeto `Obj.Produto` (TProduct → `tb_product`):**

| Campo Firebird (TB_PRODUTO) | Propriedade JSON | Transformação |
|-----------------------------|-----------------|---------------|
| `PRO_CODIGO` | `Produto.Codigo` | Direto |
| `PRO_CODIGOFAB` | `Produto.Identificador` | Direto |
| `PRO_DESCRICAO` | `Produto.Descricao` | Direto |
| `PRO_CODCAT` | `Produto.Categoria` | Se `> 0` → direto; se `= 0` → fixado em `2` |
| `PRO_CAMPANHA` | `Produto.Promocao` | Direto |
| `PRO_DESTAQUE` | `Produto.Destaque` | Direto |
| `PRO_ATIVO` | `Produto.Ativo` | Direto |
| `PRO_INTERNET` | `Produto.Publicado` | Direto |
| `PRO_DETALHES` | `Produto.Observaocao` | Direto |
| — | `Produto.Estabelecimento` | ⚠️ SEM ORIGEM — injetado: `institutioWebId` |

**sub-objeto `Obj.Mercadoria` (TMerchandise → `tb_merchandise`):**

| Campo Firebird (TB_PRODUTO) | Propriedade JSON | Transformação |
|-----------------------------|-----------------|---------------|
| `PRO_CODIGO` | `Mercadoria.Codigo` | Direto |
| `PRO_CODIGOFAB` | `Mercadoria.CodigoInterno` | Direto |
| `PRO_CODFOR` | `Mercadoria.Fornecedor` | `StrToIntDef(..., 0)` — String → Int |
| `PRO_CODNCM` | `Mercadoria.NCM` | Direto |
| `PRO_CEST` | `Mercadoria.CEST` | Direto |
| `PRO_FINALTRIB` | `Mercadoria.TipoTributacao` | Direto |
| `PRO_ORIGEM` | `Mercadoria.Origem` | Direto |
| `PRO_TIPO` | `Mercadoria.Tipo` | Direto |
| `TB_MARCA_PRODUTO.MRC_DESCRICAO` | `Mercadoria.name_brand` | Lookup por `PRO_CODMRC`; se não encontrado → `'NÃO INFORMADA'` |
| `PRO_IMPRIME` | `Mercadoria.Imprime` | Direto |
| `PRO_UTILIZASERIE` | `Mercadoria.ControlarSerie` | Direto |
| `PRO_EXCLUSIVO` | `Mercadoria.ExclusivoRevenda` | Direto |
| `PRO_APLICACAO` | `Mercadoria.Aplicacao` | Direto |
| `PRO_COMPOSICAO` | `Mercadoria.TipoComposicao` | Direto |
| — | `Mercadoria.Estabelecimento` | ⚠️ SEM ORIGEM — injetado: `institutioWebId` |
| — | `Mercadoria.Marca` → `tb_brand_id` | ⚠️ SEM ORIGEM — fixado em `0` (resolvido via `name_brand`) |

**sub-objeto `Obj.Estoque` (TStock → `tb_stock`):**

| Campo Firebird (TB_PRODUTO) | Propriedade JSON | Transformação |
|-----------------------------|-----------------|---------------|
| `PRO_CODIGO` | `Estoque.Mercadoria` | Direto |
| `TB_EMBALAGEM.EMB_DESCRICAO` | `Estoque.name_package` | Lookup por `PRO_CODEMB`; se não encontrado → `'UND'` |
| `TB_MEDIDA.MED_DESCRICAO` | `Estoque.name_measure` | Lookup por `PRO_CODMED`; se não encontrado → `'UND'` |
| `PRO_CODIGOBAR` | `Estoque.CodigoBarra` | Direto |
| `PRO_SUBSTRB` | `Estoque.TemST` | Direto |
| `PRO_QTDEMINIMA` | `Estoque.QtdeMinima` | Direto |
| `PRO_DIVISOR` | `Estoque.Divisor` | Direto |
| `PRO_LOCALIZACAO` | `Estoque.Localizacao` | Direto |
| `PRO_PESO` | `Estoque.Peso` | Direto |
| `PRO_LARGURA` | `Estoque.Largura` | Direto |
| `PRO_COMPRIMENTO` | `Estoque.Comprimento` | Direto |
| `PRO_ALTURA` | `Estoque.Altura` | Direto |
| `PRO_VL_FABRICA` | `Estoque.CustoFabrica` | Direto |
| `PRO_VL_CUSTOMED` | `Estoque.CustoReal` | Direto |
| `PRO_VL_CUSTO` | `Estoque.PrecoCusto` | Direto |
| `PRO_ESTNEG` | `Estoque.EstoqueNegativa` | Direto |
| `PRO_FORA_LINHA` | `Estoque.ForaDeLinha` | Direto |
| — | `Estoque.Estabelecimento` | ⚠️ SEM ORIGEM — injetado: `institutioWebId` |
| — | `Estoque.Embalagem` → `tb_package_id` | ⚠️ SEM ORIGEM — fixado em `0` (resolvido via `name_package`) |
| — | `Estoque.Medida` → `tb_measure_id` | ⚠️ SEM ORIGEM — fixado em `0` (resolvido via `name_measure`) |
| — | `Estoque.Cor` → `tb_color_id` | ⚠️ SEM ORIGEM — fixado em `0` |
| — | `Estoque.name_color` | ⚠️ SEM ORIGEM — fixado em `''` |
| — | `Estoque.Qtde` | ⚠️ SEM ORIGEM — fixado em `0` (saldo vem de StockBalance) |

**Campos lidos mas NÃO mapeados:**

| Campo | Observação |
|-------|-----------|
| `PRO_CODGRP` / `PRO_CODSBG` | ⚠️ NÃO MAPEADOS no FillDataObjects de envio |
| `PRO_VL_CUSTOANT`, `PRO_VL_CUSTO_LAST` | ⚠️ NÃO MAPEADOS |
| `PRO_CODMHA` | ⚠️ NÃO MAPEADO |
| `PRO_VENDA` | ⚠️ NÃO MAPEADO |

---

### Entidade: SalesMan (Colaborador)
> Controller responsável: `ControllerColaborador.FillDataObjeto` → `TSalesManSendWeb`  
> Data Object: `TObjSalesMan` → `TObjCollaborator` (TObjEntityFiscal + TCollaborator) + `TVendedor`  
> **Pré-condição:** `CLB_EMAIL` deve ser não vazio — colaboradores sem e-mail são descartados (`ValidaSendSalesman = False`)

**sub-objeto entidade fiscal (TEntity → `tb_entity`):**

| Campo Firebird (TB_COLABORADOR) | Propriedade JSON | Transformação |
|----------------------------------|-----------------|---------------|
| `CLB_NOME` | `Entidade.Registro.NomeRazao` → `name_company` | Direto |
| `CLB_NOME` | `Entidade.Registro.ApelidoFantasia` → `nick_trade` | Mesmo valor de CLB_NOME |
| `CLB_DTNASCIMENTO` | `Entidade.Registro.AniversarioFundacao` → `aniversary` | Direto |
| `CLB_OBSERVACAO` | `Entidade.Registro.Observacao` → `note` | Direto |
| `CLB_CPF` (len=11) | `Fisica.CPF` | Se CPF → pessoa física |
| `CLB_IDENTIDADE` (len=11) | `Fisica.RG` | Se CPF |
| `CLB_DTNASCIMENTO` (len=11) | `Fisica.Aniversario` | Se CPF |
| `CLB_CPF` (len≠11) | `Juridica.CNPJ` | Se CNPJ → pessoa jurídica |
| `CLB_IDENTIDADE` (len≠11) | `Juridica.InscricaoEstadual` | Se CNPJ |
| — | `Juridica.CRT` | Fixado em `'1'` |
| — | `Juridica.IndicacaoIEDestinatario` | Fixado em `'1'` |
| `CLB_EMAIL` | `Email.Email` (TMailing) | Direto |
| `CLB_ENDERECO` | `Endereco.Logradouro` | Direto |
| `CLB_BAIRRO` | `Endereco.Bairro` | Direto |
| `CLB_CEP` | `Endereco.Cep` | Direto |
| `CLB_ESTADO` | `Endereco.CodigoEstado` | Lookup via `TControllerUf.BuscaCodigo` |
| `CLB_CIDADE` | `Endereco.CodigoCidade` | Lookup via `TControllerCidade.Buscacodigo` |
| — | `Endereco.Tipo` | Fixado em `'RESIDENCIAL'` |
| — | `Endereco.CodigoPais` | Fixado em `1058` (Brasil) |
| — | `Endereco.Principal` | Fixado em `'S'` |
| `CLB_FONE` | `Fones[0].Numero` | Se `CLB_FONE <> ''` → adicionado |
| `CLB_CELULAR` | ⚠️ BUG: mapeado como `CLB_FONE` no segundo fone | Campo errado no código |

**sub-objeto `TCollaborator` (`tb_collaborator`):**

| Campo Firebird | Propriedade JSON | Transformação |
|----------------|-----------------|---------------|
| `CLB_DTADMISSAO` | `DataAdmissao` → `dt_admission` | Direto |
| `CLB_DTDEMISSAO` | `DataDemissao` → `dt_resignation` | Direto |
| `CLB_SALARIO` | `Salario` → `salary` | Direto |
| `CLB_NOMEPAI` | `Pai` → `fahters_name` | Direto |
| `CLB_NOMEMAE` | `Mamae` → `mothers_name` | Direto |
| `CLB_PIS` | `Pis` → `pis` | Direto |
| `CLB_TITULO` | `Titulo` → `vote_number` | Direto |
| `CLB_ZONA` | `Zona` → `vote_zone` | Direto |
| `CLB_SECAO` | `Sessão` → `vote_section` | Direto |
| `CLB_CERTMILITAR` | `Certificado` → `military_certificate` | Direto |
| — | `Ativo` → `active` | ⚠️ SEM ORIGEM — fixado em `'S'` |

**sub-objeto vendedor (TVendedor):**

| Campo Firebird | Propriedade JSON | Transformação |
|----------------|-----------------|---------------|
| `CLB_ALIQVENDA` | `AliquotaComissao` | Direto |
| `CLB_COMPORCPRO` | `ComissaoProduto` | Direto |
| — | `Codigo` | Fixado em `0` |

**Campos lidos mas NÃO mapeados:**

| Campo | Observação |
|-------|-----------|
| `CLB_SEXO` | ⚠️ NÃO MAPEADO |
| `CLB_CELULAR` | ⚠️ BUG — nunca enviado corretamente (usa `Registro.Fone` no lugar) |
| `CLB_CARGO` | ⚠️ NÃO MAPEADO |
| `CLB_CODUSU` | ⚠️ NÃO MAPEADO |

---

### Entidade: PaymentType (Forma de Pagamento)
> Controller responsável: `ControllerFormaPagamento` → `TPaymentTypeSendWeb`  
> Data Object: `TJsonPaymentTypes` (objeto inline, sem FillDataObjects)

| Campo Firebird (TB_FORMAPAGTO) | Campo JSON | Transformação |
|-------------------------------|-----------|---------------|
| `FPT_DESCRICAO` | `description` | Direto |
| `FPT_ATIVO` | `active` | Direto |
| — | `tb_institution_id` | ⚠️ SEM ORIGEM — injetado: `FInstitutionDestino` |
| — | `id` | ⚠️ SEM ORIGEM — fixado em `0` (ID gerado pelo servidor) |
| `FPT_CODIGO` | ⚠️ NÃO MAPEADO | — |
| `FPT_BLOQUEIA`, `FPT_FINALIDADE`, `FPT_LIMITE`, `FPT_TEF`, `FPT_APP_DELIVERY` | ⚠️ NÃO MAPEADOS | — |

---

### Entidade: Brand (Marca de Produto)
> Controller responsável: `ControllerMarcaProduto` → `TBrandSendWeb`  
> Data Object: `TJsonBrand` (objeto inline)

| Campo Firebird (TB_MARCA_PRODUTO) | Campo JSON | Transformação |
|----------------------------------|-----------|---------------|
| `MRC_CODIGO` | `id` | Direto |
| `MRC_DESCRICAO` | `description` | Direto |
| — | `tb_institution_id` | ⚠️ SEM ORIGEM — injetado: `FInstitutionDestino` |
| `MRC_CODFAB` | ⚠️ NÃO MAPEADO | — |

---

### Entidade: Category (Categoria)
> Controller responsável: `ControllerDskCategory` → `TCategorySendWeb`  
> Data Object: `TJsonCategory` (objeto inline)

| Campo Firebird (TB_CATEGORY) | Campo JSON | Transformação |
|-----------------------------|-----------|---------------|
| `CAT_CODIGO` | `id` | Direto |
| `CAT_DESCRICAO` | `description` | Direto |
| `CAT_NIVEL` | `posit_level` | Direto |
| `CAT_TIPO` | `kind` | Direto |
| `CAT_ATIVO` | `active` | Direto |
| — | `tb_institution_id` | ⚠️ SEM ORIGEM — injetado: `FInstitutionDestino` |

---

### Entidade: Measure (Unidade de Medida)
> Controller responsável: `ControllerMedida` → `TMeasureSendWeb`  
> Data Object: `TJsonMeasure` (objeto inline)

| Campo Firebird (TB_MEDIDA) | Campo JSON | Transformação |
|---------------------------|-----------|---------------|
| `MED_DESCRICAO` | `description` | Direto |
| `MED_ABREVIATURA` | `abbreviation` | Direto |
| `MED_ESCALA` | `escale` | Direto |
| — | `tb_institution_id` | ⚠️ SEM ORIGEM — injetado: `FInstitutionDestino` |
| — | `id` | ⚠️ SEM ORIGEM — fixado em `0` |
| `MED_CODIGO`, `MED_ESPECIAL`, `MED_PROPORCAO`, `MED_SEQUENCIA` | ⚠️ NÃO MAPEADOS | — |

---

### Entidade: Package (Embalagem)
> Controller responsável: `ControllerEmbalagem` → `TPackageSendWeb`  
> Data Object: `TJsonPackage` (objeto inline)

| Campo Firebird (TB_EMBALAGEM) | Campo JSON | Transformação |
|------------------------------|-----------|---------------|
| `EMB_DESCRICAO` | `description` | Direto |
| `EMB_ABREVIATURA` | `abbreviation` | Direto |
| — | `tb_institution_id` | ⚠️ SEM ORIGEM — injetado: `FInstitutionDestino` |
| — | `id` | ⚠️ SEM ORIGEM — fixado em `0` |
| — | `active` | ⚠️ SEM ORIGEM — fixado em `'S'` (registros inativos enviados como ativos) |
| `EMB_CODIGO` | ⚠️ NÃO MAPEADO | — |

---

### Entidade: PriceList (Tabela de Preço)
> Controller responsável: `ControllerTabelaPreco` → `TPriceListSendWeb`  
> Data Object: `TJsonPriceList` (objeto inline)

| Campo Firebird (TB_TABELA_PRECO) | Campo JSON | Transformação |
|---------------------------------|-----------|---------------|
| `TPR_CODIGO` | `Codigo` | Direto |
| `TPR_DESCRICAO` | `Descricao` | Direto |
| `TPR_VALIDADE` | `Validade` | Direto |
| `TPR_MODALIDADE` | `Modalidade` | Direto |
| `TPR_MARGLUCRO` | `MargemLucro` | Direto |
| `TPR_ATIVA` | `Ativo` | Direto |
| — | `Estabelecimento` | ⚠️ SEM ORIGEM — injetado: `FInstitutionDestino` |
| `TPR_PRINCIPAL` | ⚠️ NÃO MAPEADO | — |

---

### Entidade: Price (Preço)
> Controller responsável: `ControllerPreco` → `TPriceSendWeb`  
> Data Object: `TPrice`

| Campo Firebird (TB_PRECO) | Propriedade JSON | Transformação |
|--------------------------|-----------------|---------------|
| `PRC_CODTPR` | `Tabela` | Direto |
| `PRC_CODPRO` | `Produto` | Direto |
| `PRC_VALOR` | `Preco` | Direto |
| `PRC_ALIQCOM` | `Comissao` | Direto |
| `PRC_QTDEMINIMA` | `Quantidade` | Direto |
| `PRC_MARGLUCRO` | `MargemLucro` | Direto |
| — | `Estabelecimento` | ⚠️ SEM ORIGEM — injetado: `FInstitutionDestino` |
| `PRC_CODIGO` | ⚠️ NÃO MAPEADO | — |

---

### Entidade: BankAccount (Conta Bancária)
> Controller responsável: `ControllerContaBancaria.FillDataObjects` → `TBankAccountSendWeb`  
> Data Object: `TObjBankAccount` → `TBankAccount` (`tb_bank_account`)  
> ⚠️ Bug ativo: `FillDataObjects` preenche `FCtrl.Obj` mas o JSON serializa `LcObj` (variável local vazia)

| Campo Firebird (TB_CONTABANCARIA) | Propriedade JSON (em FCtrl.Obj — não serializado) | Transformação |
|-----------------------------------|--------------------------------------------------|---------------|
| `CTB_CODIGO` | `ContaCorrente.Codigo` → `id` | Direto |
| `CTB_CODBCO` | `ContaCorrente.Banco` → `tb_bank_id` | Direto |
| `CTB_DTABERTURA` | `ContaCorrente.DataAbertura` → `dt_opening` | Direto |
| `CTB_AGENCIA` | `ContaCorrente.Agencia` → `agency` | Direto |
| `CTB_DTAGENCIA` | `ContaCorrente.AgenciaDv` → `agency_dv` | Direto |
| `CTB_CONTA` | `ContaCorrente.Numero` → `number` | Direto |
| `CTB_DTCONTA` | `ContaCorrente.NumeroDv` → `number_dv` | Direto |
| `CTB_FONE` | `ContaCorrente.Fone` → `phone` | Direto |
| `CTB_GERENTE` | `ContaCorrente.Gerente` → `manager` | Direto |
| `CTB_VLLIMITE` | `ContaCorrente.ValorLimite` → `limit_value` | Direto |
| `CTB_DTVENCTO` | `ContaCorrente.DataContrato` → `dt_contract` | Direto |
| Lookup TB_EMPRESA | `NumeroBanco` | Via `getNumeroBanco(CTB_CODBCO)` |
| — | `Estabelecimento` → `tb_institution_id` | ⚠️ SEM ORIGEM — injetado em LcObj (único campo que chega à API) |
| — | `Terminal` | ⚠️ SEM ORIGEM — injetado em LcObj (único campo que chega à API) |

> **Sugestão de implementação:** substituir `FStrJSon := TJson.ObjectToJsonString(LcObj)` por `FStrJSon := TJson.ObjectToJsonString(FCtrl.Obj)` para corrigir o bug e enviar todos os campos acima.

---

### Entidade: Financial (Financeiro)
> Controller responsável: `ControllerFinanceiro.FillDataObjeto` → `TFinancialSendWeb`  
> Data Object: `TObjFinancial` → `TFinancial` (tb_financial) + `TFinancialPayment` (tb_financial_payment, condicional)

**sub-objeto `Obj.Financeiro` (TFinancial):**

| Campo Firebird (TB_FINANCEIRO) | Propriedade JSON | Transformação |
|-------------------------------|-----------------|---------------|
| `FIN_CODIGO` | `Financeiro.Codigo` → `id` | Direto |
| `FIN_CODNFL` | `Financeiro.Ordem` → `tb_order_id` | Direto |
| `FIN_NR_PARCELA` | `Financeiro.Parcela` → `parcel` | Direto |
| `FIN_DT_VENCIMENTO` | `Financeiro.DataExpiracao` → `dt_expiration` | Direto |
| `FIN_VL_PARCELA` | `Financeiro.Valor` → `tag_value` | Direto |
| `FIN_CODCC` | `Financeiro.PlanoContas` → `tb_financial_plans_id` | Direto |
| `FIN_NUMERO` | `Financeiro.Numero` → `number` | Direto |
| `FIN_TIPO` | `Financeiro.Tipo` → `kind` | Direto |
| `FIN_SITUACAO` | `Financeiro.Situacao` → `situation` | Direto |
| `FIN_OPERACAO` | `Financeiro.Operacao` → `operation` | Direto |
| `FIN_ETAPA` | `Financeiro.Fase` → `stage` | Direto |
| Lookup TB_FORMAPAGTO | `DescFormaPagamento` | Lookup por `FIN_CODFPG` |
| — | `Financeiro.Estabelecimento` | ⚠️ SEM ORIGEM — injetado |
| — | `Financeiro.Terminal` | ⚠️ SEM ORIGEM — injetado |
| — | `Financeiro.TipoPagamento` → `tb_payment_types_id` | ⚠️ SEM ORIGEM — fixado em `0` |
| `FIN_DATA` | ⚠️ NÃO MAPEADO | — |
| `FIN_CODEMP`, `FIN_CODPED`, `FIN_VL_DESCONTO`, `FIN_AUTORIZADO` | ⚠️ NÃO MAPEADOS | — |

**sub-objeto `Obj.Pagamentos` (TFinancialPayment — somente se `FIN_BAIXA = 'S'`):**

| Campo Firebird | Propriedade JSON | Transformação |
|----------------|-----------------|---------------|
| `FIN_VL_JUROS` | `Pagamentos.Juro` → `interest_value` | Direto |
| `FIN_VL_MORA` | `Pagamentos.ValorDeMora` → `late_value` | Direto |
| `FIN_ALQDESCONTO` | `Pagamentos.AliquotaDesconto` → `discount_aliquot` | Direto |
| `FIN_VL_PAGO` | `Pagamentos.ValorPago` → `paid_value` | Direto |
| `FIN_DT_PAGTO` | `Pagamentos.DataDoPagamento` → `dt_payment` | Direto |
| `FIN_DT_BAIXA` | `Pagamentos.DataDaBaixa` → `dt_real_payment` | Direto |
| `FIN_BAIXA` | `Pagamentos.Baixa` → `settled` | Direto |
| `FIN_CODCR` | `Pagamentos.PlanoContas` → `tb_financial_plans_id` | Direto |
| `FIN_CODQTC` | `Pagamentos.CodigoBaixa` → `settled_code` | Direto |

---

### Entidade: FinancialPlans (Plano de Contas)
> Controller responsável: `ControllerPlanoContas.FillDataObjeto` → `TFinancialPlansSendWeb`  
> Data Object: `TObjFinancialPlans` → `TFinancialPlans` (tb_financial_plans)

| Campo Firebird (TB_PLANOCONTAS) | Propriedade JSON | Transformação |
|---------------------------------|-----------------|---------------|
| `PLC_CODIGO` | `PlanoContas.Codigo` → `id` | Direto |
| `PLC_CODPLANO` | `PlanoContas.NivelPosicao` → `posit_level` | Direto |
| `PLC_DESCRICAO` | `PlanoContas.Descricao` → `description` | Direto |
| `PLC_ORIGEM` | `PlanoContas.Fonte` → `source_` | Direto |
| `PLC_TIPO` | `PlanoContas.Tipo` → `kind` | Direto |
| `PLC_NIVEL` | `PlanoContas.Agrupador` → `cluster` | Direto |
| — | `PlanoContas.Estabelecimento` | ⚠️ SEM ORIGEM — injetado |
| — | `PlanoContas.Ativo` → `active` | ⚠️ SEM ORIGEM — fixado em `'S'` |

---

### Entidade: FinancialStatement (Movimento Financeiro)
> Controller responsável: `ControllerMovimentoFinanceiro.FillDataObjeto` → `TFinancialStatementSendWeb`  
> Data Object: `TObjFinancialStatement` → `TFinancialStatement` (tb_financial_statement)

| Campo Firebird (TB_MOVIM_FINANCEIRO) | Propriedade JSON | Transformação |
|--------------------------------------|-----------------|---------------|
| `MVF_CODIGO` | `Movimento.Codigo` → `id` | Direto |
| `MVF_CODCTB` | `Movimento.ContaCorrente` → `tb_bank_account_id` | Direto |
| `MVF_DATA` | `Movimento.Data` → `dt_record` | Direto |
| `MVF_CODHISTBCO` | `Movimento.HistoricoBancario` → `tb_bank_historic_id` | Direto |
| `MVF_VL_CREDITO` | `Movimento.ValorCredito` → `credit_value` | Direto |
| `MVF_VL_DEBITO` | `Movimento.ValorDebito` → `debit_value` | Direto |
| `MVF_HISTORISCO` | `Movimento.HistoricoManual` → `manual_history` | Direto (typo no nome do campo Firebird: "HISTORISCO") |
| `MVF_TIPO` | `Movimento.TipoMovimento` → `kind` | Direto |
| `MVF_CODQTC` | `Movimento.CodigoQuitacao` → `settled_code` | Direto |
| `MVF_CODUSU` | `Movimento.Usuario` → `tb_user_id` | Direto |
| `MVF_VL_FUTURO` | `Movimento.ValorFuturo` → `future` | Conversão: `> 0 → 'S'`; senão `'N'` |
| `MVF_DTORIGINAL` | `Movimento.DataOriginal` → `dt_original` | Direto |
| `MVF_NRDOCUMENTO` | `Movimento.DocReferencia` → `doc_reference` | Direto |
| `MVF_CONFERIDO` | `Movimento.Conferido` → `conferred` | Direto |
| `MVF_CODFPG` | `Movimento.FormaPagamento` → `tb_payment_types_id` | Direto |
| `MVF_PL_CREDITO` | `Movimento.ContaCredito` → `tb_financial_plans_id_cre` | Direto |
| `MVF_PL_DEBITO` | `Movimento.ContaDebito` → `tb_financial_plans_id_deb` | Direto |
| Lookup TB_FORMAPAGTO | `DescFormaPagamento` | Lookup por `MVF_CODFPG` |
| — | `Movimento.Estabelecimento` | ⚠️ SEM ORIGEM — injetado |
| — | `Movimento.Terminal` | ⚠️ SEM ORIGEM — injetado |

---

### Entidade: Invoice (Nota Fiscal)
> Controller responsável: `ControllerNotaFiscal.FillDataInvoice / FillDataInvoiceMerchandise` → `TInvoiceSendWeb` / `TInvoiceMerchandiseSendWeb`  
> Data Object: `TObjInvoice` / `TObjInvoiceMerchandise`  
> Filtro: `NFL_TIPO = 'EM'` → avulsa (`TInvoiceSendWeb`); demais → mercadoria (`TInvoiceMerchandiseSendWeb`)

**sub-objeto `Nota` (TInvoice → `tb_invoice`):**

| Campo Firebird (TB_NOTA_FISCAL) | Propriedade JSON | Transformação |
|---------------------------------|-----------------|---------------|
| `NFL_CODIGO` | `Nota.Codigo` → `id` | Direto |
| `NFL_CODEMP` | `Nota.IssuerExternalCode` | Se tipo 'EE' ou 'EM'; senão `0` |
| `NFL_CODEMP` | `Nota.EntityExternalCode` | Direto (destinatário) |
| `NFL_TIPO` | `Nota.TipoEmissao` | Direto |
| `NFL_FINALIDADE` | `Nota.Finalidade` | Direto |
| `NFL_NUMERO` | `Nota.Numero` | Direto |
| `NFL_SERIE` | `Nota.Serie` | Direto |
| `NFL_CFOP` ou lookup `NFL_CODCFOP` | `Nota.Cfop` | Se `NFL_CFOP <> ''` → direto; senão lookup |
| `NFL_DTEMISSAO` | `Nota.Data_emissao` | Direto |
| `NFL_VALOR` | `Nota.Valor` | Direto |
| `NFL_MODELO` | `Nota.Modelo` | Direto |
| `NFL_STATUS` | `Nota.Status` | Direto |
| — | `Nota.Estabelecimento` | ⚠️ SEM ORIGEM — injetado |
| — | `Nota.Terminal` | ⚠️ SEM ORIGEM — injetado |
| — | `Nota.Emitente` | ⚠️ SEM ORIGEM — fixado em `0` |
| — | `Nota.Destinatario` | ⚠️ SEM ORIGEM — fixado em `0` |

**sub-objeto `NotaMercadoria` (TInvoiceMerchandise — apenas em invoice_merchandise):**

| Campo Firebird | Propriedade JSON | Transformação |
|----------------|-----------------|---------------|
| `NFL_DTSAIDA` | `DataSaida` | Direto |
| `NFL_HRSAIDA` | `HoraSaida` | Direto |
| `NFL_VL_BCICMS` | `ValorBaseICMS` | Direto |
| `NFL_VL_ICMS` | `ValorIcms` | Direto |
| `NFL_VL_BCICMSST` | `ValorBaseIcmsSt` | Direto |
| `NFL_VL_ICMSST` | `ValorIcmsSt` | Direto |
| `NFL_VL_PRODUTO` | `ValorTotal` | Direto |
| `NFL_VL_FRETE` | `ValorFrete` | Direto |
| `NFL_VL_SEGURO` | `ValorSeguro` | Direto |
| `NFL_VL_DESPESAS` | `ValorDespesas` | Direto |
| `NFL_VL_IPI` | `ValorIpi` | Direto |
| `TB_PEDIDO.PED_VL_DESCONTO` | `ValorDesc` | Via `Pedido.Registro` |
| `NFL_QTDE_PRODUTO` | `QuantidadeTotal` | Direto |

---

### Entidade: OrderSale (Pedido de Venda)
> Controller responsável: `ControllerPedidoVenda.FillDataObjeto` → `TOrderSaleSendWeb`  
> Data Object: `TObjOrderSale` → `TOrder` + `TOrderSale` + `TOrderItem[]` + `TOrderTotalizer` + `TOrderBilling`

**sub-objeto `Order` (TOrder → `tb_order`):**

| Campo Firebird (TB_PEDIDO) | Propriedade JSON | Transformação |
|---------------------------|-----------------|---------------|
| `PED_CODIGO` | `Order.Codigo` | Direto |
| `PED_DATA` | `Order.Data` | Direto |
| `PED_OBSERVACAO` | `Order.Observacao` | Direto |
| `PED_FATURADO` | `Order.Status` | Direto |
| `PED_DTALTER` | `Order.RegistroCriado` | Direto |
| — | `Order.Origem` | Fixado em `'D'` (Desktop) |
| — | `Order.Estabelecimento` | ⚠️ SEM ORIGEM — injetado |
| — | `Order.Terminal` | ⚠️ SEM ORIGEM — injetado |

**sub-objeto `OrderSale` (TOrderSale → `tb_order_sale`):**

| Campo Firebird (TB_PEDIDO) | Propriedade JSON | Transformação |
|---------------------------|-----------------|---------------|
| `PED_NUMERO` | `OrderSale.Numero` | Direto |
| `PED_CODEMP` | `OrderSale.CustomerExternalCode` | Direto — ID externo para lookup do cliente |
| `PED_CODVDO` | `OrderSale.SalesmanExternalCode` | Direto — ID externo para lookup do vendedor |
| — | `OrderSale.Vendedor` → `tb_salesman_id` | ⚠️ SEM ORIGEM — fixado em `0` |
| — | `OrderSale.Cliente` → `tb_customer_id` | ⚠️ SEM ORIGEM — fixado em `0` |

**sub-objeto `Items[i]` (TOrderItem → `tb_order_item`):**

| Campo Firebird (TB_ITENS_NFL) | Propriedade JSON | Transformação |
|------------------------------|-----------------|---------------|
| `ITF_CODIGO` | `Items[i].Codigo` | Direto |
| `ITF_CODPRO` | `Items[i].Produto` | Direto |
| `ITF_CODETS` | `Items[i].Estoque` | Direto |
| `ITF_CODTPR` | `Items[i].TabelaPreco` | Direto |
| `ITF_QTDE` | `Items[i].Quantidade` | Direto |
| `ITF_VLUNITARIO` | `Items[i].ValorUnitario` | Direto |
| `ITF_ALQDESCONTO` | `Items[i].AliquotaDesconto` | Direto |
| `ITF_VLDESCONTO` | `Items[i].ValorDesconto` | Direto |
| — | `Items[i].kind` | Fixado em `'Sale'` |

**sub-objeto `Totalizer` e `Billing` (TOrderTotalizer + TOrderBilling):**

| Campo Firebird (TB_PEDIDO) | Propriedade JSON | Transformação |
|---------------------------|-----------------|---------------|
| `PED_QTDE` | `Totalizer.ProdutoQuantidade` | Direto |
| `PED_VL_PRODUTO` | `Totalizer.ValorProduto` | Direto |
| `PED_VL_IPI` | `Totalizer.IPIValor` | Direto |
| `PED_ALQDESCONTO` | `Totalizer.AlíquotaDesconto` | Direto |
| `PED_VL_DESCONTO` | `Totalizer.ValorDesconto` | Direto |
| `PED_VALOR` | `Totalizer.ValorTotal` | Direto |
| `PED_CODFPG` | `Billing.FormaPagamento` | Direto |
| `PED_PRAZO` (chars 1-3) | `Billing.Parcelas` | `Copy(Prazo,1,3)` |
| `PED_PRAZO` (chars 7+) | `Billing.Prazo` | `Copy(Prazo,7,len-6)` |
| Lookup TB_FORMAPAGTO | `Billing.name_payment` | Lookup por `PED_CODFPG` |

---

### Entidade: StockBalance (Saldo de Estoque)
> Controller responsável: `ControllerEstoque` → `TStockBalanceSendWeb`  
> Data Object: `TStockBalance`

| Campo Firebird (TB_ESTOQUE) | Propriedade JSON | Transformação |
|----------------------------|-----------------|---------------|
| `EST_CODETS` | `Tabela` | Direto |
| `EST_CODPRO` | `Mercadoria` | Direto |
| `EST_QTDE` | `Quantidade` | Direto |
| `EST_QTDEMINIMA` | `Minimo` | Direto |
| — | `Estabelecimento` | ⚠️ SEM ORIGEM — injetado |
| `EST_CODIGO` | ⚠️ NÃO MAPEADO | — |
| `EST_RESERVA` | ⚠️ NÃO MAPEADO | — |

---

### Entidade: StockList (Lista de Estoques)
> Controller responsável: `ControllerEstoques` → `TStockListSendWeb`  
> Data Object: `TStockList`

| Campo Firebird (TB_ESTOQUES) | Propriedade JSON | Transformação |
|-----------------------------|-----------------|---------------|
| `ETS_CODIGO` | `Codigo` | Direto |
| `ETS_DESCRICAO` | `Descricao` | Direto |
| `ETS_PRINCIPAL` | `Tipo` | Direto (campo booleano mapeado como string `Tipo`) |
| — | `Estabelecimento` | ⚠️ SEM ORIGEM — injetado |

---

### Entidade: StockStatement (Movimentação de Estoque)
> Controller responsável: `ControllerCtrlEstoque` → `TStockStatementSendWeb`  
> Data Object: `TStockStatement`

| Campo Firebird (TB_CTRL_ESTOQUE) | Propriedade JSON | Transformação |
|---------------------------------|-----------------|---------------|
| `CET_CODIGO` | `Codigo` | Direto |
| `CET_CONTROLE` | `Ordem` | Direto |
| `CET_ITEM_CTRL` | `OrdemItem` | Direto |
| `CET_CODETS` | `Estoque` | Direto |
| `CET_TIPO` | `Tipo` | Direto |
| `CET_DATA` | `DataRegistro` | Direto |
| `CET_OPERACAO` | `Direcao` | Direto |
| `CET_CODPRO` | `Mercadoria` | Direto |
| `CET_QTDE` | `Quantidade` | Direto |
| — | `Estabelecimento` | ⚠️ SEM ORIGEM — injetado |
| — | `Terminal` | ⚠️ SEM ORIGEM — injetado (`FTerminal`, não `CET_CODTER`) |
| `CET_VINCULO` | ⚠️ NÃO MAPEADO | — |
| `Local` (TStockStatement) | ⚠️ NÃO MAPEADO — código comentado | — |

---

## 4. Fluxo de Dados por Entidade

O fluxo é o mesmo para todas as entidades. A variação está nos filtros e no objeto JSON gerado.

```
1. TIMER dispara (por minuto configurado OU por intervalo em segundos)
2. TPrincipal verifica conectividade com a internet (ping para servidor)
3. TSendToWebServer.Execute é iniciado em thread anônima
4. Lê TB_LISTA_SINCRONIA WHERE sentido='E' AND ativo='S'
   → Obtém lista de tabelas a sincronizar, com: DESC_TABELA, CLASS_NAME, END_POINT
5. Para cada tabela na lista:
   a. TControllerSincronia.getList(tabela) lê TB_SINCRONIA
      → SQL: SELECT SRC_REGISTRO, SRC_TABELA, SRC_CHAVE, MAX(SRC_TIME)
             FROM TB_SINCRONIA WHERE src_tabela=:tabela AND SRC_OPER<>'D'
             AND (SRC_LOG IS NULL OR SRC_LOG='')
             GROUP BY 1,2,3 ORDER BY 4 ASC
      → Apenas registros com INSERT ou UPDATE são processados
   b. TGeneralSendFactory.Instanciar(CLASS_NAME) cria instância via RTTI (RegisterClass)
   c. Configura: LcSendWeb.URL := FPathURL, LcSendWeb.EndPoint := END_POINT
      LcSendWeb.Metodo := 'Post', LcSendWeb.InstitutionDestino := FInstitutionDestino
   d. Para cada registro pendente em TB_SINCRONIA:
      i.   LcSendWeb.Codigo := SRC_REGISTRO
      ii.  LcSendWeb.GenerateJson:
             → Instancia o controller de origem correspondente
             → Chama FCtrl.getById(Codigo) — lê registro do Firebird
             → Executa FillDataObjects (ou mapeamento inline) para preencher o data object
             → FStrJson := TJson.ObjectToJsonString(objeto)
      iii. RESTRequest.Execute:
             → HTTP POST para concat(URL, EndPoint)
             → Body: FStrJson (⚠️ sem autenticação — LcAccessToKen vazio)
      iv.  Retorno HTTP 200: SetLastUpdate — atualiza TB_SYNC_TABLE.SYT_LAST_UPDATE
           Retorno outro:   salva texto do erro em TB_SINCRONIA.SRC_LOG
                            retrocede SYT_LAST_UPDATE para reprocessar
6. Se ReceiveWebServer = 'S': TReceiveFromWebServer busca dados do servidor e persiste no Firebird
```

**Tratamento de exclusões — soft delete (decisão de design):**

Não serão realizadas deleções físicas nas tabelas sincronizadas. A estratégia adotada é:

```
1. Um campo DELETED (BOOLEAN, default FALSE) será adicionado a cada tabela monitorada
2. Em vez de DELETE, a aplicação executará UPDATE SET DELETED = TRUE
3. O trigger de UPDATE inserirá normalmente em TB_SINCRONIA com SRC_OPER = 'U'
4. O sincronizador processará o registro como uma atualização comum
5. O data object incluirá o campo deleted no payload JSON
6. A API Node.js receberá deleted=true e marcará o registro como inativo no MySQL
```

Desta forma, o sincronizador permanece genérico — apenas INSERTS e UPDATES trafegam, e a lógica de "exclusão lógica" fica no campo `DELETED` do registro.

---

## 5. API Node.js — Endpoints Identificados

**Arquitetura do endpoint:**

O sincronizador é genérico em seu núcleo. O que define o comportamento por entidade são:
- As classes registradas na factory (`uMain.pas` → `initialization/RegisterClass`)
- As configurações em `TB_LISTA_SINCRONIA` (tabela Firebird)

Nenhum endpoint está hardcoded no código Delphi. Todos vêm de `TB_LISTA_SINCRONIA.END_POINT`.

A URL final de cada requisição é: **`FPathURL + END_POINT`**

onde `FPathURL` é lido do registro Windows (seção `SISWEB`, chave `FPathURL`).

Apenas registros alterados são processados: o controle é feito pela tabela `TB_SINCRONIA`, alimentada automaticamente por triggers Firebird em cada INSERT ou UPDATE nas tabelas monitoradas. O campo `SRC_LOG` registra erros de envio, e `TB_SYNC_TABLE.SYT_LAST_UPDATE` controla o progresso da última sincronização bem-sucedida por tabela.

| Método | Rota | Payload Principal | Autenticação |
|--------|------|------------------|--------------|
| POST | ⚠️ Configurado em TB_LISTA_SINCRONIA | JSON de `TObjCustomer` | ⚠️ Não implementada |
| POST | ⚠️ Configurado em TB_LISTA_SINCRONIA | JSON de `TObjProvider` | ⚠️ Não implementada |
| POST | ⚠️ Configurado em TB_LISTA_SINCRONIA | JSON de `TObjMerchandise` (3 sub-objetos) | ⚠️ Não implementada |
| POST | ⚠️ Configurado em TB_LISTA_SINCRONIA | JSON de `TObjSalesMan` | ⚠️ Não implementada |
| POST | ⚠️ Configurado em TB_LISTA_SINCRONIA | `{"description":"X","active":"S","tb_institution_id":N,"id":0}` | ⚠️ Não implementada |
| POST | ⚠️ Configurado em TB_LISTA_SINCRONIA | `{"id":N,"description":"X","tb_institution_id":N}` | ⚠️ Não implementada |
| POST | ⚠️ Configurado em TB_LISTA_SINCRONIA | JSON de `TPrice` | ⚠️ Não implementada |
| POST | ⚠️ Configurado em TB_LISTA_SINCRONIA | JSON de `TObjFinancial` + `TFinancialPayment` | ⚠️ Não implementada |
| POST | ⚠️ Configurado em TB_LISTA_SINCRONIA | JSON de `TObjOrderSale` (order + itens + totalizador) | ⚠️ Não implementada |
| POST | ⚠️ Configurado em TB_LISTA_SINCRONIA | JSON de `TStockBalance` | ⚠️ Não implementada |
| POST | ⚠️ Configurado em TB_LISTA_SINCRONIA | JSON de `TStockStatement` | ⚠️ Não implementada |
| POST | ⚠️ Configurado em TB_LISTA_SINCRONIA | JSON de `TObjInvoice` / `TObjInvoiceMerchandise` | ⚠️ Não implementada |

**Para consultar os endpoints reais:** executar `SELECT CLASS_NAME, END_POINT, WAY FROM TB_LISTA_SINCRONIA WHERE SET_ON = 'S'` no banco Firebird de produção.

---

## 6. Pendências e Inconsistências Encontradas

| # | Arquivo | Descrição do Problema | Severidade |
|---|---------|----------------------|------------|
| 1 | `bank_account_send_web.pas` | Bug: `FCtrl.FillDataObjects` preenche `FCtrl.Obj` mas o JSON serializa `LcObj` (variável local criada separadamente e não preenchida). Apenas `Estabelecimento` e `Terminal` chegam à API. Correção: `TJson.ObjectToJsonString(FCtrl.Obj)` | 🔴 Alta |
| 2 | `general_web.pas` | Autenticação ausente: `LcAccessToKen` declarado mas nunca inicializado. Nenhum header `Authorization` ou Bearer Token é enviado | 🔴 Alta |
| 3 | `uMain.pas` | `TInvoiceReturnServiceSendWeb` comentada no `initialization`: `//RegisterClass(TInvoiceReturnServiceSendWeb)`. Retorno de NFS-e não sincroniza | 🔴 Alta |
| 4 | `uMain.pas` | `RunScript(Script: String)` ignora completamente o parâmetro recebido e sempre executa SQL hardcoded de UPDATE em `TB_CRP_ITENS`. Todos os chamadores passam scripts diferentes que não são executados | 🔴 Alta |
| 5 | `ControllerColaborador.pas` | Bug: ao montar o segundo telefone (celular), o código usa `Registro.Fone` em vez de `Registro.Celular`. O campo `CLB_CELULAR` nunca é enviado corretamente para a API | 🟡 Média |
| 6 | `customer_send_web.pas` | Validação de CPF/CNPJ comentada: `{Retirada a validação...}` — sempre retorna `True`. Registros com documentos inválidos são sincronizados | 🟡 Média |
| 7 | `provider_send_web.pas` | Mesmo problema: validação de documento comentada | 🟡 Média |
| 8 | `payment_type_send_web.pas` | Campo `id` enviado fixo como `0`. `FPT_CODIGO` (chave primária) não é mapeado | 🟡 Média |
| 9 | `measure_send_web.pas` | Campo `id` fixado em `0`. `MED_CODIGO` não mapeado | 🟡 Média |
| 10 | `package_send_web.pas` | Campo `active` fixado em `'S'` — registros inativos no Firebird são enviados como ativos | 🟡 Média |
| 11 | `financial_send_web.pas` | `TipoPagamento` (`tb_payment_types_id`) fixado em `0` — a forma de pagamento do financeiro não é resolvida para o ID do destino | 🟡 Média |
| 12 | `tas_config.pas` | Métodos `FC_MovimentoEstoque`, `Fc_PlanoContas` e `FC_OrderConsignament` declarados mas com corpo vazio (`begin end`) — carga inicial dessas entidades não implementada | 🟡 Média |
| 13 | `file_send_web.pas` | Código de envio de conteúdo Base64 (XML) está comentado — apenas metadados do arquivo chegam à API | 🟡 Média |
| 14 | `order_sale_send_web.pas` | `OrderSale.Vendedor` e `OrderSale.Cliente` fixados em `0` — resolução dependente do servidor via `SalesmanExternalCode`/`CustomerExternalCode` | 🟡 Média |
| 15 | `uMain.pas` | Instanciação via RTTI depende de `RegisterClass` no `initialization`. Se classe não registrada → falha silenciosa em runtime | 🟢 Baixa |
| 16 | `uMain.pas` | Senha do menu de configurações hardcoded no executável: `eqpm50m$` | 🟢 Baixa |
| 17 | `stock_list_send_web.pas` | Campo `ETS_PRINCIPAL` (booleano "é estoque principal") mapeado como `Tipo` no destino — nomenclatura semanticamente ambígua | 🟢 Baixa |

---

## 7. Resumo Executivo do Estado Atual

| Dimensão | Status | Observação |
|----------|--------|------------|
| Total de entidades sincronizadas (classes de envio) | 36 | Contagem das classes `*_send_web.pas` |
| Entidades com mapeamento campo-a-campo documentado | 20 | Com tabelas DE-PARA explícitas neste documento |
| Entidades com mapeamento via FillDataObjects (interno) | 16 | Payload detalhado requer análise dos data objects |
| Entidades com bug que impede envio correto | 1 | `TBankAccountSendWeb` — payload vazio |
| Controllers de origem identificados | 37 | Todos com models vinculados |
| Controllers de origem completos | 36 | Exceção: `ControllerColaborador` (bug no celular) |
| Data Objects disponíveis em `Api/src/data_objetcs/` | 48 | Alguns aguardam implementação de FillDataObjects |
| Endpoints hardcoded no código Delphi | 0 | Todos em `TB_LISTA_SINCRONIA.END_POINT` |
| Autenticação HTTP implementada | 0 | `LcAccessToKen` declarado mas vazio |
| Pendências críticas (🔴) | 4 | Bug banco, autenticação, NFS-e, RunScript |
| Pendências médias (🟡) | 11 | Campos não mapeados, IDs fixos, métodos vazios |
| Pendências baixas (🟢) | 3 | RTTI silencioso, senha hardcoded, nomenclatura |

> **Conclusão:** A infraestrutura de sincronização (triggers, fila `TB_SINCRONIA`, factory RTTI, envio HTTP, controle de progresso) está completa e funcional. Os mapeamentos campo-a-campo das entidades principais (Cliente, Fornecedor, Produto, Colaborador, Financeiro, Pedido de Venda, Nota Fiscal, Estoque) estão implementados nos controllers e data objects. Os bloqueadores para execução em produção são: a ausência de autenticação HTTP em todas as requisições, e o bug em `TBankAccountSendWeb` que envia payload incompleto. A estratégia de soft delete (campo `DELETED`) ainda precisa ser implementada nas tabelas Firebird e refletida nos data objects e na API Node.js.
