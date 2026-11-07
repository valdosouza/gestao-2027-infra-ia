"""Gera os vetores JSON a partir da referência e os reverifica.

Uso (da pasta fiscal-api/vetores/referencia):
    python gerar_e_verificar.py gerar       # reescreve os JSON de ../*.json a partir da referência
    python gerar_e_verificar.py verificar   # recalcula cada caso e compara com o JSON; confere as propriedades

Só biblioteca padrão. Os JSON são a fonte que o Delphi e a web leem; esta referência prova que eles são consistentes.
"""
import json, os, random, sys
from decimal import Decimal as D
import referencia as R

AQUI = os.path.dirname(os.path.abspath(__file__))
SAIDA = os.path.dirname(AQUI)

CONVENCAO = {
    'numeros': 'valores e alíquotas são STRINGS decimais (nunca número JSON), para não perder precisão; reais com 2 casas',
    'aliquotas': 'fração decimal: "0.12" = 12%',
    'datas': 'AAAA-MM-DD; instantes em UTC: AAAA-MM-DDTHH:MM:SSZ',
    'grau': 'T = escrito na norma · L = leitura nossa · E = observado em homologação ou produção',
}


def s(x):
    return format(x, 'f') if isinstance(x, D) else x


def grava(nome, obj):
    with open(os.path.join(SAIDA, nome), 'w', encoding='utf-8', newline='\n') as f:
        json.dump(obj, f, ensure_ascii=False, indent=2)
        f.write('\n')


# ------------------------------------------------------------------ conta por dentro
VETORES_DOC02 = [  # (P, ICMS %, CBS %) — a tabela do documento 02 §4, IBS 0,1%
    ('123.64', '0.12', '0.087', 'Exemplo oficial da SEFA-PR (Consulta 48/2026): preço 123,64, ICMS 14,84, base 100,00, IBS 0,10, CBS 8,70, vProd 114,84'),
    ('100.00', '0', '0.087', 'ICMS zero (Simples com regime regular de IBS/CBS)'),
    ('1000.00', '0.17', '0.112', 'CBS de 11,2%'),
    ('59.90', '0.18', '0.087', 'Preço com centavos'),
    ('15.37', '0.12', '0.112', ''),
    ('2499.99', '0.195', '0.087', 'Caso que exige o ajuste de 1 centavo dentro da tolerância de 0,01'),
    ('0.99', '0.07', '0.087', 'Valor muito pequeno'),
    ('987.65', '0.04', '0.112', ''),
]
A_IBS = D('0.001')


def caso_cpd(i, P, t, a_cbs, desc, fonte):
    r = R.conta_por_dentro(D(P), D(t), A_IBS, D(a_cbs))
    return {
        'id': 'CPD-%03d' % i, 'descricao': desc, 'grau': 'L', 'fonte': fonte,
        'entrada': {'P': P, 'aliquotaICMS': t, 'aliquotaIBS': s(A_IBS), 'aliquotaCBS': a_cbs},
        'saida': {'icms': s(r['icms']), 'vBC': s(r['vBC']), 'vIBS': s(r['vIBS']), 'vCBS': s(r['vCBS']),
                  'vProd': s(r['vProd']), 'ajusteCentavo': r['ajusteCentavo'], 'fecha': r['fecha']},
    }


def gera_cpd():
    casos = []
    for i, (P, t, c, d) in enumerate(VETORES_DOC02, 1):
        casos.append(caso_cpd(i, P, t, c, d, '02-REFORMA-CONTA-POR-DENTRO-PRECO-FINAL.md §3 e §4 (vetores do documento)'))
    rnd = random.Random(20261107)
    n = len(casos)
    while len(casos) < 48:
        P = '%d.%02d' % (rnd.choice([0, 1, 5, 9, 12, 33, 59, 100, 250, 999, 1500, 8000, 12345]), rnd.randint(0, 99))
        if D(P) == 0:
            continue
        t = rnd.choice(['0', '0.04', '0.07', '0.12', '0.17', '0.18', '0.195'])
        c = rnd.choice(['0.087', '0.112'])
        n += 1
        casos.append(caso_cpd(n, P, t, c, 'Gerado com semente fixa (20261107) pela referência', 'referencia.py (conta_por_dentro)'))
    return {
        'funcao': 'contaPorDentro', 'versao': 1,
        'regras': ['RF-PRC-02', 'RF-PRC-03', 'RF-PRC-04', 'RF-BC-04'],
        'convencao': CONVENCAO,
        'descricao': 'Item de NF-e ou NFC-e do regime normal com o preço final como entrada (IBS e CBS dentro do preço, ICMS por dentro). '
                     'Entrada: valor cobrado do item P (sem IPI), alíquota do ICMS e alíquotas efetivas de IBS e CBS. '
                     'Saída: ICMS, base do IBS/CBS, IBS, CBS e vProd líquido, fechando vProd + vIBS + vCBS = P com a tolerância de 0,01 da NT (UB35-10).',
        'propriedades': ['vProd + vIBS + vCBS == P em todos os casos (fecha = true)',
                         'vIBS e vCBS ficam a no máximo 0,01 de vBC x alíquota (tolerância da NT)',
                         'icms == P x aliquotaICMS arredondado a 2 casas (meio para cima)'],
        'casos': casos,
    }


# ------------------------------------------------------------------ NFS-e: vTotNF
def gera_vtotnf():
    casos = []
    def add(desc, op, reg, ano, liq, cbs, ibs, regra_txt):
        v = R.vtotnf_nfse(op, reg, ano, D(liq), D(cbs), D(ibs))
        casos.append({'id': 'VTN-%03d' % (len(casos) + 1), 'descricao': desc, 'grau': 'T', 'fonte': 'Anexo VI v1.04.01, regra E1555 (' + regra_txt + ')',
                      'entrada': {'opSimpNac': op, 'regApIBSCBSSN': reg, 'anoCompetencia': ano, 'vLiq': liq, 'vCBS': cbs, 'vIBSTot': ibs},
                      'saida': {'vTotNF': s(v)}})
    add('Não optante em 2026: IBS/CBS não somam', 1, None, 2026, '1000.00', '9.00', '1.00', 'não optante, 2026')
    add('Não optante em 2027: soma CBS e IBS por fora', 1, None, 2027, '1000.00', '90.00', '10.00', 'não optante, 2027')
    add('Optante pendente em 2027 sem regime informado: como o regular', 4, None, 2027, '500.00', '45.00', '5.00', 'pendente, 2027')
    add('ME/EPP com IBS e CBS no regime regular (regApIBSCBSSN 3) em 2026', 3, 3, 2026, '1000.00', '9.00', '1.00', 'ME/EPP regime regular, 2026')
    add('ME/EPP com IBS e CBS no regime regular (regApIBSCBSSN 3) em 2027', 3, 3, 2027, '1000.00', '90.00', '10.00', 'ME/EPP regime regular, 2027')
    add('ME/EPP com IBS e CBS no Simples (regApIBSCBSSN 1) em 2026', 3, 1, 2026, '1000.00', '0.00', '0.00', 'ME/EPP no Simples, 2026')
    add('ME/EPP com IBS e CBS no Simples (regApIBSCBSSN 1) em 2027: vTotNF = vLiq', 3, 1, 2027, '1000.00', '0.00', '0.00', 'ME/EPP no Simples, 2027')
    add('ME/EPP com CBS no Simples e IBS regular (regApIBSCBSSN 2) em 2026', 3, 2, 2026, '1000.00', '0.00', '10.00', 'ME/EPP CBS no SN, 2026')
    add('ME/EPP com CBS no Simples e IBS regular (regApIBSCBSSN 2) em 2027: soma só o IBS', 3, 2, 2027, '1000.00', '0.00', '10.00', 'ME/EPP CBS no SN, 2027')
    # observado em H (2026): vTotNF = vLiq; nota 8014 da nfse-api (valores de teste de 2026)
    casos.append({'id': 'VTN-%03d' % (len(casos) + 1), 'descricao': 'Observado em homologação (nota 8014 da nfse-api, 01/11/2026): R$ 10,00 de serviço, o fisco devolveu vIBSTot 0,01 e vCBS 0,09 e vTotNF 10,00 em 2026',
                  'grau': 'E', 'fonte': 'prova em H de 01/11/2026 (prompt_fase_ibs_cbs.md §13.8)',
                  'entrada': {'opSimpNac': 1, 'regApIBSCBSSN': None, 'anoCompetencia': 2026, 'vLiq': '10.00', 'vCBS': '0.09', 'vIBSTot': '0.01'},
                  'saida': {'vTotNF': '10.00'}})
    return {'funcao': 'vTotNFnfse', 'versao': 1, 'regras': ['RF-PRC-08'], 'convencao': CONVENCAO,
            'descricao': 'Valor total da NFS-e com IBS e CBS por fora. Não cobre o MEI (opSimpNac 2, E1302) nem o pendente com regApIBSCBSSN 1 ou 2 (texto ambíguo na E1555).',
            'casos': casos}


# ------------------------------------------------------------------ NFS-e: Simples
def gera_simples():
    rb = []
    def add_rb(desc, vserv, desc_inc, aj_ibscbs, aj_issqn, parceiro, tp):
        v = R.receita_bruta_sn(D(vserv), D(desc_inc), D(aj_ibscbs), D(aj_issqn), parceiro, tp)
        rb.append({'id': 'RBS-%03d' % (len(rb) + 1), 'descricao': desc, 'grau': 'T', 'fonte': 'NT 009 v1.01, item 2.4 (vReceitaBrutaSN)',
                   'entrada': {'vServ': vserv, 'descIncond': desc_inc, 'vCalcAjusteBCIBSCBS': aj_ibscbs, 'vCalcAjusteBCISSQN': aj_issqn,
                               'ajusteProfissionalParceiro': parceiro, 'tpRBSN': tp},
                   'saida': {'vReceitaBrutaSN': s(v)}})
    add_rb('Receita interna sem descontos nem ajustes', '1000.00', '0.00', '0.00', '0.00', False, 1)
    add_rb('Desconto incondicional sai da receita', '1000.00', '100.00', '0.00', '0.00', False, 1)
    add_rb('Ajuste da base do IBS/CBS sai da receita', '1000.00', '0.00', '200.00', '0.00', False, 1)
    add_rb('Ajuste da base do ISSQN só entra com profissional parceiro (tipo 9): aqui NÃO entra', '1000.00', '0.00', '0.00', '300.00', False, 1)
    add_rb('Com profissional parceiro (tipo 9) o ajuste do ISSQN entra', '1000.00', '0.00', '0.00', '300.00', True, 1)
    add_rb('Exportação direta (tpRBSN 3) segue a mesma fórmula', '2500.00', '0.00', '0.00', '0.00', False, 3)
    add_rb('tpRBSN 0 (não é receita bruta): vale zero, mesmo com serviço', '1000.00', '0.00', '0.00', '0.00', False, 0)
    gt = []
    for op in (1, 2, 3, 4):
        for reg in ((None,) if op in (1, 2) else (1, 2, 3)):
            gt.append({'id': 'GTS-%03d' % (len(gt) + 1), 'descricao': 'O grupo gTribSN aparece? opSimpNac %s, regApIBSCBSSN %s' % (op, reg),
                       'grau': 'T', 'fonte': 'Anexo VI v1.04.01, regras de gTribSN',
                       'entrada': {'opSimpNac': op, 'regApIBSCBSSN': reg}, 'saida': {'gTribSNPresente': R.gtribsn_presente(op, reg)}})
    return {'funcao': 'simplesNFSe', 'versao': 1, 'regras': ['RF-SN-10', 'RF-SN-11'], 'convencao': CONVENCAO,
            'descricao': 'NFS-e do Simples Nacional pela NT 009 v1.01: valor da receita bruta e presença do grupo gTribSN. '
                         'Não cobre o tpRBSN 9 (sem fórmula no texto) nem o arredondamento de vIBSSN e vCBSSN (não especificado).',
            'casosReceitaBruta': rb, 'casosGTribSN': gt}


# ------------------------------------------------------------------ obrigatoriedade
def gera_obrigatoriedade():
    casos = []
    def add(doc, regime, grupo, comp, desc):
        ini = R.obrigatoria_a_partir_de(doc, regime, grupo)
        casos.append({'id': 'OBR-%03d' % (len(casos) + 1), 'descricao': desc, 'grau': 'T', 'fonte': 'Ato Conjunto RFB/CGIBS 4/2026, art. 1º e § 1º',
                      'entrada': {'documento': doc, 'regime': regime, 'grupoNFSe': grupo, 'competencia': comp},
                      'saida': {'obrigatoria': R.obrigatoria(doc, regime, comp, grupo), 'obrigatoriaAPartirDe': ini}})
    add('NFe', 'normal', None, '2026-08-02', 'NF-e do regime normal na véspera')
    add('NFe', 'normal', None, '2026-08-03', 'NF-e do regime normal no primeiro dia')
    add('NFCe', 'normal', None, '2026-09-15', 'NFC-e do regime normal')
    add('NFSe', 'normal', 'd', '2026-09-30', 'NFS-e de serviço da alínea d na véspera')
    add('NFSe', 'normal', 'd', '2026-10-01', 'NFS-e de serviço da alínea d no primeiro dia')
    add('NFSe', 'normal', 'demais', '2026-11-30', 'NFS-e dos demais serviços na véspera')
    add('NFSe', 'normal', 'demais', '2026-12-01', 'NFS-e dos demais serviços no primeiro dia')
    add('NFe', 'simples', None, '2026-12-31', 'NF-e do Simples na véspera de 2027')
    add('NFe', 'simples', None, '2027-01-01', 'NF-e do Simples em 01/01/2027')
    add('NFSe', 'simples', None, '2026-11-15', 'NFS-e do Simples em 11/2026: ainda não obrigatória')
    add('NFSe', 'simples', None, '2027-01-01', 'NFS-e do Simples em 01/01/2027')
    observados = [{
        'id': 'OBS-001', 'grau': 'E',
        'descricao': 'Observado em H (nota 8015 da nfse-api, 01/11/2026): NFS-e de optante do Simples com competência 11/2026 e SEM o grupo IBS/CBS foi AUTORIZADA; a regra E0855 (obrigatório desde 01/10/2026) não recusou',
        'fonte': 'prova em H de 01/11/2026 (prompt_fase_ibs_cbs.md §13.8, D-IB114)',
        'entrada': {'ambiente': 'H', 'pacote': 'xsd-20261020', 'regime': 'simples', 'competencia': '2026-11', 'grupoDeclarado': False},
        'saida': {'autorizada': True}},
        {'id': 'OBS-002', 'grau': 'E',
         'descricao': 'Observado em H (nota 8014, 01/11/2026): com o grupo declarado vazio (<gIBSCBS/>) depois de CST e cClassTrib a NFS-e foi AUTORIZADA (E0960 não disparou)',
         'fonte': 'prova em H de 01/11/2026 (D-IB112)',
         'entrada': {'ambiente': 'H', 'pacote': 'xsd-20261020', 'grupoDeclarado': True, 'gIBSCBS': 'vazio'}, 'saida': {'autorizada': True}}]
    return {'funcao': 'obrigatoriedadeIBSCBS', 'versao': 1, 'regras': ['RF-CAL-03', 'RF-CAL-04', 'RF-NFS-07'], 'convencao': CONVENCAO,
            'descricao': 'A partir de que competência a declaração de IBS/CBS é OBRIGATÓRIA (a obrigação legal, por documento e regime). O MEI é dispensado e fica fora. '
                         'A obrigação legal não é a rejeição do fisco: os casos "observados" registram o que a autoridade fez em homologação.',
            'casos': casos, 'observados': observados}


# ------------------------------------------------------------------ calendário de leiaute
def gera_leiaute():
    casos = []
    def add(doc, amb, inst, desc):
        lay, ver = R.leiaute(doc, amb, inst)
        casos.append({'id': 'LAY-%03d' % (len(casos) + 1), 'descricao': desc, 'grau': 'E', 'fonte': 'nfse-api, layout-calendar.ts (D-IB110, D-IB111); portal da NFS-e',
                      'entrada': {'documento': doc, 'ambiente': amb, 'instante': inst}, 'saida': {'leiaute': lay, 'versao': ver}})
    add('DPS', 'H', '2026-10-20T21:09:59Z', 'DPS em H um segundo antes da troca (20/10/2026 18h10 de Brasília = 21:10 UTC)')
    add('DPS', 'H', '2026-10-20T21:10:00Z', 'DPS em H na troca: pacote de 20/10/2026')
    add('DPS', 'H', '2026-11-01T14:53:00Z', 'DPS em H no dia da prova (notas 8014 e 8015)')
    add('DPS', 'P', '2026-11-07T12:00:00Z', 'DPS em produção segue o pacote de 09/02/2026 até o fisco anunciar')
    add('EVENT', 'H', '2026-11-01T14:53:00Z', 'Pedido de evento em H: o mesmo pacote de 09/02/2026')
    add('EVENT', 'P', '2026-11-07T12:00:00Z', 'Pedido de evento em produção')
    return {'funcao': 'leiauteNFSe', 'versao': 1, 'regras': ['RF-NFS-02', 'RF-NFS-03'], 'convencao': CONVENCAO,
            'descricao': 'Qual pacote XSD a autoridade aceita por documento, ambiente e instante. A versão ("1.01") é igual nos dois pacotes e NUNCA decide o leiaute. '
                         'Estado de 01/11/2026: se a produção adotar o pacote novo, entra uma linha nova por deploy antes da data anunciada.',
            'casos': casos}


# ------------------------------------------------------------------ NF-e: vBC, CST, chave referenciada
def gera_nfe_diversos():
    vbc = []
    def add_vbc(desc, campos):
        v = R.vbc_nfe(campos)
        vbc.append({'id': 'VBC-%03d' % (len(vbc) + 1), 'descricao': desc, 'grau': 'T', 'fonte': 'NT 2025.002 v1.53, regra UB16-10',
                    'entrada': campos, 'saida': {'vBC': s(v)}})
    add_vbc('Só o produto', {'vProd': '100.00'})
    add_vbc('Produto, frete e seguro, menos desconto', {'vProd': '100.00', 'vFrete': '10.00', 'vSeg': '2.00', 'vDesc': '5.00'})
    add_vbc('Tira ICMS, PIS e COFINS', {'vProd': '1000.00', 'vICMS': '170.00', 'vPIS': '16.50', 'vCOFINS': '76.00'})
    add_vbc('Soma o Imposto Seletivo e o imposto de importação', {'vProd': '500.00', 'vII': '50.00', 'vIS': '25.00', 'vICMS': '90.00'})
    add_vbc('Serviço (vServ) com ISSQN', {'vServ': '800.00', 'vISSQN': '40.00', 'vOutro': '10.00'})
    add_vbc('Tira o ICMS monofásico (vICMSMono), que a UB16-10 também subtrai', {'vProd': '300.00', 'vICMSMono': '24.00'})
    cst = []
    for c, d in [('000001', 'Situações tributadas integralmente pelo IBS e CBS'), ('200046', 'Operações com bens imóveis'),
                 ('200052', 'Prestação de serviços de profissões intelectuais'), ('820007', 'Documento com informações de fornecimento de serviços financeiros'),
                 ('811003', 'Desenquadramento do Simples')]:
        cst.append({'id': 'CST-%03d' % (len(cst) + 1), 'descricao': d, 'grau': 'T', 'fonte': 'Anexo VI, regra E0959 (CST = prefixo do cClassTrib)',
                    'entrada': {'cClassTrib': c}, 'saida': {'CST': R.cst_de(c)}})
    ch = []
    for cab, item, d in [(True, False, 'Chave só no cabeçalho (refNFe)'), (False, True, 'Chave só no item (DFeReferenciado)'),
                         (True, True, 'Chave nos dois lugares: inválida (VC02-14)')]:
        ch.append({'id': 'CHV-%03d' % (len(ch) + 1), 'descricao': d, 'grau': 'T', 'fonte': 'NT 2025.002 v1.53, regra VC02-14',
                   'entrada': {'refNFeNoCabecalho': cab, 'dfeReferenciadoNoItem': item}, 'saida': {'valida': R.chave_referenciada_valida(cab, item)}})
    return {'funcao': 'nfeDiversos', 'versao': 1, 'regras': ['RF-BC-03', 'RF-CLS-02', 'RF-DEV-03'], 'convencao': CONVENCAO,
            'descricao': 'Regras curtas da NF-e e da classificação: base do IBS/CBS (UB16-10), CST como prefixo do cClassTrib (E0959) e chave referenciada na devolução (VC02-14). '
                         'Fora dos vetores: o caso "nenhuma chave" (sem texto na VC02-14) e as exceções 1 e 2 da UB16-10 (PIS/COFINS por substituição tributária com '
                         'indSomaPISST/indSomaCOFINSST = 1), que a NT marca como "implementação futura, aguardando orientação normativa".',
            'casosVBC': vbc, 'casosCST': cst, 'casosChaveReferenciada': ch}


ARQUIVOS = {
    'conta-por-dentro.json': gera_cpd,
    'nfse-vtotnf.json': gera_vtotnf,
    'nfse-simples.json': gera_simples,
    'obrigatoriedade.json': gera_obrigatoriedade,
    'leiaute-nfse.json': gera_leiaute,
    'nfe-diversos.json': gera_nfe_diversos,
}


def gerar():
    for nome, f in ARQUIVOS.items():
        obj = f()
        grava(nome, obj)
        n = sum(len(v) for k, v in obj.items() if k.startswith('casos') or k == 'observados')
        print('gerado', nome, n, 'casos')


# ------------------------------------------------------------------ verificação
def carrega(nome):
    with open(os.path.join(SAIDA, nome), encoding='utf-8') as f:
        return json.load(f)


def todos_casos(obj):
    for k, v in obj.items():
        if k.startswith('casos'):
            for c in v:
                yield c


def verificar():
    falhas = 0
    total = 0
    # 1) cada JSON coincide com o que a referência gera agora
    for nome, f in ARQUIVOS.items():
        atual = carrega(nome)
        novo = json.loads(json.dumps(f(), ensure_ascii=False))
        total += 1
        if atual != novo:
            falhas += 1
            print('DIFERENTE da referência:', nome)
        else:
            print('ok   ', nome)
    # 2) vetores do documento 02 batem com a tabela publicada
    esperado = {  # P: (icms, vBC, vIBS, vCBS, vProd, ajuste) — tabela do documento 02 §4
        '123.64': ('14.84', '100.00', '0.10', '8.70', '114.84', False), '100.00': ('0.00', '91.91', '0.09', '8.00', '91.91', False),
        '1000.00': ('170.00', '745.73', '0.75', '83.52', '915.73', False), '59.90': ('10.78', '45.14', '0.05', '3.93', '55.92', False),
        '15.37': ('1.84', '12.16', '0.01', '1.36', '14.00', False), '2499.99': ('487.50', '1849.71', '1.85', '160.93', '2337.21', True),
        '0.99': ('0.07', '0.85', '0.00', '0.07', '0.92', False), '987.65': ('39.51', '851.88', '0.85', '95.41', '891.39', False)}
    cpd = carrega('conta-por-dentro.json')['casos']
    for c in cpd[:8]:
        e = esperado[c['entrada']['P']]
        o = c['saida']
        got = (o['icms'], o['vBC'], o['vIBS'], o['vCBS'], o['vProd'], o['ajusteCentavo'])
        total += 1
        if got != e:
            falhas += 1
            print('DOC 02 divergente em P =', c['entrada']['P'], got, e)
    print('vetores do doc 02 conferidos com a tabela publicada: %d' % min(8, len(cpd)))
    # 3) propriedades da conta por dentro nos casos e em 30.000 itens aleatórios
    for c in cpd:
        e, o = c['entrada'], c['saida']
        total += 1
        P = D(e['P'])
        soma = D(o['vProd']) + D(o['vIBS']) + D(o['vCBS'])
        if soma != P or not o['fecha'] or D(o['icms']) != R.r2(P * D(e['aliquotaICMS'])):
            falhas += 1
            print('propriedade quebrada em', c['id'])
    rnd = random.Random(7)
    fechou = ajustou = 0
    N = 30000
    for _ in range(N):
        P = D(rnd.randint(1, 500000)) / 100
        t = D(str(rnd.choice([0, 0.04, 0.07, 0.12, 0.17, 0.18, 0.195])))
        cbs = D(str(rnd.choice([0.087, 0.112])))
        r = R.conta_por_dentro(P, t, A_IBS, cbs)
        if r and r['fecha']:
            fechou += 1
            ajustou += 1 if r['ajusteCentavo'] else 0
    print('30.000 itens aleatórios: fecharam %d (%.2f%%); usaram o ajuste de 1 centavo: %.1f%%' % (fechou, 100.0 * fechou / N, 100.0 * ajustou / N))
    total += 1
    if fechou != N:
        falhas += 1
        print('NEM TODOS FECHAM: %d de %d' % (fechou, N))
    # 4) sem número JSON solto onde deveria ser string
    for nome in ARQUIVOS:
        txt = open(os.path.join(SAIDA, nome), encoding='utf-8').read()
        total += 1
        if '"P": ' in txt and '"P": "' not in txt:
            falhas += 1
            print('número JSON solto em', nome)
    print('verificações: %d, falhas: %d' % (total, falhas))
    return falhas


if __name__ == '__main__':
    modo = sys.argv[1] if len(sys.argv) > 1 else 'verificar'
    if modo == 'gerar':
        gerar()
    else:
        sys.exit(1 if verificar() else 0)
