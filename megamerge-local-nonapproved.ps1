# save as E:\GMOD\Server\garrysmod\gamemodes\Lilia\megamerge-local-nonapproved.ps1
$Owner = "bleonheart"
$Repo = "Lilia"
$TargetBranch = "main"

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$Base = "https://api.github.com/repos/$Owner/$Repo"
$Headers = @{ "User-Agent" = "ps-megamerge" }

git fetch origin
git checkout -B megamerge "origin/$TargetBranch"

$prs = @()
$page = 1
do {
  $data = Invoke-RestMethod -Headers $Headers -Method Get -Uri "$Base/pulls?state=open&per_page=100&page=$page"
  if (-not $data -or @($data).Count -eq 0) { break }
  $prs += $data
  $page++
} while (@($data).Count -eq 100)

$todo = @()
foreach ($pr in $prs) {
  $reviews = Invoke-RestMethod -Headers $Headers -Method Get -Uri "$Base/pulls/$($pr.number)/reviews?per_page=100"
  if (-not ($reviews | Where-Object { $_.state -eq "APPROVED" })) { $todo += $pr.number }
}

$merged = @()
$skipped = @()
foreach ($n in $todo) {
  git fetch origin "pull/$n/head:pr-$n" | Out-Null
  & git merge --no-ff -X theirs --no-edit "pr-$n"
  if ($LASTEXITCODE -eq 0) { $merged += $n } else { & git merge --abort | Out-Null; $skipped += $n }
}

Write-Output ("Merged locally: " + ($merged -join ", "))
Write-Output ("Skipped (conflicts): " + ($skipped -join ", "))
