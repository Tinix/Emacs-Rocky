# emacs-rocks

Mi configuración de [Doom Emacs](https://github.com/doomemacs/doomemacs), portada en buena parte desde mi config de Neovim ([nvim-rock](https://github.com/Tinix/nvim-rock)). Pensada para teclado **Dvorak**.

## Instalación

Requiere Emacs 30 y Doom Emacs instalado en `~/.config/emacs`.

```sh
git clone https://github.com/Tinix/emacs-rocks.git ~/.config/doom
~/.config/emacs/bin/doom sync
```

Dependencias del sistema (Debian):

```sh
# vterm
sudo apt install cmake libtool-bin libvterm-dev
# fuentes: JetBrains Mono y Symbols Nerd Font Mono
```

## Archivos

| Archivo | Contenido |
|---|---|
| `init.el` | Módulos de Doom activados |
| `packages.el` | Paquetes extra |
| `config.el` | Configuración personal (UI, keymaps, modeline, tab-bar…) |
| `custom.el` | Variables guardadas por `M-x customize` |
| `themes/doom-batman-arkham-theme.el` | Tema propio, port de la paleta "arkham" de batman.nvim |

## Interfaz

- **Tema:** `doom-batman-arkham`. También está instalado `sonokai`.
- **Fuente:** JetBrains Mono 15 (22 en `doom-big-font-mode`).
- **Sin menu-bar, tool-bar ni scroll-bar.**
- **Tab-bar arriba** con tabs numeradas (`1 *vterm*  2 gc.c  3 make`), sin botones de cerrar ni de nueva tab, y `usuario@host` a la derecha.
- **Modeline clásico de Emacs** (sin doom-modeline), rellenado con guiones y con el lenguaje con su versión (Elixir, Python, Go, Rust…) y la rama de git a la derecha.
- **Treemacs** se abre solo al iniciar, con el proyecto actual.

## Módulos destacados

- Completado: `vertico`, `corfu +orderless`
- Edición: `evil +everywhere`, `format`, `snippets`, `fold`
- Herramientas: `magit`, `lsp +eglot`, `vterm`, `treemacs`, `workspaces`
- Lenguajes (con LSP): Elixir, Erlang, Go, Python, Ruby (+Rails), Rust, Zig, además de Gleam (`gleam-ts-mode`), web, sh, markdown y org

## Atajos

### Movimiento Dvorak

| Tecla | Acción |
|---|---|
| `h` `t` `n` `s` | izquierda, abajo, arriba, derecha (`j`/`k`/`l` siguen funcionando) |

Lo mismo en magit, dired y treemacs. En magit, `t` (tag) pasa a `j` y `n` (buscar siguiente) a `k`. En treemacs, el prefijo de opciones `t …` pasa a `T …`. `evil-snipe` está desactivado para liberar `s` y `t`.

### General

| Tecla | Acción |
|---|---|
| `C-s` | Guardar |
| `C-h/j/k/l` | Moverse entre ventanas |
| `C-<flechas>` | Redimensionar ventanas |
| `C-w` | Siguiente ventana (incluye treemacs) |
| `H` / `L` | Buffer anterior / siguiente |
| `M-J` / `M-K` (o `M-T` / `M-N`) | Mover línea o selección |
| `C-e` | Mostrar/ocultar treemacs |
| `C-n` / `C-p` (insert) | Abrir completado o moverse por él |

### Líder (`SPC`)

| Tecla | Acción |
|---|---|
| `SPC f f` | Buscar archivo en el proyecto |
| `SPC f g` | Buscar texto (live grep) |
| `SPC f b` | Buscar buffers |
| `SPC f h` | Buscar ayuda |
| `SPC y` | Copiar al portapapeles del sistema |
| `SPC g s/p/P/d` | Git status / push / pull / diff |
| `SPC j a/m/1-4` | Harpoon: agregar, menú, ir al archivo 1-4 |
| `SPC Q` | Salir sin guardar |
| `SPC o t` | Abrir vterm |

### Treemacs (estilo nvim-tree)

| Tecla | Acción |
|---|---|
| `s` / clic | Abrir archivo o expandir carpeta |
| `a` | Crear archivo (termina en `/` para carpeta) |
| `r` | Renombrar |

### Elixir / HEEx

En `.heex`/`.eex` (web-mode) y dentro de `~H"""…"""`, al escribir `>` se cierra la etiqueta sola.
