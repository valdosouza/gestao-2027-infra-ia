# Relatório de Dados Sensíveis em Infra-IA
**Data:** 2026-07-04  
**Status:** ⚠️ CRÍTICO - Exposições encontradas  
**Ação:** Remover do histórico Git + atualizar .gitignore
**Escopo**: setes

---

## 🔴 RESUMO EXECUTIVO

Foram encontrados **2 arquivos críticos** contendo Google API Keys expostas:

1. **firebase_options.dart** - Contém 2 API Keys (web + android)
2. **google-services.json** - Contém API Key + OAuth Client ID

**Recomendação:** Remover imediatamente do histórico Git usando BFG ou git filter-branch.

---

## 📋 DADOS SENSÍVEIS ENCONTRADOS

### Arquivo 1: `lib/firebase_options.dart`
**Localização:** `D:\Gestao2027\Infra-IA\codigo-aprendizado\weberpsetes\lib\firebase_options.dart`

| Tipo | Valor | Linha | Risco |
|------|-------|-------|-------|
| Google API Key (web) | `AIzaSyAg9DhSYfdl32Jy_fo-UU_T_se7QfZMvcA` | 53 | 🔴 CRÍTICO |
| Google API Key (android) | `AIzaSyCsjo2V5DM1AieMZKY9dAtBDbo9VIRa3A0` | 63 | 🔴 CRÍTICO |
| Project ID | `setes-erp` | 56, 66 | 🟡 ALTO |
| App ID (web) | `1:859795148532:web:4acceaa50590daae0258a1` | 54 | 🟡 ALTO |
| App ID (android) | `1:859795148532:android:da98961578c910430258a1` | 64 | 🟡 ALTO |
| Messaging Sender ID | `859795148532` | 55, 65 | 🟡 ALTO |
| Measurement ID | `G-8KJ95L4PDT` | 59 | 🟢 BAIXO |

### Arquivo 2: `android/app/google-services.json`
**Localização:** `D:\Gestao2027\Infra-IA\codigo-aprendizado\weberpsetes\android\app\google-services.json`

| Tipo | Valor | Risco |
|------|-------|-------|
| Google API Key | `AIzaSyCsjo2V5DM1AieMZKY9dAtBDbo9VIRa3A0` | 🔴 CRÍTICO |
| OAuth Client ID | `859795148532-3a2uepv18hk32tcbbkmcgemgjv7kqmrm.apps.googleusercontent.com` | 🔴 CRÍTICO |
| Project ID | `setes-erp` | 🟡 ALTO |
| Project Number | `859795148532` | 🟡 ALTO |
| Package Name | `com.setes.erpsetes` | 🟡 ALTO |
| Storage Bucket | `setes-erp.appspot.com` | 🟡 ALTO |

---

## 📂 ARQUIVOS A PROTEGER NO .GITIGNORE

### Categoria 1: Firebase (CRÍTICO)
```
firebase_options.dart
google-services.json
GoogleService-Info.plist
**/firebase_options.dart
**/google-services.json
```

### Categoria 2: Variáveis de Ambiente (CRÍTICO)
```
.env
.env.local
.env.*.local
.env.example.local
```

### Categoria 3: Chaves Privadas (CRÍTICO)
```
*.pem
*.key
*.jks
*.keystore
*.p12
*.pfx
```

### Categoria 4: Secrets e Credenciais (CRÍTICO)
```
*secret*
*credential*
*token*
*password*
credentials.json
service-account*.json
```

### Categoria 5: Arquivos de Configuração (CRÍTICO)
```
.aws/
.azure/
.gcp/
config/secrets.*
secrets/
config.secrets.json
```

---

## 🛠️ PLANO DE AÇÃO

### Passo 1: Remover do Histórico Git
```bash
# Usando BFG Repo-Cleaner (RECOMENDADO)
git clone --mirror https://github.com/valdosouza/gestao-2027-codigo-aprendizado.git
cd gestao-2027-codigo-aprendizado.git
bfg --delete-files firebase_options.dart
bfg --delete-files google-services.json
git reflog expire --expire=now --all && git gc --prune=now --aggressive
git push --force

# OU usando git filter-branch
git filter-branch --tree-filter 'rm -f lib/firebase_options.dart android/app/google-services.json' --prune-empty -f HEAD
git reflog expire --expire=now --all
git gc --prune=now --aggressive
git push origin --force --all
```

### Passo 2: Criar Arquivos .example
```bash
# firebase_options.example.dart
cp lib/firebase_options.dart lib/firebase_options.example.dart
# Editar manualmente removendo valores reais

# google-services.example.json
cp android/app/google-services.json android/app/google-services.example.json
# Editar manualmente removendo valores reais
```

### Passo 3: Atualizar .gitignore
```bash
# Adicionar ao .gitignore do repositório
echo "firebase_options.dart" >> .gitignore
echo "google-services.json" >> .gitignore
echo ".env*" >> .gitignore
git add .gitignore
git commit -m "chore: ignore Firebase config files with secrets"
git push
```

### Passo 4: Instruções para Devs
Criar documento `SETUP_SECRETS.md`:
```markdown
# Setup de Secrets Locais

1. Obtenha `firebase_options.dart` do Google Cloud Console
2. Copie para: `lib/firebase_options.dart`
3. Obtenha `google-services.json` do Firebase Console
4. Copie para: `android/app/google-services.json`

⚠️ NUNCA commit estes arquivos!
```

---

## ✅ CHECKLIST DE CONCLUSÃO

- [ ] Remover arquivos do histórico Git (BFG ou filter-branch)
- [ ] Atualizar `.gitignore` com regras de proteção
- [ ] Criar arquivos `.example` sem valores reais
- [ ] Criar `SETUP_SECRETS.md` para devs
- [ ] Comunicar ao time sobre novo setup
- [ ] Validar que novos commits não incluem secrets
- [ ] (Opcional) Revogar/rotacionar Google API Keys

---

## 📚 REFERÊNCIAS

- [BFG Repo-Cleaner](https://rtyley.github.io/bfg-repo-cleaner/)
- [GitHub: Removing sensitive data](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository)
- [Git filter-branch docs](https://git-scm.com/docs/git-filter-branch)
- [Firebase Security Best Practices](https://firebase.google.com/docs/projects/locations)
- [OWASP: Sensitive Data Exposure](https://owasp.org/www-project-top-ten/)

---

## 📞 PRÓXIMOS PASSOS

1. **Executar limpeza Git** (este mês)
2. **Configurar pre-commit hook** para detectar secrets automaticamente
3. **Implementar GitHub Actions** para validação de secrets em PRs
4. **Documentar procedimento** no CLAUDE.md

