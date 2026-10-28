# Mapa do engine-kit - como o trabalho flui

**Escopo**: método

Mapa navegável do kit em `../engine-kit/`: da escolha da trilha ao fechamento, quais skills e agentes
usar em cada passo. Gerado pelo próprio kit (`engine-kit/runtime/ladder/`, a peça que no Vault se
chama ecosystem).

- **Abrir**: `index.html` (escolha a profundidade: visão geral ou uso).
- **Fonte**: `manifest.json` (o fluxo principal) e `ciclo-da-mudanca/extend-spec.json` (o subfluxo da
  mudança de código). O HTML é saída descartável: muda-se a fonte e gera-se de novo, nunca o HTML à mão.
- **Gerar de novo** (a partir da raiz do repo):

```
python engine-kit/runtime/ladder/generator.py engine-kit-mapa/manifest.json
python engine-kit/runtime/ladder/extend_handauthored.py engine-kit-mapa/ciclo-da-mudanca/extend-spec.json
python engine-kit/runtime/ladder/generator.py engine-kit-mapa/manifest.json
```

O gerador recusa escrever dentro do kit; por isso o mapa fica ao lado dele.
