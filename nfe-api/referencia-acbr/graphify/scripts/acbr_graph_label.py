"""Rótulos DETERMINÍSTICOS das comunidades (unit dominante + nº de nós) e relatório final do graphify."""
import json
import sys
from collections import Counter
from pathlib import Path

from graphify.build import build_from_json
from graphify.analyze import suggest_questions
from graphify.report import generate
from graphify.export import to_json

ROOT = r"D:\Componentes\acbr\Fontes"
GO = Path(sys.argv[1]) / "graphify-out"
extraction = json.loads((GO / ".graphify_extract.json").read_text(encoding="utf-8"))
detection = json.loads((GO / ".graphify_detect.json").read_text(encoding="utf-8"))
analysis = json.loads((GO / ".graphify_analysis.json").read_text(encoding="utf-8"))
G = build_from_json(extraction, root=ROOT, directed=True)
communities = {int(k): v for k, v in analysis["communities"].items()}
cohesion = {int(k): v for k, v in analysis["cohesion"].items()}
labels = {}
for cid, members in communities.items():
    files = Counter(Path(G.nodes[m].get("source_file", "?")).stem for m in members if m in G.nodes)
    top = files.most_common(1)[0][0] if files else "?"
    labels[cid] = f"{top} ({len(members)})"
questions = suggest_questions(G, communities, labels)
report = generate(G, communities, cohesion, labels, analysis["gods"], analysis["surprises"], detection,
                  {"input": 0, "output": 0}, ROOT, suggested_questions=questions)
(GO / "GRAPH_REPORT.md").write_text(report, encoding="utf-8")
(GO / ".graphify_labels.json").write_text(json.dumps({str(k): v for k, v in labels.items()}, ensure_ascii=False), encoding="utf-8")
print("to_json:", to_json(G, communities, str(GO / "graph.json"), community_labels=labels))
