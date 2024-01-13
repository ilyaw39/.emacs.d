;;; init-gui-frames.el --- Behaviours of GUI frames -*- lexical-binding: t -*-

;; Copyright (C) 2021-2023 Sthenno

;; This file is not part of GNU Emacs.

;;; Commentary:
;;; Code:

;;
;; Modus Themes
;;
(require-theme 'modus-themes)
(setq modus-themes-italic-constructs nil)
(setq modus-themes-common-palette-overrides modus-themes-preset-overrides-intense)
(load-theme 'modus-vivendi :no-confirm)

;; Clean up the title bar content
(setq-default frame-title-format nil)
(setq-default ns-use-proxy-icon nil)

;; Customize faces
(set-face-attribute 'button nil
                    :underline "#959595"
                    :foreground 'unspecified)

(set-face-attribute 'link nil :foreground 'unspecified)
(set-face-attribute 'fill-column-indicator nil :height 0.15)
(set-face-background 'fringe (face-attribute 'default :background))

;; Cursor faces
(setq-default cursor-type '(bar . 1))
(setq-default blink-cursor-mode nil)

;; highlight current line
(add-hook 'after-init-hook #'(lambda ()
                               (global-hl-line-mode 1)))

;;
;; Custom font
;;
(set-face-attribute 'default nil :family "Neoheartbeats" :height 140)

;; Ligatures support
(use-package ligature
  :straight t
  :config
  (ligature-set-ligatures '(prog-mode org-mode)
                          '("<---" "<--"  "<<-" "<-" "->" "-->" "--->"
                            "<->" "<-->" "<--->" "<---->" "<!--"
                            "<==" "<===" "<=" "=>" "=>>" "==>" "===>"
                            ">=" "<=>" "<==>" "<===>" "<====>" "<!---"
                            "::" ":::" "==" "!=" "==="
                            "!==" ":=" ":-" ":+" "<*" "<*>" "*>" "<|" "<|>"
                            "|>" "+:" "-:" "=:" "<******>" "++" "+++" "__"))
  (global-ligature-mode 1))

;; Set up font for unicode fontset
(set-fontset-font "fontset-default" 'unicode "SF Pro")
(set-fontset-font "fontset-default" 'han "Noto Serif CJK SC")

;; Note this make all italic font style disabled
(set-face-attribute 'italic nil :slant 'normal)

;; Stop showing fringe bitmaps
(setf (cdr (assq 'continuation fringe-indicator-alist)) '(nil nil))

;;
;; Mode Line settings
;;
(setq-default mode-line-compact t)
(setq-default line-number-mode nil)

;;
;; Beautify `dired.el'
;;
(use-package diredfl
  :straight t
  :config
  (diredfl-global-mode 1))

(provide 'init-gui-frames)
;;;
;; coding: utf-8
;; no-byte-compile: t
;; End:
;;
