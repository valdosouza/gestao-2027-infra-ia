# CONTEXTO

Sou desenvolvedor na Setes, empresa que cria e usa seu próprio ERP.
Precisamos definir a arquitetura macro de uma plataforma multi-tenant
para atender entre 200 e 1.000 clientes empresariais.

Temos algumas implementações parciais (não em produção) que precisam
ser consolidadas em uma direção clara.

---

# STACK DEFINIDA

- Backend: Node.js / TypeScript
- Banco central: MySQL (multi-tenant via schema por cliente)
- Banco local dos clientes: Firebird (precisa sincronizar com o central)
- Acesso atual dos clientes: Sistema Desktop instalado
- Equipe: 4 a 10 desenvolvedores
- Prazo: meses para estruturar (não é emergência, mas tem urgência moderada)

---

# MODELO DE NEGÓCIO

- A Setes tem módulos exclusivos, incluindo controle de features por cliente
- Cada cliente usa um core compartilhado + módulos habilitados via feature flags
- Clientes não devem ter acesso ao código ou dados uns dos outros
- A Setes é também usuária do próprio sistema

---

# APIS IDENTIFICADAS

Temos os seguintes domínios que precisam de API:

1. API de Sincronização — sincroniza Firebird local com MySQL central
2. API ERP — atende o sistema web e futuros aplicativos mobile
3. API Core — funcionalidades base compartilhadas por todos os clientes
4. APIs de Módulos — funcionalidades específicas habilitadas por cliente

---

# PROBLEMAS A EVITAR

- Código morto para clientes que não usam certo módulo
- Dificuldade em atualizar código compartilhado sem quebrar clientes
- Inconsistência entre schemas de banco dos diferentes clientes
- Dependência excessiva entre módulos dificultando manutenção

---

# O QUE PRECISO COMO RESPOSTA

Quero apenas a arquitetura geral (visão macro), incluindo:

1. Estrutura recomendada das APIs (monolito modular, microsserviços
   ou API Gateway) — com justificativa para uma equipe de 4-10 devs
2. Como organizar o multi-tenant com schema por cliente no MySQL,
   mantendo migrações consistentes em escala
3. Como estruturar o feature flag para controle de módulos por cliente
4. Como a API de Sincronização (Firebird → MySQL) deve se encaixar
   na arquitetura geral
5. Principais riscos desta abordagem e como mitigá-los

Não preciso de código ainda. Quero diagramas textuais e explicações
claras que eu possa apresentar para minha equipe e usar como base
para decisões técnicas nas próximas semanas.