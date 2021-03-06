;; ui.el --- Credits: loading first -*- lexical-binding: t -*-
;;
;; Copyright © 2022 Ilya.w
;;
;; Author: Ilya.w <ilya.w@icloud.com>
;;
;; This file is not part of GNU Emacs.
;;
;; Commentary:
;;
;; Emacs frame UI setup.
;;
;; Code:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Remove uneccessary components
;;
;; Remove frame components
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Default startup message
(defun display-startup-echo-area-message ()
  (message
   "Funding for this program was made possible by viewers like you."))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Frame title setup
;;
;; Show icon & full path in title bar
(setq frame-title-format
	    '(:eval
		    (if buffer-file-name
			      (abbreviate-file-name buffer-file-name) "%b")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Cursor settings
;; (setq-default cursor-type '(bar . 1))
(blink-cursor-mode -1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Highlight lines
;; (add-hook 'prog-mode-hook 'hl-line-mode)
(global-hl-line-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Rainbow delimiters
(use-package rainbow-delimiters
	:hook (prog-mode . rainbow-delimiters-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Font settings
(set-face-attribute 'default nil
	                  :font "Fira Code"
	                  :height 140)

;; (set-fontset-font "fontset-default" 'unicode "PragmataPro Mono Liga")
(set-fontset-font "fontset-default" 'han "Noto Sans CJK SC")
(set-fontset-font "fontset-default" 'kana "Noto Sans CJK JP")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Modus themes
(use-package modus-themes
	:init (modus-themes-load-themes)
	:custom
	(modus-themes-subtle-line-numbers t)
	(modus-themes-syntax '(green-strings))
	(modus-themes-hl-line '(underline accented))
	(modus-themes-links '(neutral-underline))
	:config
	(modus-themes-load-vivendi))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Use single line as mode line
;; (use-package emacs
;; 	:custom-face
;; 	(mode-line ((t (:height 0.1))))
;; 	(mode-line-inactive ((t (:inherit mode-line))))
;; 	:config (setq-default mode-line-format '("")))
;;
;; Hide mode line
(setq-default mode-line-format nil)

(provide 'ui)
