<p align="center">
  <img src="assets/logo.svg" alt="Craft — motion, polish, taste" width="540">
</p>

<p align="center">
  <em>A Claude Code plugin for website design. Three lenses, one plugin: intentional motion, typographic polish, and anti-AI-slop taste.</em>
</p>

<p align="center">
  <a href="https://github.com/Muminur/frontend-design-craft-skill/stargazers">
    <img src="https://img.shields.io/github/stars/Muminur/frontend-design-craft-skill?style=for-the-badge&logo=github&label=Star&color=E0A106&labelColor=14171a" alt="Star Craft on GitHub">
  </a>
  <a href="LICENSE">
    <img src="https://img.shields.io/badge/license-MIT-1FA39A?style=for-the-badge&labelColor=14171a" alt="MIT License">
  </a>
  <img src="https://img.shields.io/badge/CLIs-9_supported-E5604D?style=for-the-badge&labelColor=14171a" alt="9 CLIs supported">
</p>

<p align="center">
  <strong>⭐ If Craft makes your frontends look less AI-generated, give it a star</strong> — it helps other people find it.
</p>

---

Most AI-generated frontends share a visual signature — purple-to-blue gradient hero, Inter at every size, three-column feature grid, centered CTA, soft drop shadows everywhere. Craft is the layer that makes Claude Code stop producing that and start producing UIs that look considered.

It synthesizes three philosophies into a single coherent workflow:

| Lens | Owns | Inspired by |
| --- | --- | --- |
| **Motion** | Animation, easing, transitions, choreography | Emil Kowalski's motion work  |
| **Polish** | Typography, spacing, layout, color, hierarchy | Impeccable by Paul Bakaus ) |
| **Taste** | Anti-slop rules, archetype selection, content authenticity | Taste Skill ) |

This plugin is an original synthesis — not a fork of any of the above. If you want the source skills directly, install them from their authors. If you want one unified plugin that applies all three lenses with a single command, this is that.

## Install (one line)

Craft installs itself into **every AI coding CLI it finds** on your machine — no per-tool setup. It only writes to tools it detects; add `--all` / `-All` to force every target.

**macOS / Linux**

```bash
curl -fsSL https://raw.githubusercontent.com/Muminur/frontend-design-craft-skill/main/install.sh | bash
```

**Windows (PowerShell)**

```powershell
irm https://raw.githubusercontent.com/Muminur/frontend-design-craft-skill/main/install.ps1 | iex
```

The piped `irm | iex` form is **not** affected by PowerShell's execution policy. If you instead saved `install.ps1` to disk and Windows blocks it ("running scripts is disabled on this system" / "not digitally signed"), run it bypassing the policy **for that one run only** (this never changes your machine-wide setting):

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -All
```

The script also relaxes the policy for its own process and clears the "downloaded from the internet" block (`Unblock-File`) on itself and anything it downloads, so nested steps don't get blocked.

Restart your CLI afterward to pick up the new skills and commands.

### Supported tools

The installer maps Craft into each tool's native skill / command / rules system (global / user scope):

| Tool | Commands land in | Design rules / skills land in |
| --- | --- | --- |
| **Claude Code** | `~/.claude/commands/` | `~/.claude/skills/{craft,motion,polish,taste}/` |
| **Cursor** | `~/.cursor/commands/` | `~/.cursor/rules/craft.mdc` |
| **Codex CLI** | `~/.codex/prompts/` | `~/.codex/AGENTS.md` |
| **Google Antigravity** | _(skills cover it)_ | `~/.gemini/antigravity/skills/` + `~/.gemini/GEMINI.md` |
| **Gemini CLI** | `~/.gemini/commands/craft/*.toml` → `/craft:<name>` | `~/.gemini/GEMINI.md` |
| **Aider** | _(n/a)_ | `~/.aider-craft-conventions.md` (auto-`read:` in `~/.aider.conf.yml`) |
| **Cline** | `~/Documents/Cline/Workflows/` | `~/Documents/Cline/Rules/craft.md` |
| **opencode** | `~/.config/opencode/command/` | `~/.config/opencode/AGENTS.md` |
| **Windsurf** | `~/.codeium/windsurf/global_workflows/` | `~/.codeium/windsurf/memories/global_rules.md` |

### Installer flags

| Bash | PowerShell | Effect |
| --- | --- | --- |
| `--all` | `-All` | install for every supported tool, even if not detected |
| `--tools=claude,cursor` | `-Tools "claude,cursor"` | install only for the named tools |
| `--dry-run` | `-DryRun` | print what would happen, change nothing |
| `--uninstall` | `-Uninstall` | remove everything Craft installed |

> Edits to shared files (`AGENTS.md`, `GEMINI.md`, `global_rules.md`, `.aider.conf.yml`) are wrapped in `<!-- CRAFT:START -->` … `<!-- CRAFT:END -->` markers and backed up to `*.craft.bak`. Re-running is idempotent; `--uninstall` cleanly removes the block.
>
> To pass flags through the Windows one-liner:
> ```powershell
> & ([scriptblock]::Create((irm https://raw.githubusercontent.com/Muminur/frontend-design-craft-skill/main/install.ps1))) -All
> ```

### Claude Code plugin install (alternative)

As a project plugin:

```bash
git clone https://github.com/Muminur/frontend-design-craft-skill .claude/plugins/craft
```

Or via marketplace:

```bash
/plugin marketplace add your-user/craft-marketplace
/plugin install craft@your-marketplace
```

## How to use

### Auto-invoked

The `craft` skill triggers automatically whenever you ask Claude Code to build, design, redesign, polish, audit, or improve a frontend. You don't need to invoke anything manually — Claude will pick up the design context and apply the three lenses.

### Slash commands (explicit)

When you want to direct a specific kind of work:

| Command | Use when |
| --- | --- |
| `/audit` | First pass on existing site or component. Reports issues, doesn't fix. |
| `/polish` | Final pre-ship pass. Applies all three lenses. |
| `/critique` | UX review. Hierarchy, clarity, what to remove. |
| `/typeset` | Fix typography — fonts, scale, line-height. |
| `/arrange` | Fix layout — spacing, alignment, grid, vertical rhythm. |
| `/animate` | Add or fix motion. |
| `/colorize` | Build or rework color strategy. |
| `/distill` | Strip the interface to what earns its place. |
| `/bolder` | Push a too-safe design. |
| `/quieter` | Tone down a too-loud design. |
| `/delight` | Add one memorable moment, sparingly. |
| `/anti-slop` | Scan and rewrite AI-generated tells. |
| `/extract` | Pull repeated patterns into components and tokens. |

## What's inside

```
craft/
├── .claude-plugin/
│   └── plugin.json
├── skills/
│   ├── craft/SKILL.md          # Main coordinator — picks mode, archetype, dials
│   ├── motion/SKILL.md         # Animation principles + timing/easing reference
│   ├── polish/SKILL.md         # Type, spacing, layout + scale/palette references
│   └── taste/SKILL.md          # Anti-slop + archetype references
├── commands/                   # 13 slash commands (see table above)
├── install.sh                  # one-line installer for macOS / Linux
└── install.ps1                 # one-line installer for Windows
```

## Two modes, three dials

Before generating, Craft sets two things explicitly:

**Mode:**
- **Brand** — marketing, landing pages, portfolios. Bias to expression.
- **Product** — apps, dashboards, internal tools. Bias to clarity.

**Dials (1–10):**
- **VARIANCE** — how far from symmetric/conventional layouts to push
- **MOTION** — how much animation, and how cinematic
- **DENSITY** — how much information per viewport

Brand mode defaults: `VARIANCE 7`, `MOTION 6`, `DENSITY 3`.
Product mode defaults: `VARIANCE 3`, `MOTION 3`, `DENSITY 7`.

Craft will state these explicitly at the start of any design task so you can correct them.

## Style archetypes

Once mode is chosen, Craft picks an archetype:

1. **Editorial / Restrained** — Linear, Vercel, Notion lineage
2. **Soft / Premium** — Apple marketing, calm lifestyle brands
3. **Brutalist / Raw** — Bloomberg, Are.na, modern brutalism
4. **Expressive / Display** — Awwwards winners, agency portfolios
5. **Technical / Engineered** — Stripe, Datadog, developer tools

See `skills/taste/references/archetype-examples.md` for the full breakdown.

## Cross-platform

The Craft skill itself is pure markdown — no hooks, no native dependencies — so it behaves identically on Windows, macOS, and Linux. The only platform-specific pieces are the two install scripts (`install.sh` / `install.ps1`), which simply copy that markdown into each tool's config directory.

## License

MIT. Use it, fork it, ship it.

---

<p align="center">
  <img src="assets/mark.svg" alt="Craft mark" width="72">
</p>
<p align="center">
  <strong>Found Craft useful?</strong> <a href="https://github.com/Muminur/frontend-design-craft-skill/stargazers">Star the repo ⭐</a> so it reaches more people shipping frontends.
</p>
