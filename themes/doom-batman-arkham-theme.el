;;; doom-batman-arkham-theme.el --- Batman "Arkham" for Doom -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Port of the "arkham" palette from the-coding-doggo/batman.nvim
;; (lua/batman/palette.lua and colors/batman.lua).
;;
;;; Code:

(require 'doom-themes)

(def-doom-theme doom-batman-arkham
  "Batman Arkham: night-blue background with golden accents."
  :family 'doom-batman
  :background-mode 'dark

  ;; name        gui       256         16
  ((bg         '("#0d1216" "black"     "black"))
   (fg         '("#d5d5d5" "#d7d7d7"   "brightwhite"))
   (bg-alt     '("#0a0e12" "black"     "black"))
   (fg-alt     '("#6a7278" "#6c6c6c"   "white"))

   (base0      '("#070a0d" "black"     "black"))
   (base1      '("#0a0e12" "#121212"   "brightblack"))
   (base2      '("#12181d" "#1c1c1c"   "brightblack"))
   (base3      '("#1a2226" "#262626"   "brightblack"))
   (base4      '("#2e383e" "#3a3a3a"   "brightblack"))
   (base5      '("#6a7278" "#6c6c6c"   "brightblack"))
   (base6      '("#8a9298" "#8a8a8a"   "brightblack"))
   (base7      '("#aeb4b8" "#b2b2b2"   "brightblack"))
   (base8      '("#e8e8e8" "#e4e4e4"   "white"))

   (grey       base4)
   (red        '("#c83838" "#d70000"   "red"))
   (orange     '("#d47330" "#d75f00"   "brightred"))
   (green      '("#38b870" "#00af5f"   "green"))
   (teal       '("#30a8c8" "#00afd7"   "brightgreen"))
   (yellow     '("#d4a53a" "#d7af5f"   "yellow"))
   (blue       '("#3a6a9a" "#5f87af"   "brightblue"))
   (dark-blue  '("#2a4a6a" "#005f87"   "blue"))
   (magenta    '("#8a4a8a" "#875f87"   "brightmagenta"))
   (violet     '("#8a4a8a" "#875f87"   "magenta"))
   (cyan       '("#30a8c8" "#00afd7"   "brightcyan"))
   (dark-cyan  '("#3a4a5a" "#444444"   "cyan"))
   (accent     '("#d4a04a" "#d7af5f"   "yellow"))
   (rust       '("#6a4a42" "#5f5f5f"   "red"))

   ;; Syntax classes, as in batman.nvim
   (highlight      accent)
   (vertical-bar   base3)
   (selection      dark-blue)
   (builtin        magenta)
   (comments       base5)
   (doc-comments   (doom-lighten base5 0.2))
   (constants      accent)
   (functions      blue)
   (keywords       yellow)
   (methods        orange)
   (operators      fg)
   (type           yellow)
   (strings        green)
   (variables      fg)
   (numbers        accent)
   (region         base3)
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    yellow)
   (vc-added       green)
   (vc-deleted     red)

   (modeline-fg          fg)
   (modeline-fg-alt      base5)
   (modeline-bg          base3)
   (modeline-bg-inactive bg))

  ;;;; Face tweaks
  (((line-number &override) :foreground base4)
   ((line-number-current-line &override) :foreground accent)
   ((font-lock-comment-face &override) :slant 'italic)
   ((font-lock-keyword-face &override) :weight 'bold)
   ((font-lock-type-face &override) :weight 'bold)
   (font-lock-preprocessor-face :foreground magenta)
   (cursor :background accent)
   (isearch :foreground bg :background accent)
   (lazy-highlight :foreground bg :background yellow)
   (link :foreground accent :underline t)
   (minibuffer-prompt :foreground accent)
   (mode-line :background modeline-bg :foreground modeline-fg)
   (mode-line-inactive :background modeline-bg-inactive :foreground modeline-fg-alt)
   (mode-line-emphasis :foreground accent)
   ;;;; doom-modeline
   (doom-modeline-bar :background accent)
   (doom-modeline-buffer-file :inherit 'mode-line-buffer-id :weight 'bold)
   (doom-modeline-buffer-path :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-buffer-project-root :foreground accent :weight 'bold)
   ;;;; completion (vertico/corfu)
   (vertico-current :background dark-blue :foreground accent)
   (corfu-current :background dark-blue :foreground accent)
   ;;;; treemacs / dired
   (treemacs-root-face :foreground accent :weight 'bold)
   (treemacs-directory-face :foreground accent)
   (dired-directory :foreground accent)
   ;;;; markdown / org
   (markdown-header-face :inherit 'bold :foreground accent)
   ((org-level-1 &override) :foreground accent)
   ;;;; solaire-mode
   (solaire-mode-line-face :inherit 'mode-line :background modeline-bg)
   (solaire-mode-line-inactive-face :inherit 'mode-line-inactive :background modeline-bg-inactive))

  ())

;;; doom-batman-arkham-theme.el ends here
