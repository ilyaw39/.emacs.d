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
;; (setq frame-title-format
;; 	'(:eval
;; 		 (if buffer-file-name
;; 			 (abbreviate-file-name buffer-file-name) "%b")))
;;
;; Hide frame title
(setq frame-title-format nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Cursor settings
(setq-default cursor-type '(bar . 1))
(blink-cursor-mode -1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Highlight lines
(add-hook 'prog-mode-hook 'hl-line-mode)

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
	:height 145)

(set-face-attribute 'variable-pitch nil
	:font "FiraGo"
	:weight 'Book
	:height 155)

(set-fontset-font "fontset-default" 'han "Noto Sans CJK SC")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Improve the readability by increasing line spacing
(setq-default line-spacing 6)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Modus themes
(use-package modus-themes
	:init (modus-themes-load-themes)
	:custom
	(modus-themes-subtle-line-numbers t)
	(modus-themes-lang-checkers '(straight-underline))
	(modus-themes-mode-line '(borderless))
	(modus-themes-syntax '(green-strings))
	(modus-themes-completions 'moderate)
	(modus-themes-hl-line '(underline accented))
	(modus-themes-paren-match '(underline intense))
	(modus-themes-links '(neutral-underline))
	(modus-themes-org-blocks 'tinted-background)
	(modus-themes-box-buttons '(flat))
	(modus-themes-prompts '(intense background))
	:config (modus-themes-load-vivendi))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Use single line as modeline
;; (use-package emacs
;; 	:custom-face
;; 	(mode-line ((t (:height 0.1))))
;; 	(mode-line-inactive ((t (:inherit mode-line))))
;; 	:config (setq-default mode-line-format '("")))
;;
;; Hide modeline
(setq-default mode-line-format nil)

(provide 'ui)
