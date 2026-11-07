"""Referência neutra das regras fiscais com vetor de teste (fiscal-api/vetores).

Não é código de produto: é a "resposta certa" curta de cada regra, escrita em Python puro (só biblioteca padrão), para
que os vetores JSON possam ser gerados e reverificados. O ERP Desktop (Delphi) e a web (TypeScript) implementam as
mesmas regras e provam que batem lendo os mesmos vetores.

Convenções: valores em reais como Decimal com 2 casas; alíquotas em fração (0.12 = 12%); datas ISO (AAAA-MM-DD);
instantes ISO em UTC (AAAA-MM-DDTHH:MM:SSZ). Cada função cita o ID da regra (REGRAS.md).
"""
from decimal import Decimal as D, ROUND_HALF_UP
import itertools


def r2(x):
    return x.quantize(D('0.01'), rounding=ROUND_HALF_UP)


# --------------------------------------------------------------------------------------------------------------
# RF-PRC-02, RF-PRC-03, RF-PRC-04, RF-BC-04 — conta "por dentro" com o preço final
# (copiada de 02-REFORMA-CONTA-POR-DENTRO-PRECO-FINAL.md §4, sem alteração de lógica)
# --------------------------------------------------------------------------------------------------------------
def conta_por_dentro(P, t, a_ibs, a_cbs, tol=D('0.01')):
    """P = valor cobrado do item (sem IPI); t = alíquota do ICMS; a_ibs, a_cbs = alíquotas efetivas de IBS e CBS.
    Devolve dict com icms, vBC, vIBS, vCBS, vProd, ajusteCentavo (houve ajuste de 1 centavo dentro da tolerância)
    e fecha (vProd + vIBS + vCBS == P)."""
    a = a_ibs + a_cbs
    icms = r2(P * t)
    vprod_real = P - ((P - P * t) / (1 + a)) * a
    centavos = int((vprod_real * 100).to_integral_value())
    melhor = None
    for dv in range(-6, 7):
        vprod = D(centavos + dv) / 100
        vbc = r2(vprod - icms)
        ibs0, cbs0 = r2(vbc * a_ibs), r2(vbc * a_cbs)
        for di, dc in itertools.product((0, 1, -1), (0, 1, -1)):
            ibs, cbs = ibs0 + D(di) / 100, cbs0 + D(dc) / 100
            if abs(ibs - vbc * a_ibs) > tol or abs(cbs - vbc * a_cbs) > tol or ibs < 0 or cbs < 0:
                continue
            chave = (abs(vprod + ibs + cbs - P), abs(di) + abs(dc), abs(dv))
            if melhor is None or chave < melhor[0]:
                melhor = (chave, vprod, vbc, ibs, cbs)
    if melhor is None:
        return None
    chave, vprod, vbc, ibs, cbs = melhor
    # r2 só normaliza a representação a 2 casas ("14" -> "14.00"); a lógica acima não muda
    return {'icms': icms, 'vBC': r2(vbc), 'vIBS': r2(ibs), 'vCBS': r2(cbs), 'vProd': r2(vprod),
            'ajusteCentavo': chave[1] > 0, 'fecha': chave[0] == 0}


# --------------------------------------------------------------------------------------------------------------
# RF-PRC-08 — NFS-e: vTotNF (Anexo VI v1.04.01, regra E1555)
# --------------------------------------------------------------------------------------------------------------
def vtotnf_nfse(op_simp_nac, reg_ap_ibscbs_sn, ano, v_liq, v_cbs, v_ibs_tot):
    """op_simp_nac: 1 não optante, 3 ME/EPP, 4 optante pendente (o MEI, 2, não informa estes campos: E1302).
    reg_ap_ibscbs_sn: 1, 2, 3 (obrigatório com op_simp_nac 3 ou 4; None para 1)."""
    if op_simp_nac == 2:
        raise ValueError('MEI não informa os campos de valores além de vLiq (E1302)')
    if op_simp_nac == 4 and reg_ap_ibscbs_sn in (1, 2):
        # a E1555 escreve "opSimpNac = 1 ou 4 (pendente); ou 3 e regApIBSCBSSN = 3" para o caso regular, mas as regras de
        # gTribSN tratam o pendente (4) com regApIBSCBSSN 1 ou 2 como o ME/EPP: texto ambíguo (NÃO VERIFICADO), fora dos vetores
        raise ValueError('pendente com regApIBSCBSSN 1 ou 2: ambíguo na E1555')
    regular = op_simp_nac in (1, 4) or (op_simp_nac == 3 and reg_ap_ibscbs_sn == 3)
    if regular:
        return r2(v_liq) if ano <= 2026 else r2(v_liq + v_cbs + v_ibs_tot)
    if op_simp_nac == 3 and reg_ap_ibscbs_sn == 1:
        return r2(v_liq)
    if op_simp_nac == 3 and reg_ap_ibscbs_sn == 2:
        return r2(v_liq) if ano <= 2026 else r2(v_liq + v_ibs_tot)
    raise ValueError('combinação sem regra')


# --------------------------------------------------------------------------------------------------------------
# RF-SN-10 — NFS-e: vReceitaBrutaSN (NT 009 v1.01, item 2.4)
# --------------------------------------------------------------------------------------------------------------
def receita_bruta_sn(v_serv, desc_incond, v_calc_ajuste_bc_ibscbs, v_calc_ajuste_bc_issqn, ajuste_profissional_parceiro, tp_rbsn):
    """tp_rbsn: indicador do cClassTrib (0 = não é receita bruta). v_calc_ajuste_bc_issqn só entra quando o ajuste é do tipo
    9 'profissional parceiro'. O tpRBSN 9 (fornecimento incompatível com o SN) não tem fórmula no texto: fora dos vetores."""
    if tp_rbsn == 0:
        return D('0.00')
    if tp_rbsn == 9:
        raise ValueError('tpRBSN 9 sem fórmula no texto')
    r = v_serv - desc_incond - v_calc_ajuste_bc_ibscbs
    if ajuste_profissional_parceiro:
        r -= v_calc_ajuste_bc_issqn
    return r2(r)


# --------------------------------------------------------------------------------------------------------------
# RF-SN-11 — NFS-e: o grupo gTribSN aparece?
# --------------------------------------------------------------------------------------------------------------
def gtribsn_presente(op_simp_nac, reg_ap_ibscbs_sn):
    """Anexo VI: o grupo é destacado quando opSimpNac = 3 ou 4 e regApIBSCBSSN = 1 ou 2; não é destacado com
    opSimpNac 1 ou 2, nem com 3 ou 4 e regApIBSCBSSN = 3."""
    return op_simp_nac in (3, 4) and reg_ap_ibscbs_sn in (1, 2)


# --------------------------------------------------------------------------------------------------------------
# RF-CAL-03, RF-CAL-04 — a partir de que competência a declaração de IBS/CBS é obrigatória (a obrigação legal)
# --------------------------------------------------------------------------------------------------------------
def obrigatoria_a_partir_de(documento, regime, grupo_nfse=None):
    """documento: 'NFe' | 'NFCe' | 'NFSe'; regime: 'normal' | 'simples'; grupo_nfse: 'd' (serviços da alínea d) | 'demais'.
    Ato Conjunto RFB/CGIBS 4/2026, art. 1º e § 1º. O MEI é dispensado de destacar IBS/CBS e fica fora."""
    if regime == 'simples':
        return '2027-01-01'
    if documento in ('NFe', 'NFCe'):
        return '2026-08-03'
    if documento == 'NFSe':
        if grupo_nfse == 'd':
            return '2026-10-01'
        if grupo_nfse == 'demais':
            return '2026-12-01'
    raise ValueError('combinação sem regra')


def obrigatoria(documento, regime, competencia, grupo_nfse=None):
    return competencia >= obrigatoria_a_partir_de(documento, regime, grupo_nfse)


# --------------------------------------------------------------------------------------------------------------
# RF-NFS-02, RF-NFS-03 — qual pacote XSD a autoridade aceita (calendário da nfse-api: layout-calendar.ts)
# --------------------------------------------------------------------------------------------------------------
_LINHAS_LEIAUTE = [
    # (documento, ambiente, validFrom UTC, leiaute, versão)
    ('DPS', 'H', '2000-01-01T00:00:00Z', 'xsd-20260209', '1.01'),
    ('DPS', 'H', '2026-10-20T21:10:00Z', 'xsd-20261020', '1.01'),
    ('DPS', 'P', '2000-01-01T00:00:00Z', 'xsd-20260209', '1.01'),
    ('EVENT', 'H', '2000-01-01T00:00:00Z', 'xsd-20260209', '1.01'),
    ('EVENT', 'P', '2000-01-01T00:00:00Z', 'xsd-20260209', '1.01'),
]


def leiaute(documento, ambiente, instante):
    """documento: 'DPS' | 'EVENT'; ambiente: 'H' homologação | 'P' produção; instante ISO UTC.
    Devolve (leiaute, versão). A versão NUNCA decide o leiaute: os dois pacotes dizem 1.01 e são incompatíveis."""
    achada = None
    for doc, amb, desde, lay, ver in _LINHAS_LEIAUTE:
        if doc == documento and amb == ambiente and desde <= instante:
            achada = (lay, ver)
    if achada is None:
        raise ValueError('sem linha')
    return achada


# --------------------------------------------------------------------------------------------------------------
# RF-BC-03 — NF-e: vBC do IBS/CBS (NT 2025.002 v1.53, UB16-10)
# --------------------------------------------------------------------------------------------------------------
_MAIS = ('vProd', 'vServ', 'vFrete', 'vSeg', 'vOutro', 'vII', 'vIS')
_MENOS = ('vDesc', 'vPIS', 'vCOFINS', 'vICMS', 'vICMSUFDest', 'vFCP', 'vFCPUFDest', 'vICMSMono', 'vISSQN')


def vbc_nfe(campos):
    """campos: dict com os valores presentes (ausente = 0).
    NÃO cobre as exceções 1 e 2 da UB16-10 (não subtrair o PIS/COFINS por substituição tributária quando compõem o total da
    NF-e, indSomaPISST/indSomaCOFINSST = 1): a NT marca a regra como "implementação futura, aguardando orientação normativa"."""
    g = lambda k: D(campos.get(k, '0'))
    return r2(sum(g(k) for k in _MAIS) - sum(g(k) for k in _MENOS))


# --------------------------------------------------------------------------------------------------------------
# RF-CLS-02 — CST é o prefixo de 3 dígitos do cClassTrib (E0959)
# --------------------------------------------------------------------------------------------------------------
def cst_de(c_class_trib):
    return c_class_trib[:3]


# --------------------------------------------------------------------------------------------------------------
# RF-DEV-03 — chave referenciada no cabeçalho OU no item, nunca nos dois (VC02-14)
# --------------------------------------------------------------------------------------------------------------
def chave_referenciada_valida(no_cabecalho, no_item):
    """Só os casos que a NT diz: um dos dois (válido) ou os dois (inválido). Nenhum dos dois não tem texto na regra."""
    if no_cabecalho and no_item:
        return False
    if no_cabecalho or no_item:
        return True
    raise ValueError('nenhuma chave: sem texto na regra VC02-14')
