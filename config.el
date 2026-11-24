;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;; JetBrains Mono (instalada en el sistema).
(setq doom-font (font-spec :family "JetBrains Mono" :size 15.0)
      doom-big-font (font-spec :family "JetBrains Mono" :size 22.0)
      doom-symbol-font (font-spec :family "Symbols Nerd Font Mono"))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-batman-arkham)   ; otros: 'sonokai, 'doom-one
;; Specify both a dark and light theme, like so and Doom will choose which one
;; to load based on your system light/dark setting:
;;
;;   (setq doom-theme '(doom-one   . doom-one-light))   ; (DARK . LIGHT)
;;
;; If you want more pro-active theme switching based on OS light/dark mode, look
;; up the `auto-dark' package.

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(menu-bar-mode -1)
(tool-bar-mode -1)
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;; ------------------------------------------------------------------
;;; Keymaps portados desde github.com/Tinix/nvim-rock (lua/config/keymaps.lua)
;;; ------------------------------------------------------------------

;; Movimiento Dvorak: h t n s = izquierda abajo arriba derecha
;; (igual que en nvim: reemplaza t, n y s; j/k/l siguen funcionando).
(map! :nvm "h" #'evil-backward-char
      :nvm "t" #'evil-next-line
      :nvm "n" #'evil-previous-line
      :nvm "s" #'evil-forward-char)

;; Guardar con C-s
(map! :n "C-s" #'save-buffer)

;; Moverse entre ventanas con C-h/j/k/l
(map! :n "C-h" #'evil-window-left
      :n "C-j" #'evil-window-down
      :n "C-k" #'evil-window-up
      :n "C-l" #'evil-window-right)

;; Redimensionar ventanas con C-flechas
(map! :n "C-<up>"    (cmd! (evil-window-increase-height 2))
      :n "C-<down>"  (cmd! (evil-window-decrease-height 2))
      :n "C-<left>"  (cmd! (evil-window-decrease-width 2))
      :n "C-<right>" (cmd! (evil-window-increase-width 2)))

;; Buffer siguiente/anterior con L / H
(map! :n "L" #'next-buffer
      :n "H" #'previous-buffer)

;; Mover línea o selección: M-S-j/k, C-S-j/k y la variante Dvorak M-S-t/n
(map! :nv "M-J"   #'drag-stuff-down
      :nv "M-K"   #'drag-stuff-up
      :nv "C-S-j" #'drag-stuff-down
      :nv "C-S-k" #'drag-stuff-up
      :nv "M-T"   #'drag-stuff-down
      :nv "M-N"   #'drag-stuff-up)

;; Pegar en visual sin reemplazar el registro (vnoremap p "_dP)
(setq evil-kill-on-visual-paste nil)
;; (< y > en visual ya conservan la selección en Doom.)

;; Árbol de archivos con C-e (NvimTree -> treemacs)
(map! :n "C-e" #'+treemacs/toggle)

;; SPC f f como Telescope find_files: busca por nombre en todo el proyecto
;; (o recursivamente desde la carpeta actual si no hay proyecto).
;; El explorador clásico de Doom sigue en SPC . (find-file).
(defun +my/find-file-proyecto ()
  "Buscar un archivo por nombre en todo el proyecto actual."
  (interactive)
  (doom-project-find-file (or (doom-project-root) default-directory)))

;; SPC y copia al portapapeles del sistema (como "+y en nvim), para pegar
;; en el navegador u otra app. En visual copia la selección (ej.: gg V G SPC y);
;; en normal funciona como operador: SPC y y (línea), SPC y i w (palabra)...
(evil-define-operator +my/copiar-portapapeles (beg end type)
  "Copiar el texto al portapapeles del sistema."
  :move-point nil
  :repeat nil
  (evil-yank beg end type ?+)
  (message "Copiado al portapapeles"))

;; Líder
(map! :leader
      ;; Salir sin guardar (SPC q queda como el menú de Doom; SPC q q sale)
      :desc "Salir de todo sin guardar" "Q" #'evil-quit-all-with-error-code
      :desc "Copiar al portapapeles"   "y" #'+my/copiar-portapapeles

      ;; Telescope -> vertico/consult
      (:prefix "f"
       :desc "Buscar archivo en el proyecto" "f" #'+my/find-file-proyecto
       :desc "Buscar texto (live grep)" "g" #'+default/search-project
       :desc "Buscar buffers"           "b" #'consult-buffer
       :desc "Buscar ayuda"             "h" #'describe-symbol)

      ;; Git (fugitive -> magit). SPC g c c = commit (ya existe en Doom)
      (:prefix "g"
       :desc "Git status" "s" #'magit-status
       :desc "Git push"   "p" #'magit-push-current-to-upstream
       :desc "Git pull"   "P" #'magit-pull-from-upstream
       :desc "Git diff"   "d" #'magit-diff-buffer-file)

      ;; Harpoon (en SPC j porque SPC h es la ayuda de Doom)
      (:prefix ("j" . "harpoon")
       :desc "Agregar archivo" "a" #'harpoon-add-file
       :desc "Menú"            "m" #'harpoon-toggle-quick-menu
       :desc "Archivo 1"       "1" #'harpoon-go-to-1
       :desc "Archivo 2"       "2" #'harpoon-go-to-2
       :desc "Archivo 3"       "3" #'harpoon-go-to-3
       :desc "Archivo 4"       "4" #'harpoon-go-to-4))

;;; ------------------------------------------------------------------
;;; Dvorak en magit, dired y treemacs
;;; t = abajo, n = arriba. Lo que estaba en t/n se mueve a j/k u otra tecla.
;;; ------------------------------------------------------------------

;; Magit: s sigue siendo "stage" (allí no hay movimiento horizontal).
;; t (tag) pasa a j, y n (buscar siguiente) pasa a k.
(defadvice! +dvorak--magit-a (&rest _)
  :after #'evil-collection-magit-setup
  (map! :map magit-mode-map
        :nv "t" #'evil-next-line
        :nv "n" #'evil-previous-line
        :nv "C-w" #'other-window
        :n  "j" #'magit-tag
        :n  "k" #'evil-ex-search-next
        :map magit-blame-read-only-mode-map
        :n  "t" #'evil-next-line
        :n  "n" #'evil-previous-line
        :map git-rebase-mode-map
        :n  "t"   #'evil-next-line
        :n  "n"   #'evil-previous-line
        :n  "M-t" #'git-rebase-move-line-down
        :n  "M-n" #'git-rebase-move-line-up))

;; Dired: t/n recorren los archivos (j/k siguen funcionando).
(defadvice! +dvorak--dired-a (&rest _)
  :after #'evil-collection-dired-setup
  (map! :map dired-mode-map
        :n "t" #'dired-next-line
        :n "n" #'dired-previous-line))

;; Treemacs: t/n abajo/arriba, s abre o expande (como l) y h colapsa.
;; El prefijo de opciones "t ..." (th, tf, tg...) pasa a "T ...".
(after! treemacs-evil
  (define-key evil-treemacs-state-map (kbd "t") nil)
  (define-key evil-treemacs-state-map (kbd "T") treemacs-toggle-map)
  (define-key evil-treemacs-state-map (kbd "t")   #'treemacs-next-line)
  (define-key evil-treemacs-state-map (kbd "n")   #'treemacs-previous-line)
  (define-key evil-treemacs-state-map (kbd "s")   #'treemacs-RET-action)
  (define-key evil-treemacs-state-map (kbd "M-t") #'treemacs-next-neighbour)
  (define-key evil-treemacs-state-map (kbd "M-n") #'treemacs-previous-neighbour)
  (define-key evil-treemacs-state-map (kbd "M-T") #'treemacs-next-line-other-window)
  (define-key evil-treemacs-state-map (kbd "M-N") #'treemacs-previous-line-other-window))

;; C-w salta a la siguiente ventana (treemacs <-> código <-> ...), en ciclo.
;; Reemplaza el prefijo C-w de evil; los comandos de ventana siguen en SPC w.
;; En modo insert C-w sigue borrando la palabra anterior.
(map! :nvm "C-w" #'other-window)
(after! treemacs
  ;; Doom hace que other-window salte treemacs; aquí se incluye en el ciclo.
  (setq treemacs-is-never-other-window nil)
  ;; Un solo clic abre archivos y expande/colapsa carpetas (como nvim-tree).
  (define-key treemacs-mode-map [mouse-1] #'treemacs-single-click-expand-action))
(after! treemacs-evil
  (define-key evil-treemacs-state-map (kbd "C-w") #'other-window)
  ;; C-e también esconde treemacs estando dentro de él
  (define-key evil-treemacs-state-map (kbd "C-e") #'+treemacs/toggle)
  ;; Estilo nvim-tree: a = crear (termina en / para carpeta), r = renombrar
  (define-key evil-treemacs-state-map (kbd "a") #'+my/treemacs-crear)
  (define-key evil-treemacs-state-map (kbd "r") #'treemacs-rename-file))

(defun +my/treemacs-crear ()
  "Crear archivo o carpeta como en nvim-tree.
Si el nombre termina en / se crea una carpeta; si no, un archivo.
Se pueden crear subcarpetas intermedias: lib/nuevo/archivo.ex"
  (interactive)
  (require 'treemacs-file-management)
  (let* ((curr (treemacs--select-file-from-btn
                (treemacs-current-button) "Crear en: " :dir-only))
         (dir (treemacs--add-trailing-slash
               (if (file-directory-p curr) curr (treemacs--parent-dir curr))))
         (input (read-file-name "Crear (termina en / para carpeta): " dir)))
    (cl-letf (((symbol-function 'treemacs--select-file-from-btn) (lambda (&rest _) curr))
              ((symbol-function 'read-file-name) (lambda (&rest _) input)))
      (treemacs--create-file/dir (not (string-suffix-p "/" input))))))

;; Abrir treemacs automáticamente al iniciar Emacs.
;; - Si se inicia dentro de un proyecto, muestra ese proyecto.
;; - Si no (por ejemplo desde ~), abre la última sesión de treemacs, si hay una.
;; - Si se abrió un archivo (emacs archivo.ex), el foco vuelve a ese archivo.
(add-hook! 'window-setup-hook
  (defun +my/treemacs-al-inicio-h ()
    (unless (daemonp)
      (require 'treemacs)
      (let ((win (selected-window))
            (project (treemacs--find-current-user-project)))
        (cond ((and project (not (file-equal-p project "~")))
               (treemacs-add-and-display-current-project-exclusively))
              ((treemacs-workspace->projects (treemacs-current-workspace))
               (treemacs)))
        (when (and (window-live-p win) (buffer-file-name (window-buffer win)))
          (select-window win))))))

;;; ------------------------------------------------------------------
;;; Barra de abajo clásica de Emacs (sin doom-modeline) + a la derecha:
;;; rama de git y versión del lenguaje.
;;; ------------------------------------------------------------------

(defvar +my/version-comandos
  '(((elixir-mode elixir-ts-mode heex-ts-mode) "elixir" ("--version") "Elixir \\([0-9.]+\\)" "Elixir")
    ((python-mode python-ts-mode)              "python3" ("--version") "Python \\([0-9.]+\\)" "Python")
    ((ruby-mode ruby-ts-mode)                  "ruby"   ("--version") "ruby \\([0-9.]+\\)" "Ruby")
    ((go-mode go-ts-mode)                      "go"     ("version")   "go\\([0-9.]+\\)" "Go")
    ((rust-mode rust-ts-mode rustic-mode)      "rustc"  ("--version") "rustc \\([0-9.]+\\)" "Rust")
    ((gleam-ts-mode gleam-mode)                "gleam"  ("--version") "gleam \\([0-9.]+\\)" "Gleam")
    ((js-mode js-ts-mode typescript-mode typescript-ts-mode) "node" ("--version") "v\\([0-9.]+\\)" "Node")
    ((erlang-mode erlang-ts-mode)              "erl"    ("-noshell" "-eval" "io:format(\"OTP ~s\", [erlang:system_info(otp_release)]), halt().") "OTP \\([0-9.]+\\)" "Erlang/OTP")
    ((zig-mode zig-ts-mode)                    "zig"    ("version")   "\\([0-9][0-9.]*\\)" "Zig")
    ((sh-mode bash-ts-mode)                    "bash"   ("--version") "version \\([0-9.]+\\)" "Bash"))
  "Modos, programa, argumentos, regexp de la versión y etiqueta.")

(defvar +my/version-cache (make-hash-table :test 'equal)
  "Versión por (programa . carpeta del proyecto); se calcula una vez.")

(defun +my/version-lenguaje ()
  "Versión del lenguaje del buffer actual, p. ej. \"Elixir 1.16.2\".
Se obtiene en segundo plano (respeta .tool-versions de asdf)."
  (if (derived-mode-p 'emacs-lisp-mode 'lisp-interaction-mode)
      (format "Emacs %s" emacs-version)
    (when-let* ((spec (cl-find-if (lambda (s) (apply #'derived-mode-p (car s)))
                                  +my/version-comandos)))
      (pcase-let* ((`(,_ ,prog ,args ,re ,label) spec)
                   (key (cons prog (or (doom-project-root) default-directory)))
                   (v (gethash key +my/version-cache)))
        (cond
         ((stringp v) (unless (string-empty-p v) v))
         ((eq v 'pendiente) nil)
         ((not (executable-find prog)) (puthash key "" +my/version-cache) nil)
         (t
          (puthash key 'pendiente +my/version-cache)
          (let ((buf (generate-new-buffer " *version-lenguaje*")))
            (make-process
             :name "version-lenguaje" :buffer buf :command (cons prog args)
             :noquery t :connection-type 'pipe
             :sentinel
             (lambda (p _)
               (unless (process-live-p p)
                 (let ((txt (with-current-buffer buf
                              (goto-char (point-min))
                              (when (re-search-forward re nil t)
                                (format "%s %s" label (match-string 1))))))
                   (puthash key (or txt "") +my/version-cache)
                   (kill-buffer buf)
                   (force-mode-line-update t))))))
          nil))))))

(defun +my/rama-git ()
  "Rama de git del buffer actual (tomada de `vc-mode')."
  (when (and vc-mode (stringp vc-mode))
    (let ((s (substring-no-properties vc-mode)))
      (when (string-match "\\`\\s-*[A-Za-z]+[-:@!?]\\(.+\\)\\'" s)
        (match-string 1 s)))))

;; Lado derecho: lenguaje (con versión si se conoce) y rama de git.
(defun +my/mode-line-derecha ()
  (let ((lang (or (+my/version-lenguaje) (format-mode-line mode-name)))
        (rama (+my/rama-git)))
    (concat " "
            (propertize lang 'face 'font-lock-keyword-face)
            (when rama (concat "  " (propertize (concat "\ue725 " rama) 'face 'success)))
            " ")))

;; Lado izquierdo clásico: -UU-:----  archivo   Top L12  <N>
(defvar +my/mode-line-izquierda
  '("%e" mode-line-front-space mode-line-mule-info mode-line-client
    mode-line-modified mode-line-remote "  "
    mode-line-buffer-identification "   " mode-line-position
    evil-mode-line-tag mode-line-misc-info))

(defun +my/mode-line ()
  "Barra estilo Emacs clásico, rellena con guiones, con el lenguaje y la rama a la derecha."
  (let* ((izq (format-mode-line +my/mode-line-izquierda))
         (der (+my/mode-line-derecha))
         (ancho (- (window-total-width) (string-width izq) (string-width der) 3)))
    (concat izq " " (make-string (max 1 ancho) ?-) der "--")))

;; evil no debe insertar su etiqueta por su cuenta (ya va en la parte izquierda).
(setq evil-mode-line-format nil)
;; Doom vacía la barra durante el arranque; si queda vacía, la restaura con este valor.
(put 'mode-line-format 'initial-value '((:eval (+my/mode-line))))
(setq-default mode-line-format '((:eval (+my/mode-line))))

;; C-n / C-p como en nvim-cmp: si el menú está abierto, se mueven por las
;; opciones; si no, lo abren con TODAS las fuentes (LSP + palabras + rutas),
;; no solo con palabras del buffer como hace Doom por defecto.
(defun +my/completar-o-siguiente (&optional n)
  (interactive "p")
  (if (bound-and-true-p corfu--candidates)
      (corfu-next n)
    (completion-at-point)))

(defun +my/completar-o-anterior (&optional n)
  (interactive "p")
  (if (bound-and-true-p corfu--candidates)
      (corfu-previous n)
    (completion-at-point)))

(map! :after corfu
      :map corfu-mode-map
      :i "C-n" #'+my/completar-o-siguiente
      :i "C-p" #'+my/completar-o-anterior)

;; Gleam: modo con tree-sitter y su servidor de lenguaje integrado (gleam lsp).
;; La primera vez: M-x gleam-ts-install-grammar
(use-package! gleam-ts-mode
  :mode ("\\.gleam\\'" . gleam-ts-mode)
  :hook (gleam-ts-mode . eglot-ensure)
  :config
  (after! eglot
    (add-to-list 'eglot-server-programs '(gleam-ts-mode . ("gleam" "lsp")))))

;;; ------------------------------------------------------------------
;;; HTML / HEEx: cerrar etiquetas automáticamente
;;; ------------------------------------------------------------------

;; .heex/.leex/.eex con web-mode: cierra etiquetas solo y tiene emmet
;; (escribe  h1  y presiona TAB  ->  <h1></h1>).
(add-to-list 'auto-mode-alist '("\\.[hl]?eex\\'" . web-mode))
(after! web-mode
  (add-to-list 'web-mode-engines-alist '("elixir" . "\\.[hl]?eex\\'"))
  (setq web-mode-auto-close-style 2        ; cierra al escribir > y también </
        web-mode-enable-auto-closing t
        web-mode-enable-auto-pairing t))

;; Dentro de ~H"""...""" en archivos .ex: al escribir > se agrega el cierre.
;;   <h1>  ->  <h1>|</h1>      <.button class="x">  ->  <.button class="x">|</.button>
(defvar +my/tags-vacios
  '("area" "base" "br" "col" "embed" "hr" "img" "input" "link" "meta"
    "source" "track" "wbr")
  "Etiquetas HTML que no llevan cierre.")

(defun +my/cerrar-tag ()
  "Insertar > y, si se acaba de abrir una etiqueta, agregar su cierre."
  (interactive)
  (insert ">")
  (when (and (nth 3 (syntax-ppss))       ; solo dentro de un string/sigil
             (save-excursion
               (looking-back "<\\([A-Za-z.][A-Za-z0-9._:-]*\\)\\(?:\\s-[^<>]*\\)?>"
                             (line-beginning-position))))
    (let ((tag (match-string 1)))
      (unless (or (eq (char-before (1- (point))) ?/)          ; <br/>
                  (member (downcase tag) +my/tags-vacios))
        (save-excursion (insert "</" tag ">"))))))

(map! :after elixir-mode
      :map elixir-mode-map
      :i ">" #'+my/cerrar-tag)

(defun +my/tab-bar-usuario ()
  "usuario@host a la derecha de la tab-bar."
  (propertize (format " %s@%s " (user-login-name)
                      (car (split-string (system-name) "\\.")))
              'face 'tab-bar-tab-inactive))

(setq tab-bar-show t
      tab-bar-tab-hints t
      tab-bar-close-button-show nil
      tab-bar-new-button-show nil
      tab-bar-format '(tab-bar-format-tabs tab-bar-separator
                       tab-bar-format-align-right +my/tab-bar-usuario))
(tab-bar-mode 1)
