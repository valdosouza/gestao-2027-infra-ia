# NF-e — autorizadores como DADO (E3 da NE-0)

**Escopo**: misto (a relação UF × autorizador é fato nacional portável; PR, a Setes sem IE e o 1º cliente são conteúdo `setes`)
**Fonte**: Relação de Serviços Web do Portal Nacional da NF-e — produção https://www.nfe.fazenda.gov.br/portal/WebServices.aspx e homologação https://hom.nfe.fazenda.gov.br/portal/WebServices.aspx — lidas em
**2026-10-15** (cliente com cookie). Dado bruto, com TODAS as URLs por autorizador, serviço e ambiente:
[`autorizadores-2026-10-15.json`](autorizadores-2026-10-15.json). Decisões: D-NE3 (tabela completa, constante versionada) · D-NE37 (autorizador
e `tpEmis` gravados na tentativa; dimensão serviço/evento) · **D-NE96 (presença de IE do emitente)** · D-NE6 (contingência fora da F4).
**Uso**: insumo do `authorizers.ts` da NE-3 — o adaptador versiona ESTE dado (data da leitura junto); mudança na relação = nova leitura +
diff, nunca edição à mão.

## 1. Regra de derivação (D-NE3 + D-NE37 + D-NE96)

1. **Emitente SEM IE** (contribuinte exclusivo do IBS/CBS — NT 2026.007, a partir de 26/10/2026 em H e 16/11/2026 em P pelo aviso ENCAT) →
   **SVRS**, qualquer que seja a UF (C17-11; fora dela = rej. 166); eventos também na SVRS (188). Só modelo 55 (NFC-e sem IE é proibida).
   Inutilização e contingência sem IE: a NT não trata (não oficial — provar em H, D-NE95).
2. **Emitente com IE** → autorizador da UF (tabela §2): SEFAZ própria (AM, BA, GO, MG, MS, MT, PE, PR, RS, SP) · SVAN (MA) · SVRS (as demais).
3. **Contingência SVC** (fora da F4 — D-NE6): SVC-AN ou SVC-RS conforme a UF; **SVC não tem inutilização** (a relação não lista o serviço).
   As URLs da SVC-RS são as MESMAS da SVRS.
4. **Eventos**: cancelamento (110111) e CC-e → o autorizador da nota; manifestação do destinatário/EPEC → Ambiente Nacional (AN
   `RecepcaoEvento`); eventos da reforma → SVRS (NT 2025.002 — fase IBS/CBS). A rota fica GRAVADA na tentativa (D-NE37) — a pergunta
   posterior vai sempre a quem respondeu.
5. **Consulta cadastro**: autorizador próprio da UF ou a SVRS (AC, ES, RN, PB, SC); as demais UF não aparecem na relação para esse serviço.
   A SVRS tem consulta cadastro **também em homologação** (`cad-homologacao.svrs.rs.gov.br`) — o levantamento da web dizia o contrário.

## 2. UF × autorizador (relação de 15/10/2026)

| UF | Autorizador (P e H) | Contingência SVC | Consulta cadastro |
|---|---|---|---|
| AC | SVRS | SVC-AN | SVRS |
| AL | SVRS | SVC-AN | — (sem serviço na relação) |
| AP | SVRS | SVC-AN | — (sem serviço na relação) |
| AM | AM | SVC-RS | AM |
| BA | BA | SVC-RS | BA |
| CE | SVRS | SVC-AN | — (sem serviço na relação) |
| DF | SVRS | SVC-AN | — (sem serviço na relação) |
| ES | SVRS | SVC-AN | SVRS |
| GO | GO | SVC-RS | GO |
| MA | SVAN | SVC-RS | — (sem serviço na relação) |
| MT | MT | SVC-RS | MT |
| MS | MS | SVC-RS | MS |
| MG | MG | SVC-AN | MG |
| PA | SVRS | SVC-AN | — (sem serviço na relação) |
| PB | SVRS | SVC-AN | SVRS |
| PR | PR | SVC-RS | PR |
| PE | PE | SVC-RS | PE |
| PI | SVRS | SVC-AN (P) · SVC-RS (H) | — (sem serviço na relação) |
| RJ | SVRS | SVC-AN | — (sem serviço na relação) |
| RN | SVRS | SVC-AN | SVRS |
| RS | RS | SVC-AN | RS |
| RO | SVRS | SVC-AN | — (sem serviço na relação) |
| RR | SVRS | SVC-AN | — (sem serviço na relação) |
| SC | SVRS | SVC-AN | SVRS |
| SP | SP | SVC-AN | SP |
| SE | SVRS | SVC-AN | — (sem serviço na relação) |
| TO | SVRS | SVC-AN | — (sem serviço na relação) |

⚠️ **Divergência da própria relação**: o **PI** está na SVC-AN em produção e na SVC-RS em homologação — registrado como está (o dado é
por ambiente no JSON).

## 3. URLs do Paraná e da SVRS (as que a NE-3 usa primeiro)

**PR** (SEFAZ própria; as URLs oficiais terminam em `?wsdl`):

| Serviço | Versão | Produção | Homologação |
|---|---|---|---|
| NfeInutilizacao | 4.00 | `https://nfe.sefa.pr.gov.br/nfe/NFeInutilizacao4?wsdl` | `https://homologacao.nfe.sefa.pr.gov.br/nfe/NFeInutilizacao4?wsdl` |
| NfeConsultaProtocolo | 4.00 | `https://nfe.sefa.pr.gov.br/nfe/NFeConsultaProtocolo4?wsdl` | `https://homologacao.nfe.sefa.pr.gov.br/nfe/NFeConsultaProtocolo4?wsdl` |
| NfeStatusServico | 4.00 | `https://nfe.sefa.pr.gov.br/nfe/NFeStatusServico4?wsdl` | `https://homologacao.nfe.sefa.pr.gov.br/nfe/NFeStatusServico4?wsdl` |
| NfeConsultaCadastro | 4.00 | `https://nfe.sefa.pr.gov.br/nfe/CadConsultaCadastro4?wsdl` | `https://homologacao.nfe.sefa.pr.gov.br/nfe/CadConsultaCadastro4?wsdl` |
| RecepcaoEvento | 4.00 | `https://nfe.sefa.pr.gov.br/nfe/NFeRecepcaoEvento4?wsdl` | `https://homologacao.nfe.sefa.pr.gov.br/nfe/NFeRecepcaoEvento4?wsdl` |
| NFeAutorizacao | 4.00 | `https://nfe.sefa.pr.gov.br/nfe/NFeAutorizacao4?wsdl` | `https://homologacao.nfe.sefa.pr.gov.br/nfe/NFeAutorizacao4?wsdl` |
| NFeRetAutorizacao | 4.00 | `https://nfe.sefa.pr.gov.br/nfe/NFeRetAutorizacao4?wsdl` | `https://homologacao.nfe.sefa.pr.gov.br/nfe/NFeRetAutorizacao4?wsdl` |

**SVRS** (as UF da §2 + emitente SEM IE de qualquer UF):

| Serviço | Versão | Produção | Homologação |
|---|---|---|---|
| NfeInutilizacao | 4.00 | `https://nfe.svrs.rs.gov.br/ws/nfeinutilizacao/nfeinutilizacao4.asmx` | `https://nfe-homologacao.svrs.rs.gov.br/ws/nfeinutilizacao/nfeinutilizacao4.asmx` |
| NfeConsultaProtocolo | 4.00 | `https://nfe.svrs.rs.gov.br/ws/NfeConsulta/NfeConsulta4.asmx` | `https://nfe-homologacao.svrs.rs.gov.br/ws/NfeConsulta/NfeConsulta4.asmx` |
| NfeStatusServico | 4.00 | `https://nfe.svrs.rs.gov.br/ws/NfeStatusServico/NfeStatusServico4.asmx` | `https://nfe-homologacao.svrs.rs.gov.br/ws/NfeStatusServico/NfeStatusServico4.asmx` |
| NfeConsultaCadastro | 4.00 | `https://cad.svrs.rs.gov.br/ws/cadconsultacadastro/cadconsultacadastro4.asmx` | `https://cad-homologacao.svrs.rs.gov.br/ws/cadconsultacadastro/cadconsultacadastro4.asmx` |
| RecepcaoEvento | 4.00 | `https://nfe.svrs.rs.gov.br/ws/recepcaoevento/recepcaoevento4.asmx` | `https://nfe-homologacao.svrs.rs.gov.br/ws/recepcaoevento/recepcaoevento4.asmx` |
| NFeAutorizacao | 4.00 | `https://nfe.svrs.rs.gov.br/ws/NfeAutorizacao/NFeAutorizacao4.asmx` | `https://nfe-homologacao.svrs.rs.gov.br/ws/NfeAutorizacao/NFeAutorizacao4.asmx` |
| NFeRetAutorizacao | 4.00 | `https://nfe.svrs.rs.gov.br/ws/NfeRetAutorizacao/NFeRetAutorizacao4.asmx` | `https://nfe-homologacao.svrs.rs.gov.br/ws/NfeRetAutorizacao/NFeRetAutorizacao4.asmx` |

**Ambiente Nacional** (DF-e distribuição e eventos do AN):

| Serviço | Versão | Produção | Homologação |
|---|---|---|---|
| NFeDistribuicaoDFe | 1.00 | `https://www1.nfe.fazenda.gov.br/NFeDistribuicaoDFe/NFeDistribuicaoDFe.asmx` | `https://hom1.nfe.fazenda.gov.br/NFeDistribuicaoDFe/NFeDistribuicaoDFe.asmx` |
| RecepcaoEvento | 4.00 | `https://www.nfe.fazenda.gov.br/NFeRecepcaoEvento4/NFeRecepcaoEvento4.asmx` | `https://hom1.nfe.fazenda.gov.br/NFeRecepcaoEvento4/NFeRecepcaoEvento4.asmx` |

## 4. Outros dados por UF que o adaptador lê daqui

| Dado | Valor conhecido | Fonte | Estado |
|---|---|---|---|
| Prazo do cancelamento (110111) | nacional **24 h**; **PR = 168 h** (mercadoria sem circular) | Ajuste SINIEF 07/05 cl. 12ª (F22); RICMS/PR Anexo III Subanexo I art. 11 (F23 [SEC]) | demais UF: conferir UF a UF quando houver cliente nela (D-NE26 — o teto do rodízio e o aviso `FISCAL_CANCEL_DEADLINE` leem daqui; a recusa é sempre da SEFAZ, 501) |
| Inutilização oferecida | todas as autorizadoras da relação, menos a SVC; **AC, BA e SP deixam de usar o pedido de inutilização a partir de 01/11/2026** | relação de 15/10; Ajuste SINIEF 40/26 (F22) | conferir o texto do Ajuste 40/26 (a URL do CONFAZ deu 404) |
| Consumo indevido (656) | consulta protocolo > 10 da mesma chave/h; autorização > 30 rejeições iguais; inutilização e eventos > 20 rejeições iguais; recibo > 40/h; bloqueio até 1 h | MOC Anexo I §4.3 (parâmetros padrão — cada autorizador pode mudar) | o rodízio e o disjuntor (D-NE26/D-NE54) partem destes números |
| Cadeia TLS do servidor | PR = AC SOLUTI SSL EV G4 → Raiz ICP-Brasil v10; SVRS = AC SERPRO SSLv1 → Raiz v10 | handshake de 15/10/2026 (README fato 16) | a Raiz v10 sozinha valida as duas; a cadeia é DADO recarregável (D-NE54 (a)) |
| CSRT (responsável técnico) | PR: obrigatório (teste 19/01/2026, produção 23/02/2026) | página CSRT da SEFA-PR (F17) | demais UF e a SVRS para quem não tem IE: não confirmado (D-NE97) |
