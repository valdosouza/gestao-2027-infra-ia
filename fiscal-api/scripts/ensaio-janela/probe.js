// sonda: carrega o .env do cwd como o serviço carrega (dotenv sem override) e diz a QUE instância conectaria
const path = require('path'); const req = (m) => require(require.resolve(m, { paths: [process.cwd(), require('path').join(process.cwd(), '..', 'fiscal-api')] }));
req('dotenv').config();
const mysql = req('mysql2/promise');
(async () => {
  const c = await mysql.createConnection({ host: process.env.DB_HOST, port: Number(process.env.DB_PORT), user: process.env.DB_USER, password: process.env.DB_PASSWORD });
  const [r] = await c.query('SELECT @@port AS port, @@datadir AS datadir, CURRENT_USER() AS u');
  console.log(JSON.stringify({ cwd: process.cwd(), envPort: process.env.DB_PORT, ...r[0] })); await c.end();
})().catch(e => { console.error('ERRO', e.message); process.exit(1) });
