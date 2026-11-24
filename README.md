# Emacs Rocky

My [Doom Emacs](https://github.com/doomemacs/doomemacs) configuration, largely ported from my Neovim setup ([nvim-rock](https://github.com/Tinix/nvim-rock)).

> **Heads up: this config is built for the Dvorak keyboard layout.**
> The basic movement keys are remapped (see [Dvorak layout](#dvorak-layout)). If you type on QWERTY, remove or adapt the Dvorak section in `config.el` before using it.

## Installation

Requires Emacs 30 and Doom Emacs installed in `~/.config/emacs`.

```sh
git clone https://github.com/Tinix/Emacs-Rocky.git ~/.config/doom
~/.config/emacs/bin/doom sync
```

System dependencies (Debian):

```sh
# vterm (terminal emulator)
sudo apt install cmake libtool-bin libvterm-dev
# fonts: JetBrains Mono and Symbols Nerd Font Mono
```

## Files

| File | Contents |
|---|---|
| `init.el` | Enabled Doom modules |
| `packages.el` | Extra packages |
| `config.el` | Personal config (UI, keymaps, modeline, tab-bar…) |
| `custom.el` | Variables saved by `M-x customize` |
| `themes/doom-batman-arkham-theme.el` | Custom theme, a port of the "arkham" palette from batman.nvim |

## Interface

- **Theme:** `doom-batman-arkham`. `sonokai` is installed as well.
- **Font:** JetBrains Mono 15 (22 in `doom-big-font-mode`).
- **No menu-bar, tool-bar or scroll-bar.**
- **Tab-bar at the top** with numbered tabs (`1 *vterm*  2 gc.c  3 make`), no close or new-tab buttons, and `user@host` on the right.
- **Classic Emacs modeline** (no doom-modeline), padded with dashes, showing the language with its version (Elixir, Python, Go, Rust…) and the git branch on the right.
- **Treemacs** opens automatically on startup with the current project.

## Notable modules

- Completion: `vertico`, `corfu +orderless`
- Editing: `evil +everywhere`, `format`, `snippets`, `fold`
- Tools: `magit`, `lsp +eglot`, `vterm`, `treemacs`, `workspaces`
- Languages (with LSP): Elixir, Erlang, Go, Python, Ruby (+Rails), Rust, Zig, plus Gleam (`gleam-ts-mode`), web, sh, markdown and org

## Dvorak layout

In Vim, `h j k l` move left, down, up and right because those keys sit under the right hand on a QWERTY keyboard. On **Dvorak**, those positions hold different letters, and the keys under the right hand's home row are **`h t n s`**.

This config maps movement onto those keys, in the same order as Vim:

```
 Dvorak (right-hand home row)     Vim equivalent
    h    t    n    s              h    j    k    l
    ←    ↓    ↑    →              ←    ↓    ↑    →
```

What that implies:

- `j`, `k` and `l` keep working too, so either set of keys moves you around.
- Vim's own `t` (till char), `n` (next search match) and `s` (substitute) are taken over by movement in normal, visual and motion state. Use `f`/`F` to jump to a character, `N` or `*`/`#` for search, and `cl` instead of `s`.
- `evil-snipe` is disabled because it also uses `s` and `t`.
- The same scheme is applied to **magit, dired and treemacs**. The commands that lived on `t` and `n` move to other keys (see the tables below).

## Keybindings

Notation: `C-` = Ctrl, `M-` = Alt, `S-` = Shift, `SPC` = leader key. Modes: *normal* (n), *visual* (v), *insert* (i).

### Movement (Dvorak)

| Key | Mode | Action |
|---|---|---|
| `h` | n v | Left |
| `t` | n v | Down |
| `n` | n v | Up |
| `s` | n v | Right |
| `j` / `k` / `l` | n v | Down / up / right (Vim defaults, still active) |

### Windows and buffers

| Key | Mode | Action |
|---|---|---|
| `C-h` / `C-j` / `C-k` / `C-l` | n | Move to the window left / down / up / right |
| `C-<up>` / `C-<down>` | n | Increase / decrease window height |
| `C-<left>` / `C-<right>` | n | Decrease / increase window width |
| `C-w` | n v | Next window, in a cycle (includes treemacs). Replaces evil's `C-w` prefix; window commands are under `SPC w` |
| `C-w` | i | Delete previous word (unchanged) |
| `H` / `L` | n | Previous / next buffer |

### Editing

| Key | Mode | Action |
|---|---|---|
| `C-s` | n | Save file |
| `M-J` / `M-K` | n v | Move line or selection down / up |
| `C-S-j` / `C-S-k` | n v | Move line or selection down / up |
| `M-T` / `M-N` | n v | Move line or selection down / up (Dvorak variant) |
| `p` | v | Paste without overwriting the register (like `"_dP` in Vim) |
| `C-n` / `C-p` | i | Open completion with every source (LSP, words, paths), or move through the candidates if the menu is open |

### Leader (`SPC`)

| Key | Action |
|---|---|
| `SPC f f` | Find file by name in the project (or recursively from the current directory) |
| `SPC f g` | Search text in the project (live grep) |
| `SPC f b` | Search buffers |
| `SPC f h` | Search help / symbols |
| `SPC .` | Doom's file browser (`find-file`) |
| `SPC y` | Copy to the system clipboard. It is an operator: `SPC y y` (line), `SPC y i w` (word); in visual, copies the selection (e.g. `gg V G SPC y`) |
| `SPC g s` | Git status (magit) |
| `SPC g p` | Git push to upstream |
| `SPC g P` | Git pull from upstream |
| `SPC g d` | Git diff of the current file |
| `SPC g c c` | Git commit (Doom default) |
| `SPC j a` | Harpoon: add the current file |
| `SPC j m` | Harpoon: open the menu |
| `SPC j 1` … `SPC j 4` | Harpoon: go to file 1 … 4 |
| `SPC o t` | Toggle vterm popup |
| `SPC o T` | Open vterm in the current window |
| `SPC Q` | Quit everything without saving |
| `SPC q q` | Quit Emacs (Doom default) |

### Tabs (tab-bar)

Each tab shows the buffer of its active window, numbered from 1.

| Key | Action |
|---|---|
| `C-x t 2` | New tab |
| `C-x t 0` | Close the current tab |
| `C-x t o` / `C-x t O` | Next / previous tab |
| `C-x t RET` | Switch to a tab by name |
| `C-x t r` | Rename the current tab |
| `C-x t m` | Move the current tab |

The `workspaces` module keeps a separate set of tabs per workspace. In normal mode, `gt` / `gT` switch **workspaces** (not tabs). Workspace commands live under `SPC TAB` (`SPC TAB n` new, `SPC TAB 1-9` switch, `SPC TAB d` delete).

### Treemacs (nvim-tree style)

| Key | Action |
|---|---|
| `C-e` | Show / hide treemacs (works from inside it too) |
| `t` / `n` | Down / up |
| `s` | Open file or expand folder (like `RET`) |
| `h` | Collapse |
| `M-t` / `M-n` | Next / previous sibling |
| `M-T` / `M-N` | Move one line down / up in the other window |
| `a` | Create a file; end the name with `/` to create a folder. Intermediate folders are created too (`lib/new/file.ex`) |
| `r` | Rename |
| `T …` | Treemacs toggle options (used to be `t …`: `T h` hidden files, `T f` follow, `T g` git…) |
| `C-w` | Next window |
| Single click | Open file / expand or collapse folder |

### Magit

| Key | Action |
|---|---|
| `t` / `n` | Down / up |
| `s` | Stage (unchanged) |
| `j` | Tag (used to be `t`) |
| `k` | Next search match (used to be `n`) |
| `C-w` | Next window |

In **magit-blame**, `t` / `n` move down / up. In **interactive rebase**, `t` / `n` move down / up and `M-t` / `M-n` move the commit down / up.

### Dired

| Key | Action |
|---|---|
| `t` / `n` | Next / previous file |

### Elixir / HEEx

- `.heex`, `.leex` and `.eex` files open in `web-mode` and close tags automatically, with emmet (`h1` + `TAB` → `<h1></h1>`).
- Inside `~H"""…"""` in `.ex` files, typing `>` adds the closing tag: `<h1>` → `<h1>|</h1>`. Void tags (`br`, `img`, `input`…) and self-closing tags (`<br/>`) are left alone.

### Gleam

`.gleam` files use `gleam-ts-mode` with the built-in language server (`gleam lsp`) via eglot. The first time, run `M-x gleam-ts-install-grammar`.

## Doom CLI commands

| Command | When to use it |
|---|---|
| `doom sync` | After editing `init.el` or `packages.el` |
| `doom upgrade` | Update Doom and its packages |
| `doom doctor` | Diagnose problems in the installation |
| `emacs --debug-init` | Start Emacs showing the full error if something in the config fails |

`config.el` changes don't need `doom sync`; just restart Emacs.

## License

[MIT](LICENSE)
