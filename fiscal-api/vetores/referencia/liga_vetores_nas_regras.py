"""Preenche a coluna "Vetor" de regras/REGRAS.md com o arquivo de vetores de cada regra (uso único, idempotente)."""
import re, os, sys
AQUI = os.path.dirname(os.path.abspath(__file__))
REGRAS = os.path.join(os.path.dirname(os.path.dirname(AQUI)), 'regras', 'REGRAS.md')
MAPA = {
    'RF-BC-04': '`vetores/conta-por-dentro.json`',
    'RF-PRC-02': '`vetores/conta-por-dentro.json`',
    'RF-PRC-03': '`vetores/conta-por-dentro.json`',
    'RF-PRC-04': '`vetores/conta-por-dentro.json`',
    'RF-PRC-08': '`vetores/nfse-vtotnf.json`',
    'RF-SN-10': '`vetores/nfse-simples.json`',
    'RF-SN-11': '`vetores/nfse-simples.json` (presença)',
    'RF-CAL-03': '`vetores/obrigatoriedade.json`',
    'RF-CAL-04': '`vetores/obrigatoriedade.json`',
    'RF-NFS-02': '`vetores/leiaute-nfse.json`',
    'RF-NFS-03': '`vetores/leiaute-nfse.json`',
    'RF-NFS-07': '`vetores/obrigatoriedade.json` (OBS-001)',
    'RF-CLS-02': '`vetores/nfe-diversos.json` (CST); `vetores/obrigatoriedade.json` (OBS-002)',
    'RF-DEV-03': '`vetores/nfe-diversos.json`',
}
linhas = open(REGRAS, encoding='utf-8').read().split('\n')
mudou = 0
for i, l in enumerate(linhas):
    m = re.match(r'\| (RF-[A-Z]+-\d+) \|', l)
    if m and m.group(1) in MAPA:
        novo = re.sub(r'\| [^|]*\|$', '| ' + MAPA[m.group(1)] + ' |', l)
        if novo != l:
            linhas[i] = novo
            mudou += 1
open(REGRAS, 'w', encoding='utf-8', newline='\n').write('\n'.join(linhas))
print('linhas atualizadas:', mudou)
