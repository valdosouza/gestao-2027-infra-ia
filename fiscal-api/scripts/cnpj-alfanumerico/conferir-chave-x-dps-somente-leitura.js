// D-CJ23 — conferência SÓ-LEITURA no fiscal_api: nenhuma chave gravada com emitente que não seja CNPJ (tpInsc 2) nem divergente do DPS.
// Lê as credenciais do .env da nfse-api VIVA sem imprimi-las; só SELECT; imprime contagens agregadas (nenhuma chave, nenhum documento).
// Escopo: setes. Frente do CNPJ alfanumérico (prompt §8.14). Rodar: `node <este arquivo>` (o mysql2 vem do node_modules do núcleo da worktree
// D:\Gestao2027\cnpj\fiscal-api — trocar o caminho abaixo se a worktree não existir mais). Resultado de 2026-10-16: 4 chaves em P, 0 divergência.
const fs = require('fs')
const path = require('path')
const mysql = require(path.join('D:/Gestao2027/cnpj/fiscal-api/node_modules/mysql2/promise'))

const env = Object.fromEntries(fs.readFileSync('D:/Gestao2027/nfse-api/.env', 'utf8').split(/\r?\n/)
  .filter(l => /^[A-Z_]+=/.test(l)).map(l => [l.slice(0, l.indexOf('=')), l.slice(l.indexOf('=') + 1).replace(/^"|"$/g, '')]))

;(async () => {
  const conn = await mysql.createConnection({
    host: env.DB_HOST, port: Number(env.DB_PORT || 3306), user: env.DB_USER, password: env.DB_PASSWORD, database: env.FISCAL_DB_NAME || 'fiscal_api',
  })
  try {
    await conn.query('SET SESSION TRANSACTION READ ONLY')
    const [rows] = await conn.query(`
      SELECT t.tb_institution_id AS inst, t.environment AS env, COUNT(*) AS tentativas,
             SUM(t.access_key IS NOT NULL) AS comChave,
             SUM(t.access_key IS NOT NULL AND SUBSTRING(t.access_key, 9, 1) <> '2') AS chaveSemCnpj,
             SUM(t.access_key IS NOT NULL AND d.dps_id IS NULL) AS chaveSemDps,
             SUM(t.access_key IS NOT NULL AND d.dps_id IS NOT NULL
                 AND (SUBSTRING(t.access_key, 9, 1) <> SUBSTRING(d.dps_id, 11, 1)
                      OR BINARY SUBSTRING(t.access_key, 10, 14) <> BINARY SUBSTRING(d.dps_id, 12, 14))) AS emitenteDiverge,
             SUM(t.access_key IS NOT NULL AND CHAR_LENGTH(t.access_key) <> 50) AS chaveForaDe50
        FROM tb_invoice_service_transmission t
        LEFT JOIN tb_invoice_service_dps d
          ON d.tb_institution_id = t.tb_institution_id AND d.tb_invoice_id = t.tb_invoice_id
         AND d.terminal = t.terminal AND d.life_event = t.life_event
       GROUP BY t.tb_institution_id, t.environment
       ORDER BY t.tb_institution_id, t.environment`)
    console.table(rows)
  } finally {
    await conn.end()
  }
})().catch(e => { console.error('falhou:', e.code || e.message); process.exit(1) })
