"""Calendário único de fatos com data (fiscal-api/calendario).

Uso (da pasta fiscal-api/calendario):
    python calendario.py gerar       # reescreve CALENDARIO.md (a linha do tempo legível) a partir de fatos.json
    python calendario.py verificar   # confere a integridade de fatos.json e se CALENDARIO.md está em dia; código 0 se tudo ok

fatos.json é a FONTE; CALENDARIO.md é gerado. Só biblioteca padrão.
"""
import json, os, re, sys
from datetime import date, datetime
from decimal import Decimal as D

AQUI = os.path.dirname(os.path.abspath(__file__))
FATOS = os.path.join(AQUI, 'fatos.json')
CAL_MD = os.path.join(AQUI, 'CALENDARIO.md')
REGRAS = os.path.join(os.path.dirname(AQUI), 'regras', 'REGRAS.md')

GRAUS = ('T', 'L', 'E', 'N')
SECOES = {'obrigatoriedade': 'OBR', 'leiaute': 'LAY', 'transicao': 'TRN', 'marcos': 'MRC'}
OBRIGATORIOS = {
    'obrigatoriedade': ('id', 'documento', 'regime', 'aPartirDe', 'regras', 'fonte', 'grau'),
    'leiaute': ('id', 'documento', 'ambiente', 'validFrom', 'leiaute', 'versao', 'regras', 'fonte', 'grau'),
    'transicao': ('id', 'ano', 'tributo', 'tipo', 'regras', 'fonte', 'grau'),
    'marcos': ('id', 'data', 'tipo', 'titulo', 'regras', 'fonte', 'grau'),
}


def carrega():
    with open(FATOS, encoding='utf-8') as f:
        return json.load(f)


def itens(c):
    for secao in SECOES:
        for it in c.get(secao, []):
            yield secao, it


def data_de(secao, it):
    if secao == 'obrigatoriedade':
        return it['aPartirDe']
    if secao == 'leiaute':
        return it['validFrom'][:10] if not it['validFrom'].startswith('2000-01-01') else '2000-01-01'
    if secao == 'transicao':
        return '%d-01-01' % it['ano']
    return it['data']


def pct(v):
    return format((D(v) * 100).normalize(), 'f').replace('.', ',') + '%'


def titulo_de(secao, it):
    if secao == 'obrigatoriedade':
        doc = 'todos os documentos' if it['documento'] == '*' else it['documento']
        extra = []
        if it.get('grupoNFSe'):
            extra.append('serviços ' + ('da alínea d' if it['grupoNFSe'] == 'd' else 'demais'))
        if it.get('condicao'):
            extra.append(it['condicao'])
        e = (', ' + ', '.join(extra)) if extra else ''
        return 'Obrigatória a declaração de IBS/CBS: %s (regime %s%s)' % (doc, it['regime'], e)
    if secao == 'leiaute':
        quando = 'desde o primeiro envio' if it['validFrom'].startswith('2000-01-01') else 'a partir de ' + it['validFrom']
        return 'Leiaute %s em %s: %s, versão %s (%s)' % (it['documento'], it['ambiente'], it['leiaute'], it['versao'], quando)
    if secao == 'transicao':
        t, v = it['tipo'], it.get('valor')
        if t == 'aliquota':
            what = 'alíquota de ' + pct(v)
        elif t == 'reducao':
            what = 'reduzido em ' + pct(v)
        elif t == 'referenciaMenos':
            what = 'alíquota de referência menos ' + pct(v).replace('%', ' p.p.')
        else:
            what = 'extinto'
        return '%d: %s %s — %s' % (it['ano'], it['tributo'], what, it.get('observacao') or '')
    return it['titulo'] + ((' — ' + it['observacao']) if it.get('observacao') else '')


def gerar_md(c):
    linhas = []
    for secao, it in itens(c):
        linhas.append((data_de(secao, it), SECOES[secao], it['id'], titulo_de(secao, it), it['grau'], it['regras'], it['fonte']))
    linhas.sort(key=lambda x: (x[0], x[2]))
    out = []
    out.append('# fiscal-api/calendario — linha do tempo dos fatos com data')
    out.append('')
    out.append('**Gerado a partir de [`fatos.json`](fatos.json) em %s. Não edite este arquivo: edite o JSON e rode `python calendario.py gerar`.**' % c['atualizadoEm'])
    out.append('**Grau:** T escrito na norma ou no portal oficial · L leitura nossa · E observado em homologação ou produção · N não verificado ou a conferir. **Regras:** os IDs do catálogo (`../regras/REGRAS.md`).')
    out.append('')
    out.append('| Data | ID | O quê | Grau | Regras | Fonte |')
    out.append('|---|---|---|---|---|---|')
    for data, tipo, i, t, g, regras, fonte in linhas:
        d = 'desde sempre' if data == '2000-01-01' else data
        out.append('| %s | %s | %s | %s | %s | %s |' % (d, i, t.replace('|', '/'), g, ', '.join(regras), fonte.replace('|', '/')))
    out.append('')
    return '\n'.join(out)


def regras_do_catalogo():
    txt = open(REGRAS, encoding='utf-8').read()
    return set(re.findall(r'\| (RF-[A-Z]+-\d+) \|', txt))


def verificar():
    c = carrega()
    erros = []
    conhecidas = regras_do_catalogo()
    vistos = set()
    n = 0
    for secao, it in itens(c):
        n += 1
        i = it.get('id', '?')
        for campo in OBRIGATORIOS[secao]:
            if campo not in it:
                erros.append('%s: falta o campo %s' % (i, campo))
        if i in vistos:
            erros.append('%s: ID repetido' % i)
        vistos.add(i)
        if not re.fullmatch(r'FT-%s-\d{2}' % SECOES[secao], i):
            erros.append('%s: ID fora do padrão FT-%s-NN' % (i, SECOES[secao]))
        if it.get('grau') not in GRAUS:
            erros.append('%s: grau inválido %r' % (i, it.get('grau')))
        try:
            d = data_de(secao, it)
            date.fromisoformat(d)
            if secao == 'leiaute':
                datetime.strptime(it['validFrom'], '%Y-%m-%dT%H:%M:%SZ')
        except Exception as e:
            erros.append('%s: data inválida (%s)' % (i, e))
        for r in it.get('regras', []):
            if r not in conhecidas:
                erros.append('%s: regra %s não existe no catálogo' % (i, r))
        if not it.get('fonte'):
            erros.append('%s: sem fonte' % i)
    chaves = set()
    for it in c['obrigatoriedade']:
        k = (it['documento'], it['regime'], it.get('grupoNFSe'), it.get('condicao'))
        if k in chaves:
            erros.append('obrigatoriedade repetida para %s' % (k,))
        chaves.add(k)
    por = {}
    for it in c['leiaute']:
        por.setdefault((it['documento'], it['ambiente']), []).append(it['validFrom'])
    for k, v in por.items():
        if v != sorted(v) or len(set(v)) != len(v):
            erros.append('leiaute %s: validFrom fora de ordem ou repetido' % (k,))
    esperado = gerar_md(c)
    atual = open(CAL_MD, encoding='utf-8').read() if os.path.exists(CAL_MD) else ''
    if atual != esperado:
        erros.append('CALENDARIO.md está desatualizado: rode "python calendario.py gerar"')
    print('fatos: %d (obrigatoriedade %d, leiaute %d, transição %d, marcos %d); regras do catálogo: %d' % (
        n, len(c['obrigatoriedade']), len(c['leiaute']), len(c['transicao']), len(c['marcos']), len(conhecidas)))
    for e in erros:
        print('ERRO:', e)
    print('verificação do calendário: %d erro(s)' % len(erros))
    return len(erros)


if __name__ == '__main__':
    modo = sys.argv[1] if len(sys.argv) > 1 else 'verificar'
    if modo == 'gerar':
        with open(CAL_MD, 'w', encoding='utf-8', newline='\n') as f:
            f.write(gerar_md(carrega()))
        print('CALENDARIO.md gerado')
    else:
        sys.exit(1 if verificar() else 0)
