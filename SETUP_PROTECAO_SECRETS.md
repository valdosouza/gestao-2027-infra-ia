# Proteção de Dados Sensíveis - Setup e Instrções
**Data:** 2026-07-04  
**Status:** Documentação de implementação  
**Escopo**: metodo

---

## 📋 Resumo

Este documento detalha como:
1. ✅ Remover secrets já expostos do histórico Git
2. ✅ Configurar `.gitignore` para futuro
3. ✅ Instalar hooks de pré-commit para prevenção
4. ✅ Documentar para o time

---

## 🔴 CASO CRÍTICO: Secrets já expostos

Se você commitou secrets acidentalmente:

### Opção 1: BFG Repo-Cleaner (RECOMENDADO - Rápido)

```bash
# 1. Instalar BFG
brew install bfg  # macOS
# ou
sudo apt-get install bfg  # Linux

# 2. Executar script de limpeza
bash scripts/limpar-secrets-git.sh https://github.com/valdosouza/gestao-2027-codigo-aprendizado.git

# 3. Fazer push force (após validar!)
cd gestao-2027-codigo-aprendizado.git
git push --force
```

### Opção 2: git filter-branch (Controle total)

```bash
# Remover arquivo específico
git filter-branch --tree-filter 'rm -f lib/firebase_options.dart' --prune-empty -f HEAD

# Limpar history
git reflog expire --expire=now --all
git gc --prune=now --aggressive

# Push force
git push origin --force --all
git push origin --force --tags
```

### Opção 3: BFG via Docker (sem instalar)

```bash
docker run --rm -v "$(pwd)":/repo codicehorn/bfg-repo-cleaner \
  --delete-files firebase_options.dart
```

---

## ✅ SETUP PARA FUTURO

### Passo 1: Atualizar .gitignore

Seu repositório deve ter esse arquivo `.gitignore` na raiz:

```gitignore
# Firebase - CRÍTICO
firebase_options.dart
google-services.json
GoogleService-Info.plist
lib/firebase_options.dart
android/app/google-services.json

# Variáveis de Ambiente - CRÍTICO
.env
.env.local
.env.*.local
.env.example.local

# Chaves Privadas - CRÍTICO
*.pem
*.key
*.jks
*.keystore
*.p12
*.pfx

# Secrets e Credenciais - CRÍTICO
*secret*
*credential*
*token*
*password*
credentials.json
service-account*.json

# Configurações sensíveis
.aws/
.azure/
.gcp/
config/secrets.*
```

**Commit:**
```bash
git add .gitignore
git commit -m "chore: add comprehensive gitignore for sensitive files"
git push
```

---

### Passo 2: Instalar Pre-Commit Hook

Pre-commit hooks impedem que secrets sejam commitados automaticamente.

#### Instalação manual:
```bash
cp scripts/pre-commit-secrets-check.sh .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

#### Instalação com ferramenta `pre-commit`:
```bash
# Instalar ferramenta
pip install pre-commit --break-system-packages

# Criar .pre-commit-config.yaml na raiz do repo
cat > .pre-commit-config.yaml << 'EOF'
repos:
  - repo: https://github.com/Yelp/detect-secrets
    rev: v1.4.0
    hooks:
      - id: detect-secrets
        args: ['--baseline', '.secrets.baseline']

  - repo: local
    hooks:
      - id: check-secrets
        name: Check for secrets
        entry: bash scripts/pre-commit-secrets-check.sh
        language: script
        types: [text]
        stages: [commit]
EOF

# Setup do baseline
detect-secrets scan --all-files > .secrets.baseline

# Ativar
pre-commit install
```

**Teste:**
```bash
# Criar arquivo sensível
echo "apiKey: AIza.." > teste.txt

# Tentar adicionar
git add teste.txt

# Commit será bloqueado
git commit -m "test"  # ❌ BLOQUEADO

# Remover e tentar novamente
rm teste.txt
git reset
git commit -m "test"  # ✅ OK
```

---

### Passo 3: Criar Arquivos .example

Para que devs saibam qual é a estrutura esperada, crie arquivos de exemplo **SEM VALORES REAIS**:

#### `lib/firebase_options.example.dart`
```dart
// ⚠️ EXEMPLO - COPIE PARA firebase_options.dart E PREENCHA COM SEUS VALORES
// Não commit firebase_options.dart!

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    // Implemente para seu platform
    throw UnimplementedError('Configure para seu platform');
  }

  // WEB CONFIG
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'YOUR_WEB_API_KEY_HERE',  // ← Obtenha do Firebase Console
    appId: 'YOUR_WEB_APP_ID_HERE',
    messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
    projectId: 'seu-project-id',
    authDomain: 'seu-project.firebaseapp.com',
    storageBucket: 'seu-project.appspot.com',
    measurementId: 'G-XXXXX',
  );

  // ANDROID CONFIG
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'YOUR_ANDROID_API_KEY_HERE',  // ← Obtenha do Firebase Console
    appId: 'YOUR_ANDROID_APP_ID_HERE',
    messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
    projectId: 'seu-project-id',
    storageBucket: 'seu-project.appspot.com',
  );
}
```

#### `android/app/google-services.example.json`
```json
{
  "project_info": {
    "project_number": "123456789",
    "project_id": "seu-project-id",
    "storage_bucket": "seu-project.appspot.com"
  },
  "client": [
    {
      "client_info": {
        "mobilesdk_app_id": "1:123456789:android:xxxx",
        "android_client_info": {
          "package_name": "com.seudominio.app"
        }
      },
      "oauth_client": [
        {
          "client_id": "123456789-xxxxxx.apps.googleusercontent.com",
          "client_type": 3
        }
      ],
      "api_key": [
        {
          "current_key": "YOUR_API_KEY_HERE"
        }
      ]
    }
  ],
  "configuration_version": "1"
}
```

**Commit:**
```bash
git add lib/firebase_options.example.dart android/app/google-services.example.json
git commit -m "docs: add example config files without secrets"
git push
```

---

### Passo 4: Documentar para o Time

Crie `SETUP_LOCAL_SECRETS.md` na raiz:

```markdown
# Setup de Secrets Locais

## ⚠️ Importante

Estes arquivos contêm dados sensíveis e **NUNCA devem ser commitados**:
- `lib/firebase_options.dart`
- `android/app/google-services.json`
- `.env`
- `.env.local`

## Setup Inicial

### 1. Obter Credenciais do Firebase

1. Acesse [Firebase Console](https://console.firebase.google.com/)
2. Selecione seu projeto
3. Vá em Configurações do Projeto
4. Na aba "Seu aplicativo", gere:
   - `lib/firebase_options.dart` (Web + Android)
   - `android/app/google-services.json` (Android)

### 2. Copiar Arquivos

```bash
# Usar como template
cp lib/firebase_options.example.dart lib/firebase_options.dart
cp android/app/google-services.example.json android/app/google-services.json
```

### 3. Preencher com Valores Reais

Edit os arquivos copiados com suas credenciais reais (do Firebase Console).

### 4. Verificar .gitignore

Confirme que esses arquivos estão no `.gitignore`:
```bash
git check-ignore lib/firebase_options.dart  # Deve retornar o path
git check-ignore android/app/google-services.json  # Deve retornar o path
```

## Variáveis de Ambiente

Para configurações adicionais, copie `.env.example`:

```bash
cp .env.example .env
# Edit .env com seus valores
```

## Se Acidentalmente Commitou Secrets

1. Notifique o time
2. Execute: `bash scripts/limpar-secrets-git.sh`
3. Re-clone o repositório
4. Revogar/rotacionar chaves no Google Cloud Console

## Validação

Antes de fazer push, valide que não há secrets:

```bash
# Nenhum destas linhas deve retornar resultados
git diff --staged | grep -i "AIzaSy"
git diff --staged | grep -i "client_secret"
git diff --staged | grep -i "apikey"
```
```

---

## 🚀 GitHub Actions para CI/CD

Adicionar validação automática em PRs:

### `.github/workflows/check-secrets.yml`

```yaml
name: Detect Secrets

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

jobs:
  detect-secrets:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
        with:
          fetch-depth: 0

      - name: Check for Secrets with detect-secrets
        uses: trufflesecurity/trufflehog@main
        with:
          path: ./
          base: ${{ github.event.repository.default_branch }}
          head: HEAD

      - name: Check for Secrets with Yelp detect-secrets
        run: |
          pip install detect-secrets
          detect-secrets scan --all-files --baseline .secrets.baseline
          detect-secrets audit .secrets.baseline
```

**Commit:**
```bash
git add .github/workflows/check-secrets.yml
git commit -m "ci: add automatic secret detection"
git push
```

---

## 📊 Checklist de Implementação

- [ ] ✅ Remover secrets do histórico (BFG ou filter-branch)
- [ ] ✅ Atualizar `.gitignore`
- [ ] ✅ Instalar pre-commit hook local
- [ ] ✅ Criar arquivos `.example`
- [ ] ✅ Documentar `SETUP_LOCAL_SECRETS.md`
- [ ] ✅ Configurar GitHub Actions para detecção automática
- [ ] ✅ Comunicar ao time
- [ ] ✅ (Opcional) Rotacionar chaves no Google Cloud

---

## 📚 Referências Rápidas

| Ferramenta | Comando | Uso |
|-----------|---------|-----|
| BFG | `bfg --delete-files FILE` | Remover arquivo do histórico |
| git filter-branch | `git filter-branch --tree-filter 'rm FILE'` | Alternativa ao BFG |
| pre-commit | `pre-commit install` | Instalar hooks |
| detect-secrets | `detect-secrets scan` | Encontrar padrões de secrets |
| trufflehog | `docker run -v /path:/path trufflesecurity/trufflehog filesystem /path` | Varredura profunda |

---

## ❓ Dúvidas?

1. Verifique `RELATORIO_DADOS_SENSIVEIS.md`
2. Leia `README.md` do repositório
3. Consulte o team lead

