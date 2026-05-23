<#
  Craft - universal installer for Windows (PowerShell 5.1+ / 7+)

  Installs the Craft design skill (4 skills + 13 commands) into every major
  AI coding CLI it can find: Claude Code, Cursor, Codex CLI, Google Antigravity,
  Gemini CLI, Aider, Cline, opencode and Windsurf.

  One-liner (recommended - not affected by execution policy):
    irm https://raw.githubusercontent.com/Muminur/frontend-design-craft-skill/main/install.ps1 | iex

  With flags (download then invoke):
    & ([scriptblock]::Create((irm https://raw.githubusercontent.com/Muminur/frontend-design-craft-skill/main/install.ps1))) -All

  If you saved this file and Windows blocks it ("running scripts is disabled"
  / "not digitally signed"), launch it bypassing the policy for that run only:
    powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -All

  Flags: -All  -Tools "a,b,c"  -Uninstall  -DryRun  -Help
#>
[CmdletBinding()]
param(
  [switch]$All,
  [switch]$Uninstall,
  [switch]$DryRun,
  [string]$Tools = "",
  [switch]$Help
)

$ErrorActionPreference = 'Stop'

# ---- execution-policy bypass -------------------------------------------------
# Relax the policy for THIS process only (never machine-wide) so the installer
# and any files it downloads are not blocked. Best-effort; ignored if already
# unrestricted or if the host forbids the change.
try { Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force -ErrorAction SilentlyContinue } catch {}
# Clear the "downloaded from the internet" mark from this script if run as a file.
try { if ($PSCommandPath) { Unblock-File -LiteralPath $PSCommandPath -ErrorAction SilentlyContinue } } catch {}

$Repo      = "Muminur/frontend-design-craft-skill"
$Branch    = "main"
$MarkStart = "<!-- CRAFT:START - managed by craft installer, do not edit inside -->"
$MarkEnd   = "<!-- CRAFT:END -->"
$YmlStart  = "# CRAFT:START - managed by craft installer, do not edit inside"
$YmlEnd    = "# CRAFT:END"
$AllTools  = @('claude','cursor','codex','antigravity','gemini','aider','cline','opencode','windsurf')
$Skills    = @('craft','motion','polish','taste')
$H         = $HOME

if ($Help) {
  Write-Host "Craft installer - flags: -All  -Tools 'a,b,c'  -Uninstall  -DryRun  -Help"
  exit 0
}

# ---- output ------------------------------------------------------------------
function Head($t){ Write-Host ""; Write-Host $t -ForegroundColor White }
function Ok($t){   Write-Host "  + $t" -ForegroundColor Green }
function Skip($t){ Write-Host "  . $t" -ForegroundColor DarkGray }
function Dim($t){  Write-Host "    $t" -ForegroundColor DarkGray }

# ---- source resolution -------------------------------------------------------
$Src = $null
if ($PSScriptRoot -and (Test-Path (Join-Path $PSScriptRoot "skills\craft\SKILL.md"))) {
  $Src = $PSScriptRoot
} else {
  $tmp = Join-Path ([System.IO.Path]::GetTempPath()) ("craft-" + [System.Guid]::NewGuid().ToString("N").Substring(0,8))
  New-Item -ItemType Directory -Force -Path $tmp | Out-Null
  $zip = Join-Path $tmp "craft.zip"
  Write-Host "Downloading Craft from github.com/$Repo ..."
  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
  Invoke-WebRequest -Uri "https://github.com/$Repo/archive/refs/heads/$Branch.zip" -OutFile $zip -UseBasicParsing
  Expand-Archive -LiteralPath $zip -DestinationPath $tmp -Force
  # Clear Mark-of-the-Web from everything we just downloaded.
  try { Get-ChildItem -LiteralPath $tmp -Recurse -File | Unblock-File -ErrorAction SilentlyContinue } catch {}
  $Src = Join-Path $tmp "frontend-design-craft-skill-$Branch"
}
if (-not (Test-Path (Join-Path $Src "skills\craft\SKILL.md"))) { throw "Could not locate Craft source files." }
$CmdDir = Join-Path $Src "commands"

# ---- helpers -----------------------------------------------------------------
function Get-MdBody($path){
  $f = 0; $out = New-Object System.Collections.Generic.List[string]
  foreach ($l in (Get-Content -LiteralPath $path)) {
    if ($f -ge 2) { $out.Add($l) }
    if ($l -match '^---\s*$') { $f++ }
  }
  ($out -join "`n")
}
function Get-FmValue($path,$key){
  $lines = Get-Content -LiteralPath $path
  if ($lines.Count -eq 0 -or $lines[0] -ne '---') { return '' }
  $n = 0
  foreach ($l in $lines) {
    if ($l -match '^---\s*$') { $n++; if ($n -ge 2) { break }; continue }
    if ($l -match "^$([regex]::Escape($key)):\s*(.*)$") { return $Matches[1] }
  }
  ''
}
function Ensure-Dir($dir){
  if ($dir -and -not (Test-Path -LiteralPath $dir)) {
    if ($DryRun) { Dim "mkdir $dir" } else { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
  }
}
function Write-Utf8($path,$content){
  Ensure-Dir (Split-Path -Parent $path)
  if ($DryRun) { Dim "write $path"; return }
  [System.IO.File]::WriteAllText($path, $content, (New-Object System.Text.UTF8Encoding($false)))
}
function Copy-One($src,$dest){
  if ($DryRun) { Dim "write $dest"; return }
  Ensure-Dir (Split-Path -Parent $dest)
  Copy-Item -LiteralPath $src -Destination $dest -Force
}
function Remove-Path($p){
  if ($DryRun) { Dim "rm $p"; return }
  if (Test-Path -LiteralPath $p) { Remove-Item -LiteralPath $p -Recurse -Force }
}
function Remove-CraftBlock([string]$text,$ms,$me){
  $pat = [regex]::Escape($ms) + '.*?' + [regex]::Escape($me)
  ([regex]::Replace($text, $pat, '', [System.Text.RegularExpressions.RegexOptions]::Singleline)).TrimEnd()
}
function Inject-Block($file,$content,$ms=$MarkStart,$me=$MarkEnd){
  Ensure-Dir (Split-Path -Parent $file)
  if ($DryRun) { Dim "update block in $file"; return }
  $existing = ''
  if (Test-Path -LiteralPath $file) {
    if (-not (Test-Path -LiteralPath "$file.craft.bak")) { Copy-Item -LiteralPath $file -Destination "$file.craft.bak" }
    $existing = Remove-CraftBlock (Get-Content -LiteralPath $file -Raw) $ms $me
  }
  $block = $ms + "`n" + $content.TrimEnd() + "`n" + $me + "`n"
  $new = if ($existing) { $existing + "`n`n" + $block } else { $block }
  [System.IO.File]::WriteAllText($file, $new, (New-Object System.Text.UTF8Encoding($false)))
}
function Strip-Block($file,$ms=$MarkStart,$me=$MarkEnd){
  if (-not (Test-Path -LiteralPath $file)) { return }
  if ($DryRun) { Dim "strip block from $file"; return }
  $new = (Remove-CraftBlock (Get-Content -LiteralPath $file -Raw) $ms $me) + "`n"
  [System.IO.File]::WriteAllText($file, $new, (New-Object System.Text.UTF8Encoding($false)))
}
function Copy-Commands($dir,$prefix=''){
  Ensure-Dir $dir
  Get-ChildItem -LiteralPath $CmdDir -Filter *.md | ForEach-Object {
    Copy-One $_.FullName (Join-Path $dir ($prefix + $_.Name))
  }
}
function Copy-SkillDirs($root){
  foreach ($s in $Skills) {
    $d = Join-Path $root $s
    if ($DryRun) { Dim "write $d\"; continue }
    New-Item -ItemType Directory -Force -Path $d | Out-Null
    Copy-Item -Path (Join-Path $Src "skills\$s\*") -Destination $d -Recurse -Force
  }
}
function Gemini-Toml($f,$dest){
  $desc = (Get-FmValue $f 'description') -replace '\\','\\\\' -replace '"','\"'
  $body = (Get-MdBody $f) -replace '\$ARGUMENTS','{{args}}'
  Write-Utf8 $dest ("description = `"$desc`"`nprompt = `"`"`"`n$body`n`"`"`"`n")
}

$script:Bundle = $null
function Build-Bundle {
  if ($script:Bundle) { return $script:Bundle }
  $sb = New-Object System.Text.StringBuilder
  [void]$sb.AppendLine("# Craft - frontend design system")
  [void]$sb.AppendLine("")
  [void]$sb.AppendLine("Apply these three lenses to every UI task, in order: Polish (structure), then Taste (distinctiveness), then Motion. Goal: production-grade, intentional interfaces that avoid the generic AI-generated look.")
  [void]$sb.AppendLine("")
  foreach ($s in $Skills) {
    [void]$sb.AppendLine("---"); [void]$sb.AppendLine("")
    [void]$sb.AppendLine("## Lens: $s"); [void]$sb.AppendLine("")
    [void]$sb.AppendLine((Get-MdBody (Join-Path $Src "skills\$s\SKILL.md")))
    [void]$sb.AppendLine("")
  }
  $script:Bundle = $sb.ToString()
  $script:Bundle
}

# ---- detection ---------------------------------------------------------------
function Have($n){ $null -ne (Get-Command $n -ErrorAction SilentlyContinue) }
$ClineBase = Join-Path $H "Documents\Cline"
function Detect($t){
  switch ($t) {
    'claude'      { (Test-Path "$H\.claude") -or (Have claude) }
    'cursor'      { (Test-Path "$H\.cursor") -or (Have cursor) }
    'codex'       { (Test-Path "$H\.codex") -or (Have codex) }
    'antigravity' { (Test-Path "$H\.gemini\antigravity") -or (Have antigravity) }
    'gemini'      { (Test-Path "$H\.gemini") -or (Have gemini) }
    'aider'       { (Test-Path "$H\.aider.conf.yml") -or (Have aider) }
    'cline'       { Test-Path $ClineBase }
    'opencode'    { (Test-Path "$H\.config\opencode") -or (Have opencode) }
    'windsurf'    { (Test-Path "$H\.codeium\windsurf") -or (Have windsurf) }
    default       { $false }
  }
}

# ---- per-tool install --------------------------------------------------------
function Install-claude {
  Copy-SkillDirs "$H\.claude\skills"; Copy-Commands "$H\.claude\commands"
  Ok "Claude Code -> ~\.claude\{skills,commands}"
}
function Install-cursor {
  Copy-Commands "$H\.cursor\commands"
  Write-Utf8 "$H\.cursor\rules\craft.mdc" ("---`ndescription: Craft frontend design system`nalwaysApply: true`n---`n`n" + (Build-Bundle))
  Ok "Cursor -> ~\.cursor\commands + rules\craft.mdc"
}
function Install-codex {
  Copy-Commands "$H\.codex\prompts"; Inject-Block "$H\.codex\AGENTS.md" (Build-Bundle)
  Ok "Codex CLI -> ~\.codex\prompts + AGENTS.md"
}
function Install-antigravity {
  Copy-SkillDirs "$H\.gemini\antigravity\skills"; Inject-Block "$H\.gemini\GEMINI.md" (Build-Bundle)
  Ok "Antigravity -> ~\.gemini\antigravity\skills + GEMINI.md"
  Skip "Antigravity: global slash-commands unsupported (skills cover it)"
}
function Install-gemini {
  Get-ChildItem -LiteralPath $CmdDir -Filter *.md | ForEach-Object {
    Gemini-Toml $_.FullName (Join-Path "$H\.gemini\commands\craft" ($_.BaseName + ".toml"))
  }
  Inject-Block "$H\.gemini\GEMINI.md" (Build-Bundle)
  Ok "Gemini CLI -> ~\.gemini\commands\craft\*.toml (/craft:<name>) + GEMINI.md"
}
function Install-aider {
  $conv = "$H\.aider-craft-conventions.md"
  Write-Utf8 $conv (Build-Bundle)
  $cfg = "$H\.aider.conf.yml"
  if ((Test-Path -LiteralPath $cfg) -and (Select-String -LiteralPath $cfg -Pattern '^read:' -Quiet)) {
    Skip "Aider: existing 'read:' in .aider.conf.yml - add manually: $conv"
  } else {
    Inject-Block $cfg ("read:`n  - $conv") $YmlStart $YmlEnd
  }
  Ok "Aider -> ~\.aider-craft-conventions.md + ~\.aider.conf.yml"
}
function Install-cline {
  Write-Utf8 "$ClineBase\Rules\craft.md" (Build-Bundle)
  Copy-Commands "$ClineBase\Workflows" "craft-"
  Ok "Cline -> $ClineBase\{Rules,Workflows}"
}
function Install-opencode {
  Copy-Commands "$H\.config\opencode\command"; Inject-Block "$H\.config\opencode\AGENTS.md" (Build-Bundle)
  Ok "opencode -> ~\.config\opencode\command + AGENTS.md"
}
function Install-windsurf {
  Copy-Commands "$H\.codeium\windsurf\global_workflows" "craft-"
  Inject-Block "$H\.codeium\windsurf\memories\global_rules.md" (Build-Bundle)
  Ok "Windsurf -> ~\.codeium\windsurf\{global_workflows,memories\global_rules.md}"
}

# ---- per-tool uninstall ------------------------------------------------------
function Rm-Commands($dir,$prefix=''){
  Get-ChildItem -LiteralPath $CmdDir -Filter *.md | ForEach-Object {
    Remove-Path (Join-Path $dir ($prefix + $_.Name))
  }
}
function Uninstall-One($t){
  switch ($t) {
    'claude'      { foreach($s in $Skills){ Remove-Path "$H\.claude\skills\$s" }; Rm-Commands "$H\.claude\commands" }
    'cursor'      { Remove-Path "$H\.cursor\rules\craft.mdc"; Rm-Commands "$H\.cursor\commands" }
    'codex'       { Strip-Block "$H\.codex\AGENTS.md"; Rm-Commands "$H\.codex\prompts" }
    'antigravity' { foreach($s in $Skills){ Remove-Path "$H\.gemini\antigravity\skills\$s" }; Strip-Block "$H\.gemini\GEMINI.md" }
    'gemini'      { Remove-Path "$H\.gemini\commands\craft"; Strip-Block "$H\.gemini\GEMINI.md" }
    'aider'       { Remove-Path "$H\.aider-craft-conventions.md"; Strip-Block "$H\.aider.conf.yml" $YmlStart $YmlEnd }
    'cline'       { Remove-Path "$ClineBase\Rules\craft.md"; Rm-Commands "$ClineBase\Workflows" "craft-" }
    'opencode'    { Strip-Block "$H\.config\opencode\AGENTS.md"; Rm-Commands "$H\.config\opencode\command" }
    'windsurf'    { Rm-Commands "$H\.codeium\windsurf\global_workflows" "craft-"; Strip-Block "$H\.codeium\windsurf\memories\global_rules.md" }
  }
  Ok "removed Craft from $t"
}

# ---- main --------------------------------------------------------------------
$targets = if ($Tools) { $Tools.Split(',') | ForEach-Object { $_.Trim() } | Where-Object { $_ } } else { $AllTools }

Write-Host "Craft installer  (source: $Src)" -ForegroundColor White
if ($DryRun) { Write-Host "dry-run - no files will be changed" -ForegroundColor Yellow }

$did = $false
foreach ($t in $targets) {
  if ($AllTools -notcontains $t) { Write-Host "Unknown tool: $t" -ForegroundColor Red; continue }
  if ($Uninstall) { Head $t; Uninstall-One $t; $did = $true; continue }
  if ($All -or $Tools -or (Detect $t)) {
    Head $t; & "Install-$t"; $did = $true
  } else {
    Head $t; Skip "not detected - re-run with -All to force"
  }
}

if (-not $did) {
  Write-Host "`nNo tools matched. Try -All to install for every supported CLI."
} else {
  Write-Host "`nDone. Restart your CLI to pick up the new skills/commands." -ForegroundColor Green
}
