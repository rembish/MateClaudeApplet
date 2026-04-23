# mate-claude-applet

A MATE panel applet that shows your Claude plan usage — 5-hour rolling window and weekly utilisation — directly in the panel with colour-coded indicators and reset times.

## Requirements

- MATE desktop (Linux Mint or similar)
- Claude Code installed and authenticated (`claude` CLI)
- `python3-gi`, `gir1.2-matepanelapplet-4.0`, `gir1.2-gtk-3.0`
- `debhelper` (build only)

## Build & install

```sh
make install        # build .deb and install with dpkg
```

Or separately:

```sh
make build          # produces ../mate-claude-applet_*.deb
sudo dpkg -i ../mate-claude-applet_*.deb
```

## Adding to the panel

Right-click the MATE panel → **Add to Panel** → **Claude Usage**.

If the applet doesn't appear in the list, restart the panel first:

```sh
mate-panel --replace &
```

## Authentication

The applet reads credentials from the same location as Claude Code:

- `~/.claude/.credentials.json` → `claudeAiOauth.accessToken`
- or the `CLAUDE_CODE_OAUTH_TOKEN` environment variable
- or the system keyring via `secret-tool`

Run `claude` once to authenticate if the applet shows a token error.

## Usage data

Usage is fetched from `https://api.anthropic.com/api/oauth/usage` and cached in `/tmp/claude/statusline-usage-cache.json` for 60 seconds, shared with the Claude Code status line script.

## Other targets

```sh
make clean          # remove build artifacts
make uninstall      # dpkg -r mate-claude-applet
make reinstall      # uninstall + install
make lint           # run lintian on the .deb
```
