const { generateKeyPairSync } = require('crypto'); const fs = require('fs'); const dir = process.argv[2];
const { publicKey, privateKey } = generateKeyPairSync('rsa', { modulusLength: 2048, publicKeyEncoding: { type: 'spki', format: 'pem' }, privateKeyEncoding: { type: 'pkcs8', format: 'pem' } });
fs.writeFileSync(dir + '/passeio.private.pem', privateKey); fs.writeFileSync(dir + '/passeio.public.pem', publicKey); console.log('ok');
