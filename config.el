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
;; JetBrains Mono (installed system-wide).
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
(setq doom-theme 'doom-batman-arkham)   ; others: 'sonokai, 'doom-one
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
;;; Keymaps ported from github.com/Tinix/nvim-rock (lua/config/keymaps.lua)
;;; ------------------------------------------------------------------

;; Dvorak movement: h t n s = left down up right
;; (same as in nvim: overrides t, n and s; j/k/l still work).
(map! :nvm "h" #'evil-backward-char
      :nvm "t" #'evil-next-line
      :nvm "n" #'evil-previous-line
      :nvm "s" #'evil-forward-char)

;; Save with C-s
(map! :n "C-s" #'save-buffer)

;; Move between windows with C-h/j/k/l
(map! :n "C-h" #'evil-window-left
      :n "C-j" #'evil-window-down
      :n "C-k" #'evil-window-up
      :n "C-l" #'evil-window-right)

;; Resize windows with C-arrows
(map! :n "C-<up>"    (cmd! (evil-window-increase-height 2))
      :n "C-<down>"  (cmd! (evil-window-decrease-height 2))
      :n "C-<left>"  (cmd! (evil-window-decrease-width 2))
      :n "C-<right>" (cmd! (evil-window-increase-width 2)))

;; Next/previous buffer with L / H
(map! :n "L" #'next-buffer
      :n "H" #'previous-buffer)

;; Move line or selection: M-S-j/k, C-S-j/k and the Dvorak variant M-S-t/n
(map! :nv "M-J"   #'drag-stuff-down
      :nv "M-K"   #'drag-stuff-up
      :nv "C-S-j" #'drag-stuff-down
      :nv "C-S-k" #'drag-stuff-up
      :nv "M-T"   #'drag-stuff-down
      :nv "M-N"   #'drag-stuff-up)

;; Paste in visual mode without replacing the register (vnoremap p "_dP)
(setq evil-kill-on-visual-paste nil)
;; (< and > in visual mode already keep the selection in Doom.)

;; File tree with C-e (NvimTree -> treemacs)
(map! :n "C-e" #'+treemacs/toggle)

;; SPC f f like Telescope find_files: search by name across the whole project
;; (or recursively from the current directory if there is no project).
;; Doom's classic file browser is still on SPC . (find-file).
(defun +my/find-file-in-project ()
  "Find a file by name in the current project."
  (interactive)
  (doom-project-find-file (or (doom-project-root) default-directory)))

;; SPC y copies to the system clipboard (like "+y in nvim), to paste into
;; the browser or another app. In visual mode it copies the selection
;; (e.g. gg V G SPC y); in normal mode it works as an operator:
;; SPC y y (line), SPC y i w (word)...
(evil-define-operator +my/copy-to-clipboard (beg end type)
  "Copy the text to the system clipboard."
  :move-point nil
  :repeat nil
  (evil-yank beg end type ?+)
  (message "Copied to clipboard"))

;; Leader
(map! :leader
      ;; Quit without saving (SPC q stays as Doom's menu; SPC q q quits)
      :desc "Quit all without saving" "Q" #'evil-quit-all-with-error-code
      :desc "Copy to clipboard"       "y" #'+my/copy-to-clipboard

      ;; Telescope -> vertico/consult
      (:prefix "f"
       :desc "Find file in project"   "f" #'+my/find-file-in-project
       :desc "Search text (live grep)" "g" #'+default/search-project
       :desc "Search buffers"         "b" #'consult-buffer
       :desc "Search help"            "h" #'describe-symbol)

      ;; Git (fugitive -> magit). SPC g c c = commit (already in Doom)
      (:prefix "g"
       :desc "Git status" "s" #'magit-status
       :desc "Git push"   "p" #'magit-push-current-to-upstream
       :desc "Git pull"   "P" #'magit-pull-from-upstream
       :desc "Git diff"   "d" #'magit-diff-buffer-file)

      ;; Harpoon (on SPC j because SPC h is Doom's help)
      (:prefix ("j" . "harpoon")
       :desc "Add file" "a" #'harpoon-add-file
       :desc "Menu"     "m" #'harpoon-toggle-quick-menu
       :desc "File 1"   "1" #'harpoon-go-to-1
       :desc "File 2"   "2" #'harpoon-go-to-2
       :desc "File 3"   "3" #'harpoon-go-to-3
       :desc "File 4"   "4" #'harpoon-go-to-4))

;;; ------------------------------------------------------------------
;;; Dvorak in magit, dired and treemacs
;;; t = down, n = up. Whatever was on t/n moves to j/k or another key.
;;; ------------------------------------------------------------------

;; Magit: s is still "stage" (there is no horizontal movement there).
;; t (tag) moves to j, and n (search next) moves to k.
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

;; Dired: t/n move through the files (j/k still work).
(defadvice! +dvorak--dired-a (&rest _)
  :after #'evil-collection-dired-setup
  (map! :map dired-mode-map
        :n "t" #'dired-next-line
        :n "n" #'dired-previous-line))

;; Treemacs: t/n down/up, s opens or expands (like l) and h collapses.
;; The options prefix "t ..." (th, tf, tg...) moves to "T ...".
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

;; C-w jumps to the next window (treemacs <-> code <-> ...), cycling.
;; Replaces evil's C-w prefix; window commands are still on SPC w.
;; In insert mode C-w still deletes the previous word.
(map! :nvm "C-w" #'other-window)
(after! treemacs
  ;; Doom makes other-window skip treemacs; here it is part of the cycle.
  (setq treemacs-is-never-other-window nil)
  ;; A single click opens files and expands/collapses folders (like nvim-tree).
  (define-key treemacs-mode-map [mouse-1] #'treemacs-single-click-expand-action))
(after! treemacs-evil
  (define-key evil-treemacs-state-map (kbd "C-w") #'other-window)
  ;; C-e also hides treemacs from inside it
  (define-key evil-treemacs-state-map (kbd "C-e") #'+treemacs/toggle)
  ;; nvim-tree style: a = create (end with / for a folder), r = rename
  (define-key evil-treemacs-state-map (kbd "a") #'+my/treemacs-create)
  (define-key evil-treemacs-state-map (kbd "r") #'treemacs-rename-file))

(defun +my/treemacs-create ()
  "Create a file or folder like in nvim-tree.
If the name ends with / a folder is created; otherwise, a file.
Intermediate folders can be created too: lib/new/file.ex"
  (interactive)
  (require 'treemacs-file-management)
  (let* ((curr (treemacs--select-file-from-btn
                (treemacs-current-button) "Create in: " :dir-only))
         (dir (treemacs--add-trailing-slash
               (if (file-directory-p curr) curr (treemacs--parent-dir curr))))
         (input (read-file-name "Create (end with / for a folder): " dir)))
    (cl-letf (((symbol-function 'treemacs--select-file-from-btn) (lambda (&rest _) curr))
              ((symbol-function 'read-file-name) (lambda (&rest _) input)))
      (treemacs--create-file/dir (not (string-suffix-p "/" input))))))

;; Open treemacs automatically when Emacs starts.
;; - If started inside a project, show that project.
;; - Otherwise (e.g. from ~), open the last treemacs session, if there is one.
;; - If a file was opened (emacs file.ex), focus goes back to that file.
(add-hook! 'window-setup-hook
  (defun +my/treemacs-on-startup-h ()
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
;;; Classic Emacs bottom bar (no doom-modeline) + on the right:
;;; git branch and language version.
;;; ------------------------------------------------------------------

(defvar +my/version-commands
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
  "Modes, program, arguments, version regexp and label.")

(defvar +my/version-cache (make-hash-table :test 'equal)
  "Version per (program . project directory); computed once.")

(defun +my/language-version ()
  "Language version of the current buffer, e.g. \"Elixir 1.16.2\".
Fetched in the background (respects asdf's .tool-versions)."
  (if (derived-mode-p 'emacs-lisp-mode 'lisp-interaction-mode)
      (format "Emacs %s" emacs-version)
    (when-let* ((spec (cl-find-if (lambda (s) (apply #'derived-mode-p (car s)))
                                  +my/version-commands)))
      (pcase-let* ((`(,_ ,prog ,args ,re ,label) spec)
                   (key (cons prog (or (doom-project-root) default-directory)))
                   (v (gethash key +my/version-cache)))
        (cond
         ((stringp v) (unless (string-empty-p v) v))
         ((eq v 'pending) nil)
         ((not (executable-find prog)) (puthash key "" +my/version-cache) nil)
         (t
          (puthash key 'pending +my/version-cache)
          (let ((buf (generate-new-buffer " *language-version*")))
            (make-process
             :name "language-version" :buffer buf :command (cons prog args)
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

(defun +my/git-branch ()
  "Git branch of the current buffer (taken from `vc-mode')."
  (when (and vc-mode (stringp vc-mode))
    (let ((s (substring-no-properties vc-mode)))
      (when (string-match "\\`\\s-*[A-Za-z]+[-:@!?]\\(.+\\)\\'" s)
        (match-string 1 s)))))

;; Right side: language (with version if known) and git branch.
(defun +my/mode-line-right ()
  (let ((lang (or (+my/language-version) (format-mode-line mode-name)))
        (branch (+my/git-branch)))
    (concat " "
            (propertize lang 'face 'font-lock-keyword-face)
            (when branch (concat "  " (propertize (concat " " branch) 'face 'success)))
            " ")))

;; Classic left side: -UU-:----  file   Top L12  <N>
(defvar +my/mode-line-left
  '("%e" mode-line-front-space mode-line-mule-info mode-line-client
    mode-line-modified mode-line-remote "  "
    mode-line-buffer-identification "   " mode-line-position
    evil-mode-line-tag mode-line-misc-info))

(defun +my/mode-line ()
  "Classic Emacs-style bar, padded with dashes, with language and branch on the right."
  (let* ((left (format-mode-line +my/mode-line-left))
         (right (+my/mode-line-right))
         (width (- (window-total-width) (string-width left) (string-width right) 3)))
    (concat left " " (make-string (max 1 width) ?-) right "--")))

;; evil must not insert its tag on its own (it is already on the left side).
(setq evil-mode-line-format nil)
;; Doom empties the bar during startup; if it ends up empty, restore it with this value.
(put 'mode-line-format 'initial-value '((:eval (+my/mode-line))))
(setq-default mode-line-format '((:eval (+my/mode-line))))

;; C-n / C-p like nvim-cmp: if the menu is open, they move through the
;; candidates; if not, they open it with ALL sources (LSP + words + paths),
;; not just buffer words as Doom does by default.
(defun +my/complete-or-next (&optional n)
  (interactive "p")
  (if (bound-and-true-p corfu--candidates)
      (corfu-next n)
    (completion-at-point)))

(defun +my/complete-or-previous (&optional n)
  (interactive "p")
  (if (bound-and-true-p corfu--candidates)
      (corfu-previous n)
    (completion-at-point)))

(map! :after corfu
      :map corfu-mode-map
      :i "C-n" #'+my/complete-or-next
      :i "C-p" #'+my/complete-or-previous)

;; Gleam: tree-sitter mode with its built-in language server (gleam lsp).
;; First time: M-x gleam-ts-install-grammar
(use-package! gleam-ts-mode
  :mode ("\\.gleam\\'" . gleam-ts-mode)
  :hook (gleam-ts-mode . eglot-ensure)
  :config
  (after! eglot
    (add-to-list 'eglot-server-programs '(gleam-ts-mode . ("gleam" "lsp")))))

;;; ------------------------------------------------------------------
;;; HTML / HEEx: close tags automatically
;;; ------------------------------------------------------------------

;; .heex/.leex/.eex with web-mode: closes tags on its own and has emmet
;; (type  h1  and press TAB  ->  <h1></h1>).
(add-to-list 'auto-mode-alist '("\\.[hl]?eex\\'" . web-mode))
(after! web-mode
  (add-to-list 'web-mode-engines-alist '("elixir" . "\\.[hl]?eex\\'"))
  (setq web-mode-auto-close-style 2        ; closes when typing > and also </
        web-mode-enable-auto-closing t
        web-mode-enable-auto-pairing t))

;; Inside ~H"""...""" in .ex files: typing > adds the closing tag.
;;   <h1>  ->  <h1>|</h1>      <.button class="x">  ->  <.button class="x">|</.button>
(defvar +my/void-tags
  '("area" "base" "br" "col" "embed" "hr" "img" "input" "link" "meta"
    "source" "track" "wbr")
  "HTML tags that have no closing tag.")

(defun +my/close-tag ()
  "Insert > and, if a tag was just opened, add its closing tag."
  (interactive)
  (insert ">")
  (when (and (nth 3 (syntax-ppss))       ; only inside a string/sigil
             (save-excursion
               (looking-back "<\\([A-Za-z.][A-Za-z0-9._:-]*\\)\\(?:\\s-[^<>]*\\)?>"
                             (line-beginning-position))))
    (let ((tag (match-string 1)))
      (unless (or (eq (char-before (1- (point))) ?/)          ; <br/>
                  (member (downcase tag) +my/void-tags))
        (save-excursion (insert "</" tag ">"))))))

(map! :after elixir-mode
      :map elixir-mode-map
      :i ">" #'+my/close-tag)

;;; ------------------------------------------------------------------
;;; Top tab-bar: numbered tabs, no buttons, user@host on the right
;;; ------------------------------------------------------------------

(defun +my/tab-bar-user ()
  "user@host on the right side of the tab-bar."
  (propertize (format " %s@%s " (user-login-name)
                      (car (split-string (system-name) "\\.")))
              'face 'tab-bar-tab-inactive))

(setq tab-bar-show t
      tab-bar-tab-hints t
      tab-bar-close-button-show nil
      tab-bar-new-button-show nil
      tab-bar-format '(tab-bar-format-tabs tab-bar-separator
                       tab-bar-format-align-right +my/tab-bar-user))
(tab-bar-mode 1)
