#!/usr/bin/env bash
#
# Craft — universal installer for macOS / Linux
#
# Installs the Craft design skill (4 skills + 13 commands) into every major
# AI coding CLI it can find: Claude Code, Cursor, Codex CLI, Google Antigravity,
# Gemini CLI, Aider, Cline, opencode and Windsurf.
#
# One-liner:
#   curl -fsSL https://raw.githubusercontent.com/Muminur/frontend-design-craft-skill/main/install.sh | bash
#
# Flags:
#   --all              install for every supported tool, even if not detected
#   --tools=a,b,c      install only for the named tools (comma-separated)
#   --uninstall        remove everything Craft installed
#   --dry-run          print what would happen, change nothing
#   -h, --help         show help
#
set -euo pipefail

REPO="Muminur/frontend-design-craft-skill"
BRANCH="main"
MARK_START="<!-- CRAFT:START — managed by craft installer, do not edit inside -->"
MARK_END="<!-- CRAFT:END -->"
YML_START="# CRAFT:START — managed by craft installer, do not edit inside"
YML_END="# CRAFT:END"
ALL_TOOLS="claude cursor codex antigravity gemini aider cline opencode windsurf"

# ---- options -----------------------------------------------------------------
DRY=0; FORCE_ALL=0; UNINSTALL=0; ONLY=""
for arg in "$@"; do
  case "$arg" in
    --all) FORCE_ALL=1 ;;
    --uninstall) UNINSTALL=1 ;;
    --dry-run) DRY=1 ;;
    --tools=*) ONLY="${arg#--tools=}" ;;
    -h|--help)
      sed -n '2,22p' "$0" 2>/dev/null | sed 's/^# \{0,1\}//'
      exit 0 ;;
    *) echo "Unknown option: $arg" >&2; exit 2 ;;
  esac
done

# ---- pretty output -----------------------------------------------------------
if [ -t 1 ]; then C_G=$'\033[32m'; C_Y=$'\033[33m'; C_B=$'\033[1m'; C_D=$'\033[2m'; C_0=$'\033[0m'
else C_G=""; C_Y=""; C_B=""; C_D=""; C_0=""; fi
info(){ printf '%s\n' "$*"; }
ok(){   printf '  %s✓%s %s\n' "$C_G" "$C_0" "$*"; }
skip(){ printf '  %s•%s %s%s%s\n' "$C_Y" "$C_0" "$C_D" "$*" "$C_0"; }
head(){ printf '\n%s%s%s\n' "$C_B" "$*" "$C_0"; }

# ---- source resolution -------------------------------------------------------
SRC=""
self_dir=""
if [ -n "${BASH_SOURCE:-}" ] && [ "${BASH_SOURCE[0]:-}" != "bash" ]; then
  self_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd || true)"
fi
if [ -n "$self_dir" ] && [ -f "$self_dir/skills/craft/SKILL.md" ]; then
  SRC="$self_dir"
else
  TMP="$(mktemp -d)"
  trap 'rm -rf "$TMP"' EXIT
  info "Downloading Craft from github.com/$REPO ..."
  url="https://github.com/$REPO/archive/refs/heads/$BRANCH.tar.gz"
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$url" | tar -xz -C "$TMP"
  elif command -v wget >/dev/null 2>&1; then
    wget -qO- "$url" | tar -xz -C "$TMP"
  else
    echo "Need curl or wget to download Craft." >&2; exit 1
  fi
  SRC="$TMP/frontend-design-craft-skill-$BRANCH"
fi
[ -f "$SRC/skills/craft/SKILL.md" ] || { echo "Could not locate Craft source files." >&2; exit 1; }

SKILLS="craft motion polish taste"
CMD_DIR="$SRC/commands"

# ---- helpers -----------------------------------------------------------------
# body of a markdown file with YAML frontmatter stripped
md_body(){ awk 'f>=2{print} /^---[[:space:]]*$/{f++}' "$1"; }
# value of a frontmatter key (first match)
fm_value(){ awk -v k="$2:" 'NR==1&&$0!="---"{exit} /^---[[:space:]]*$/{n++; if(n>=2)exit; next} $0 ~ "^"k {sub("^"k"[[:space:]]*",""); print; exit}' "$1"; }

run(){ # echo + execute, honoring dry-run
  if [ "$DRY" = 1 ]; then printf '    %s$ %s%s\n' "$C_D" "$*" "$C_0"; return 0; fi
  "$@"
}
mkdirp(){ run mkdir -p "$1"; }
copy(){ # copy file/dir (recursive) to dest
  if [ "$DRY" = 1 ]; then printf '    %swrite %s%s\n' "$C_D" "$2" "$C_0"; return 0; fi
  cp -R "$1" "$2"
}
write_file(){ # write_file <path> <<<content (stdin)
  local dest="$1"; mkdirp "$(dirname "$dest")"
  if [ "$DRY" = 1 ]; then printf '    %swrite %s%s\n' "$C_D" "$dest" "$C_0"; cat >/dev/null; return 0; fi
  cat > "$dest"
}

# write a CRAFT-managed block into a (possibly shared) file, replacing any
# previous block delimited by the markers. Backs up once.
inject_block(){ # inject_block <file> <block-content-file> [start-marker] [end-marker]
  local file="$1" blockf="$2" ms="${3:-$MARK_START}" me="${4:-$MARK_END}"
  mkdirp "$(dirname "$file")"
  if [ "$DRY" = 1 ]; then printf '    %supdate block in %s%s\n' "$C_D" "$file" "$C_0"; return 0; fi
  local tmp; tmp="$(mktemp)"
  if [ -f "$file" ]; then
    [ -f "$file.craft.bak" ] || cp "$file" "$file.craft.bak"
    # copy everything outside an existing CRAFT block
    awk -v s="$ms" -v e="$me" '
      $0==s{inblk=1; next} $0==e{inblk=0; next} !inblk{print}' "$file" > "$tmp"
  fi
  { [ -s "$tmp" ] && cat "$tmp" && printf '\n'; printf '%s\n' "$ms"; cat "$blockf"; printf '%s\n' "$me"; } > "$file"
  rm -f "$tmp"
}

strip_block(){ # strip_block <file> [start-marker] [end-marker]
  local file="$1" ms="${2:-$MARK_START}" me="${3:-$MARK_END}"; [ -f "$file" ] || return 0
  if [ "$DRY" = 1 ]; then printf '    %sstrip block from %s%s\n' "$C_D" "$file" "$C_0"; return 0; fi
  local tmp; tmp="$(mktemp)"
  awk -v s="$ms" -v e="$me" '
    $0==s{inblk=1; next} $0==e{inblk=0; next} !inblk{print}' "$file" > "$tmp"
  mv "$tmp" "$file"
}

remove(){ # remove path
  if [ "$DRY" = 1 ]; then printf '    %srm %s%s\n' "$C_D" "$1" "$C_0"; return 0; fi
  rm -rf "$1"
}

# Build the merged CRAFT.md instruction bundle once (for rules-only tools).
BUNDLE=""
build_bundle(){
  [ -n "$BUNDLE" ] && return 0
  BUNDLE="$(mktemp)"
  {
    echo "# Craft — frontend design system"
    echo
    echo "Apply these three lenses to every UI task, in order: Polish (structure), then Taste (distinctiveness), then Motion. Goal: production-grade, intentional interfaces that avoid the generic AI-generated look."
    echo
    for s in $SKILLS; do
      echo "---"
      echo
      echo "## Lens: $s"
      echo
      md_body "$SRC/skills/$s/SKILL.md"
      echo
    done
  } > "$BUNDLE"
}

# Convert each command markdown into a Gemini CLI TOML command.
gemini_toml(){ # gemini_toml <command.md> <dest.toml>
  local f="$1" dest="$2" desc body
  desc="$(fm_value "$f" description)"; desc="${desc//\\/\\\\}"; desc="${desc//\"/\\\"}"
  body="$(md_body "$f" | sed 's/\$ARGUMENTS/{{args}}/g')"
  mkdirp "$(dirname "$dest")"
  if [ "$DRY" = 1 ]; then printf '    %swrite %s%s\n' "$C_D" "$dest" "$C_0"; return 0; fi
  { printf 'description = "%s"\n' "$desc"; printf 'prompt = """\n%s\n"""\n' "$body"; } > "$dest"
}

# ---- detection ---------------------------------------------------------------
H="$HOME"
have(){ command -v "$1" >/dev/null 2>&1; }
case "$(uname -s)" in
  Linux) CLINE_BASE="$H/Cline" ;;
  *)     CLINE_BASE="$H/Documents/Cline" ;;
esac

detect(){
  case "$1" in
    claude)      [ -d "$H/.claude" ] || have claude ;;
    cursor)      [ -d "$H/.cursor" ] || have cursor ;;
    codex)       [ -d "$H/.codex" ] || have codex ;;
    antigravity) [ -d "$H/.gemini/antigravity" ] || have antigravity ;;
    gemini)      [ -d "$H/.gemini" ] || have gemini ;;
    aider)       [ -f "$H/.aider.conf.yml" ] || have aider ;;
    cline)       [ -d "$CLINE_BASE" ] ;;
    opencode)    [ -d "$H/.config/opencode" ] || have opencode ;;
    windsurf)    [ -d "$H/.codeium/windsurf" ] || have windsurf ;;
  esac
}

# ---- per-tool install --------------------------------------------------------
copy_commands_verbatim(){ # copy_commands_verbatim <dir> [prefix]
  local dir="$1" prefix="${2:-}"
  mkdirp "$dir"
  for f in "$CMD_DIR"/*.md; do
    copy "$f" "$dir/$prefix$(basename "$f")"
  done
}
copy_skill_dirs(){ # copy_skill_dirs <skills-root>
  local root="$1"
  for s in $SKILLS; do mkdirp "$root/$s"; copy "$SRC/skills/$s/." "$root/$s"; done
}

install_claude(){
  copy_skill_dirs "$H/.claude/skills"
  copy_commands_verbatim "$H/.claude/commands"
  ok "Claude Code → ~/.claude/{skills,commands}"
}
install_cursor(){
  copy_commands_verbatim "$H/.cursor/commands"
  build_bundle
  { printf -- '---\ndescription: Craft frontend design system\nalwaysApply: true\n---\n\n'; cat "$BUNDLE"; } | write_file "$H/.cursor/rules/craft.mdc"
  ok "Cursor → ~/.cursor/commands + rules/craft.mdc"
}
install_codex(){
  copy_commands_verbatim "$H/.codex/prompts"
  build_bundle; inject_block "$H/.codex/AGENTS.md" "$BUNDLE"
  ok "Codex CLI → ~/.codex/prompts + AGENTS.md"
}
install_antigravity(){
  copy_skill_dirs "$H/.gemini/antigravity/skills"
  build_bundle; inject_block "$H/.gemini/GEMINI.md" "$BUNDLE"
  ok "Antigravity → ~/.gemini/antigravity/skills + GEMINI.md"
  skip "Antigravity: global slash-commands unsupported (skills cover it)"
}
install_gemini(){
  for f in "$CMD_DIR"/*.md; do gemini_toml "$f" "$H/.gemini/commands/craft/$(basename "$f" .md).toml"; done
  build_bundle; inject_block "$H/.gemini/GEMINI.md" "$BUNDLE"
  ok "Gemini CLI → ~/.gemini/commands/craft/*.toml (/craft:<name>) + GEMINI.md"
}
install_aider(){
  build_bundle
  local conv="$H/.aider-craft-conventions.md"
  cat "$BUNDLE" | write_file "$conv"
  local cfg="$H/.aider.conf.yml"
  if [ -f "$cfg" ] && grep -q '^read:' "$cfg" 2>/dev/null; then
    skip "Aider: existing 'read:' in ~/.aider.conf.yml — add manually: $conv"
  else
    local blk; blk="$(mktemp)"; printf 'read:\n  - %s\n' "$conv" > "$blk"
    inject_block "$cfg" "$blk" "$YML_START" "$YML_END"; rm -f "$blk"
  fi
  ok "Aider → ~/.aider-craft-conventions.md + ~/.aider.conf.yml"
}
install_cline(){
  build_bundle
  cat "$BUNDLE" | write_file "$CLINE_BASE/Rules/craft.md"
  copy_commands_verbatim "$CLINE_BASE/Workflows" "craft-"
  ok "Cline → $CLINE_BASE/{Rules,Workflows}"
}
install_opencode(){
  copy_commands_verbatim "$H/.config/opencode/command"
  build_bundle; inject_block "$H/.config/opencode/AGENTS.md" "$BUNDLE"
  ok "opencode → ~/.config/opencode/command + AGENTS.md"
}
install_windsurf(){
  copy_commands_verbatim "$H/.codeium/windsurf/global_workflows" "craft-"
  build_bundle; inject_block "$H/.codeium/windsurf/memories/global_rules.md" "$BUNDLE"
  ok "Windsurf → ~/.codeium/windsurf/{global_workflows,memories/global_rules.md}"
}

# ---- per-tool uninstall ------------------------------------------------------
rm_craft_commands(){ for f in "$CMD_DIR"/*.md; do remove "$1/${2:-}$(basename "$f")"; done; }
uninstall_one(){
  case "$1" in
    claude)      for s in $SKILLS; do remove "$H/.claude/skills/$s"; done; rm_craft_commands "$H/.claude/commands" ;;
    cursor)      remove "$H/.cursor/rules/craft.mdc"; rm_craft_commands "$H/.cursor/commands" ;;
    codex)       strip_block "$H/.codex/AGENTS.md"; rm_craft_commands "$H/.codex/prompts" ;;
    antigravity) for s in $SKILLS; do remove "$H/.gemini/antigravity/skills/$s"; done; strip_block "$H/.gemini/GEMINI.md" ;;
    gemini)      remove "$H/.gemini/commands/craft"; strip_block "$H/.gemini/GEMINI.md" ;;
    aider)       remove "$H/.aider-craft-conventions.md"; strip_block "$H/.aider.conf.yml" "$YML_START" "$YML_END" ;;
    cline)       remove "$CLINE_BASE/Rules/craft.md"; rm_craft_commands "$CLINE_BASE/Workflows" "craft-" ;;
    opencode)    strip_block "$H/.config/opencode/AGENTS.md"; rm_craft_commands "$H/.config/opencode/command" ;;
    windsurf)    rm_craft_commands "$H/.codeium/windsurf/global_workflows" "craft-"; strip_block "$H/.codeium/windsurf/memories/global_rules.md" ;;
  esac
  ok "removed Craft from $1"
}

# ---- main --------------------------------------------------------------------
# resolve target list
if [ -n "$ONLY" ]; then
  TARGETS="$(echo "$ONLY" | tr ',' ' ')"
else
  TARGETS="$ALL_TOOLS"
fi

info "${C_B}Craft installer${C_0}  ${C_D}(source: $SRC)${C_0}"
[ "$DRY" = 1 ] && info "${C_Y}dry-run — no files will be changed${C_0}"

did=0
for t in $TARGETS; do
  case " $ALL_TOOLS " in *" $t "*) ;; *) echo "Unknown tool: $t" >&2; continue ;; esac
  if [ "$UNINSTALL" = 1 ]; then
    head "$t"; uninstall_one "$t"; did=1; continue
  fi
  if [ "$FORCE_ALL" = 1 ] || [ -n "$ONLY" ] || detect "$t"; then
    head "$t"; "install_$t"; did=1
  else
    head "$t"; skip "not detected — re-run with --all to force"
  fi
done

if [ "$did" = 0 ]; then
  printf '\nNo tools matched. Try %s--all%s to install for every supported CLI.\n' "$C_B" "$C_0"
else
  printf '\n%sDone.%s Restart your CLI to pick up the new skills/commands.\n' "$C_G" "$C_0"
fi
