;; enhance.el --- Credits: loading first -*- lexical-binding: t -*-
;;
;; Copyright © 2022 Ilya.w
;;
;; Author: Ilya.w <ilya.w@icloud.com>
;;
;; This file is not part of GNU Emacs.
;;
;; Commentary:
;;
;; Enhance minibuffer & editors.
;;
;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Completion
;;
;; Company setup
(use-package company
  :init
  (global-company-mode 1)
  :custom
  (company-minimum-prefix-length 3)
  (company-idle-delay 0)
  (company-echo-delay 0)
  (company-selection-wrap-around t)
  (company-tooltip-align-annotations t)
  :bind
  (:map company-active-map
	    ("<escape>" . company-abort)
	    ("C-p" . company-select-previous)
	    ("C-n" . company-select-next))
  (:map company-search-map
	    ("<escape>" . company-search-abort)
	    ("C-p" . company-select-previous)
	    ("C-n" . company-select-next)))

;; Use listed completion style
(use-package vertico
  :init
  (vertico-mode 1))

;; Use orderless completion style
(use-package orderless
  :custom
  (completion-styles '(orderless)))

;; Use the Corfu completion UI
(use-package corfu
  :init
  (corfu-global-mode)
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-separator ?\s)
  (corfu-scroll-margin 5)
  :config
  (setq completion-cycle-threshold 3)
  (setq tab-always-indent 'complete))

;; Completion for parenthesis
(use-package smartparens
  :hook
  (prog-mode . smartparens-mode)
  (org-mode . smartparens-mode)
  :config
  (show-paren-mode 1)
  (setq show-paren-style 'parenthesis)
  (setq show-paren-delay 0))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Template system
;;
;; YASnippet for snippets
(use-package yasnippet
  :init
  (yas-global-mode 1)
  :custom
  (yas-visit-from-menu t)
  (yas-triggers-in-field t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Enhance minibuffer
;;
;; Consult setup
(use-package consult
  :bind
  (("C-s" . consult-line)
   ("M-s" . consult-ripgrep)
   ("s-b" . consult-buffer)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Excellent git client
(use-package magit)

(provide 'enhance)
