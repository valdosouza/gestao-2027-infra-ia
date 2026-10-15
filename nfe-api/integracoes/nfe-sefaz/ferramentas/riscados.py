# Escopo: metodo
# Lista o texto RISCADO (tachado) de um PDF de Nota Técnica.
#
# Por que existe (2026-10-15, NE-0 da nfe-api): o pdftotext extrai o texto riscado e o texto
# que o substitui lado a lado, sem marca — a NT 2025.002 v1.52 lida em texto "dizia" que a
# rejeição 1115 vale para o Simples em 04/01/2027, quando essa data está RISCADA no PDF
# (vale "implementação futura"). Conhecimento negativo: NT do fisco nunca se confere só pelo
# .txt quando a linha traz data, prazo ou obrigatoriedade — rodar este script antes.
#
# Como detecta: o Word desenha o tachado como um retângulo FINO (altura < 1,6 pt) por cima da
# linha de texto; o script cruza a posição de cada trecho de texto com esses retângulos.
# Heurística — confirmar no PDF o que importar.
#
# Uso:  python -I riscados.py <arquivo.pdf> [pagina_inicial pagina_final]
import sys

from pypdf import PdfReader


def struck_runs(page):
    rects, texts = [], []

    def before(op, args, cm, tm):
        if op == b're':
            x, y, w, h = (float(a) for a in args)
            a, b, c, d, e, f = cm
            rects.append((a * x + c * y + e, b * x + d * y + f, w * a, h * d))

    def visit(text, cm, tm, fd, fs):
        if text.strip():
            a, b, c, d, e, f = cm
            size = abs(fs * tm[3] * d) or fs
            texts.append((tm[4] * a + e, tm[5] * d + f, size, text.strip()))

    page.extract_text(visitor_operand_before=before, visitor_text=visit)
    # tachado = linha fina na faixa do MEIO da linha de texto (0,15–0,55 do corpo acima da base);
    # borda de tabela fica abaixo da base ou acima da altura das maiúsculas
    thin = [r for r in rects if abs(r[3]) < 1.6 and 3 < abs(r[2]) < 400]
    out = []
    for x, y, size, t in texts:
        lo, hi = y + 0.15 * size, y + 0.55 * size
        if any(lo <= r[1] + abs(r[3]) / 2 <= hi and r[0] <= x + 2 and r[0] + abs(r[2]) >= x + 2 for r in thin):
            out.append((round(y, 1), t))
    return out


def main():
    reader = PdfReader(sys.argv[1])
    first = int(sys.argv[2]) if len(sys.argv) > 2 else 1
    last = int(sys.argv[3]) if len(sys.argv) > 3 else len(reader.pages)
    for n in range(first, last + 1):
        runs = struck_runs(reader.pages[n - 1])
        for y, t in runs:
            print(f'p.{n} y={y}: {t[:140]}')


if __name__ == '__main__':
    main()
