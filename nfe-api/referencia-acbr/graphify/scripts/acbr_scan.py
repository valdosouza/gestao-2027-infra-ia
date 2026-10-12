"""Varredura DETERMINÍSTICA (regex fixa, sem LLM) do mesmo recorte do grafo — completa o que o extrator Pascal do graphify
descarta (chamadas a símbolos fora do recorte). Ignora comentários Pascal ({ }, (* *), //) e literais de string só onde indicado.
Saída: JSON com cada ocorrência (arquivo:linha:texto) por padrão."""
import json
import re
import sys
from pathlib import Path

ROOT = Path(r"D:\Componentes\acbr\Fontes")
files = sorted(p for p in (ROOT / "ACBrDFe" / "ACBrNFe").rglob("*.pas"))
files += sorted((ROOT / "ACBrDFe").glob("*.pas")) + sorted((ROOT / "ACBrLibXML2").glob("*.pas")) + sorted((ROOT / "PCNComum").glob("*.pas"))
files.append(ROOT / "ACBrComum" / "ACBr.inc")
for extra in ("ACBrUtil.XMLHTML.pas",):
    files += sorted((ROOT / "ACBrComum").rglob(extra))

COMMENT_RE = re.compile(r"\{[^}]*\}|\(\*.*?\*\)|//[^\n]*", re.DOTALL)


def strip_comments(text: str) -> str:
    # troca comentário por espaços preservando as quebras de linha (mantém a numeração)
    def blank(m):
        return re.sub(r"[^\n]", " ", m.group(0))
    out, i = [], 0
    # não remove "comentário" dentro de string Pascal ('...')
    for m in re.finditer(r"'(?:''|[^'\n])*'|\{[^}]*\}|\(\*.*?\*\)|//[^\n]*", text, re.DOTALL):
        out.append(text[i:m.start()])
        out.append(m.group(0) if m.group(0).startswith("'") else blank(m))
        i = m.end()
    out.append(text[i:])
    return "".join(out)


PATTERNS = json.loads(Path(sys.argv[1]).read_text(encoding="utf-8"))
keep_comments = set(PATTERNS.pop("_keep_comments", []))
result = {k: [] for k in PATTERNS}
for f in files:
    raw = f.read_text(encoding="latin-1")
    clean = strip_comments(raw)
    for key, pat in PATTERNS.items():
        rx = re.compile(pat, re.IGNORECASE)
        src = raw if key in keep_comments else clean
        for n, line in enumerate(src.splitlines(), 1):
            if rx.search(line):
                result[key].append(f"{f.relative_to(ROOT)}:{n}: {raw.splitlines()[n-1].strip()[:200]}")
print(json.dumps({"files": len(files), **{k: {"count": len(v), "hits": v} for k, v in result.items()}}, ensure_ascii=False, indent=1))
