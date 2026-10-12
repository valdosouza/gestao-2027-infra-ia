"""Consultas determinísticas sobre o graph.json do ACBrNFe (sem LLM)."""
import json
import sys
from collections import Counter, defaultdict
from pathlib import Path

g = json.loads(Path(sys.argv[1]).read_text(encoding="utf-8"))
nodes = {n["id"]: n for n in g["nodes"]}
links = g["links"]
mode = sys.argv[2] if len(sys.argv) > 2 else "overview"


def lab(i):
    n = nodes.get(i)
    return f"{n['label']} ({n['source_file']}:{n.get('source_location','')})" if n else f"<fora:{i}>"


out_e = defaultdict(list)
in_e = defaultdict(list)
for e in links:
    out_e[e["source"]].append(e)
    in_e[e["target"]].append(e)

if mode == "overview":
    units = [n for n in g["nodes"] if any(e["relation"] == "imports" for e in out_e[n["id"]]) or n["label"].count(".") and n["label"] == Path(n["source_file"]).stem]
    print("relações:", Counter(e["relation"] for e in links))
    # módulos = nós cujo label == stem do arquivo
    mods = sorted({n["label"] for n in g["nodes"] if n["label"].lower() == Path(n["source_file"]).stem.lower()})
    print(len(mods), "units:", ", ".join(mods))

elif mode == "inherits":
    base = sys.argv[3].lower()
    # BFS de herança: quem herda (direta ou indiretamente) de base
    by_label = defaultdict(list)
    for n in g["nodes"]:
        by_label[n["label"].lower()].append(n["id"])
    frontier = set(by_label.get(base, []))
    # também targets de inherits cujo label bate (nós externos)
    for e in links:
        if e["relation"] == "inherits" and e["target"].lower().endswith("_" + base):
            frontier.add(e["target"])
    seen = set(frontier)
    level = 0
    while frontier:
        level += 1
        nxt = set()
        for e in links:
            if e["relation"] == "inherits" and e["target"] in frontier and e["source"] not in seen:
                nxt.add(e["source"])
        for s in sorted(nxt, key=lambda i: lab(i)):
            print(f"  nível {level}: {lab(s)}")
        seen |= nxt
        frontier = nxt

elif mode == "importers":
    # quem importa (uses) cada unit pedida
    for unit in sys.argv[3:]:
        u = unit.lower()
        srcs = sorted({nodes[e["source"]]["source_file"] for e in links
                       if e["relation"] == "imports" and (e["target"].lower().endswith("_" + u.replace(".", "_")) or nodes.get(e["target"], {}).get("label", "").lower() == u)
                       and e["source"] in nodes})
        print(f"{unit}: {len(srcs)} units — {', '.join(srcs)}")

elif mode == "callers":
    for name in sys.argv[3:]:
        nm = name.lower()
        hits = [e for e in links if e["relation"] == "calls" and (nodes.get(e["target"], {}).get("label", "").lower().rstrip("()") == nm or e["target"].lower().endswith("_" + nm))]
        by_file = Counter(e.get("source_file") for e in hits)
        print(f"{name}: {len(hits)} chamadas — {dict(by_file)}")
        for e in sorted(hits, key=lambda e: (e.get('source_file',''), int((e.get('source_location') or 'L0')[1:] or 0)))[:60]:
            print(f"    {e.get('source_file')}:{e.get('source_location')}  {lab(e['source'])}")

elif mode == "methods":
    cls = sys.argv[3].lower()
    ids = [n["id"] for n in g["nodes"] if n["label"].lower() == cls]
    for i in ids:
        ms = [e["target"] for e in out_e[i] if e["relation"] == "method"]
        print(f"{lab(i)}: {len(ms)} métodos — {', '.join(sorted(nodes[m]['label'] for m in ms if m in nodes))}")
