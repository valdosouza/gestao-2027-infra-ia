"""Leitura DETERMINÍSTICA do ACBrNFe com o graphify — só extração estrutural (sem LLM).

Recorte = o mesmo da leitura por agentes de 2026-10-10: ACBrNFe + base ACBrDFe (raiz) + ACBrLibXML2 + PCNComum.
Nada é gravado dentro de D:\\Componentes\\acbr (cópia de trabalho do SVN): cache e saída vão para OUT.
"""
import json
import sys
from pathlib import Path

from graphify.extract import extract
from graphify.build import build_from_json
from graphify.cluster import cluster, score_all
from graphify.analyze import god_nodes, surprising_connections, suggest_questions
from graphify.report import generate
from graphify.export import to_json
from graphify.diagnostics import diagnose_extraction, format_diagnostic_report

ROOT = Path(r"D:\Componentes\acbr\Fontes")
OUT = Path(sys.argv[1]).resolve()
GO = OUT / "graphify-out"
GO.mkdir(parents=True, exist_ok=True)

EXT = {".pas", ".dfm", ".lfm", ".inc"}
files: list[Path] = []
files += sorted(p for p in (ROOT / "ACBrDFe" / "ACBrNFe").rglob("*") if p.is_file() and p.suffix.lower() in EXT)
files += sorted(p for p in (ROOT / "ACBrDFe").glob("*.pas"))
files += sorted(p for p in (ROOT / "ACBrLibXML2").glob("*.pas"))
files += sorted(p for p in (ROOT / "PCNComum").glob("*.pas"))
seen: set[Path] = set()
files = [f for f in files if not (f in seen or seen.add(f))]

by_folder: dict[str, int] = {}
for f in files:
    rel = f.relative_to(ROOT)
    key = "/".join(rel.parts[:2]) if rel.parts[0] == "ACBrDFe" and len(rel.parts) > 2 else rel.parts[0] + ("/(raiz)" if rel.parts[0] == "ACBrDFe" else "")
    by_folder[key] = by_folder.get(key, 0) + 1
lines = sum(len(f.read_text(encoding="latin-1", errors="replace").splitlines()) for f in files)
detection = {
    "total_files": len(files), "total_words": 0, "scan_root": str(ROOT),
    "files": {"code": [str(f) for f in files], "document": [], "paper": [], "image": [], "video": []},
    "skipped_sensitive": [],
}
(GO / ".graphify_detect.json").write_text(json.dumps(detection, ensure_ascii=False), encoding="utf-8")
print(f"Corpus: {len(files)} arquivos de código · {lines} linhas · {json.dumps(by_folder, ensure_ascii=False)}")

result = extract(files, cache_root=OUT)
result.setdefault("hyperedges", [])
result["input_tokens"] = 0
result["output_tokens"] = 0
(GO / ".graphify_extract.json").write_text(json.dumps(result, indent=1, ensure_ascii=False), encoding="utf-8")
print(f"AST: {len(result['nodes'])} nós, {len(result['edges'])} arestas")

G = build_from_json(result, root=str(ROOT), directed=True)
if G.number_of_nodes() == 0:
    raise SystemExit("ERRO: grafo vazio")
communities = cluster(G)
cohesion = score_all(G, communities)
gods = god_nodes(G)
surprises = surprising_connections(G, communities)
labels = {cid: "Community " + str(cid) for cid in communities}
questions = suggest_questions(G, communities, labels)
if not to_json(G, communities, str(GO / "graph.json")):
    raise SystemExit("ERRO: to_json recusou (shrink-guard)")
report = generate(G, communities, cohesion, labels, gods, surprises, detection, {"input": 0, "output": 0}, str(ROOT), suggested_questions=questions)
(GO / "GRAPH_REPORT.md").write_text(report, encoding="utf-8")
analysis = {"communities": {str(k): v for k, v in communities.items()}, "cohesion": {str(k): v for k, v in cohesion.items()},
            "gods": gods, "surprises": surprises, "questions": questions}
(GO / ".graphify_analysis.json").write_text(json.dumps(analysis, indent=1, ensure_ascii=False), encoding="utf-8")
print(f"Grafo: {G.number_of_nodes()} nós, {G.number_of_edges()} arestas, {len(communities)} comunidades")

summary = diagnose_extraction(result, directed=True, root=str(ROOT))
print(format_diagnostic_report(summary))
