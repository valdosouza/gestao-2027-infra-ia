# =====================================================================
# Publicar Fase 2 - Gerenciamento Central (v3)
# Cria branch, commit, push e Pull Request em cada repositorio de D:\Gestao2027
#
# Como rodar (PowerShell):
#   powershell -ExecutionPolicy Bypass -File D:\Gestao2027\Infra-IA\git-github\publicar-fase2.ps1
#
# v3: script movido para Infra-IA\git-github; sql/ virou repo proprio (init automatico);
#     codigo-aprendizado foi incorporado ao repo Infra-IA (nao publica mais separado)
# =====================================================================

$ErrorActionPreference = "Continue"
$base   = "D:\Gestao2027"
$branch = "feature/fase2-gerenciamento-central"

$repos = [ordered]@{
  "Infra-IA"      = "docs: Fase 2 + reorganizacao - prompt fechado (21 decisoes), PADROES_BANCO, skills revisar-ddl/refinar-prompt/atualizar-infra-ia, doc auth, ORGANIZACAO_PASTAS, codigo-aprendizado incorporado, pasta prompts"
  "setes-api"     = "feat: Fase 2 - modelo institution: JWT institutionId, tb_institution/tb_feature_flag/tb_sync_api_key, modulo auth multi-institution (login/select/switch), admin institutions, prefixo setes_, CLAUDE.md aponta Infra-IA"
  "setes-sync"    = "docs: CLAUDE.md aponta base de conhecimento Infra-IA e decisoes vigentes da Fase 2"
  "sincronizador" = "chore: sincroniza alteracoes locais pendentes"
  "sql"           = "feat: scripts canonicos Fase 2 - setes_central (DDL+seed), schema cliente, cleanup, tb_sync_api_key"
}

$temGh  = $null -ne (Get-Command gh -ErrorAction SilentlyContinue)
$resumo = @()

foreach ($repo in $repos.Keys) {
  $caminho = Join-Path $base $repo
  if (-not (Test-Path $caminho)) { $resumo += "SKIP  $repo (pasta nao existe)"; continue }

  Write-Host "`n=== $repo ===" -ForegroundColor Cyan
  Push-Location $caminho

  # sql/ (ou qualquer pasta) sem git: inicializa repo
  if (-not (Test-Path ".git")) {
    Write-Host "Inicializando repositorio git em $repo..." -ForegroundColor Yellow
    git init -b main | Out-Null
    if ($temGh) {
      gh repo create "gestao-2027-$repo" --private --source . --remote origin
      if ($LASTEXITCODE -ne 0) { $resumo += "AVISO $repo -> git init ok, mas crie o repo no GitHub e adicione o remote origin" }
    } else {
      $resumo += "AVISO $repo -> git init ok; crie o repo no GitHub e rode: git remote add origin <url>"
    }
  }

  # Guarda de seguranca: .env rastreado sai do indice
  $envRastreado = git ls-files .env .env.local
  if ($envRastreado) {
    git rm -r --cached .env .env.local | Out-Null
    Write-Host "AVISO: .env estava rastreado e foi removido do indice" -ForegroundColor Yellow
  }

  $mudancas = git status --porcelain
  if (-not $mudancas) { $resumo += "OK    $repo (sem mudancas)"; Pop-Location; continue }

  $atual = git branch --show-current
  if ($atual -ne $branch) {
    $existe = git branch --list $branch
    if ($existe) { git checkout $branch } else { git checkout -b $branch }
    if ($LASTEXITCODE -ne 0) { $resumo += "ERRO  $repo -> falha ao criar/trocar branch"; Pop-Location; continue }
  }

  git add -A
  $envNoStage = git diff --cached --name-only | Where-Object { $_ -match '(^|/)\.env' }
  if ($envNoStage) { git reset -q -- $envNoStage }

  git commit -m $repos[$repo]
  if ($LASTEXITCODE -ne 0) { $resumo += "ERRO  $repo -> commit falhou"; Pop-Location; continue }

  git remote get-url origin *> $null
  if ($LASTEXITCODE -ne 0) { $resumo += "COMMIT $repo -> sem remote origin; adicione e rode git push -u origin $branch"; Pop-Location; continue }

  git push -u origin $branch
  if ($LASTEXITCODE -ne 0) { $resumo += "ERRO  $repo -> push falhou (verifique credenciais/remote)"; Pop-Location; continue }

  $urlRemota = (git remote get-url origin) -replace '\.git$',''
  if ($urlRemota -match 'git@github\.com:(.+)') { $urlRemota = "https://github.com/" + $Matches[1] }
  $urlPr = "$urlRemota/compare/$branch" + "?expand=1"

  if ($temGh) {
    gh pr create --title "Fase 2 - Gerenciamento Central ($repo)" --body $repos[$repo] --head $branch
    if ($LASTEXITCODE -eq 0) { $resumo += "PR    $repo -> criado via gh" }
    else                     { $resumo += "PUSH  $repo -> abra o PR: $urlPr" }
  } else {
    $resumo += "PUSH  $repo -> abra o PR: $urlPr"
  }

  Pop-Location
}

Write-Host "`n========== RESUMO ==========" -ForegroundColor Yellow
$resumo | ForEach-Object { Write-Host $_ }
