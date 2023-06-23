;; init.el --- Load the full configuration -*- lexical-binding: t -*-
;;
;; This file is not part of GNU Emacs.
;;
;; Commentary:
;;
;; This file bootstraps the configuration.
;;
;; Code:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Speed up startup
;;
;; Defer garbage collection further back in the startup process
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; To enhance the core performance
;;
;; Misc settings
(setq-default bidi-display-reordering 'left-to-right)
(setq-default cursor-in-non-selected-windows nil)
(setq highlight-nonselected-windows nil)
(setq fast-but-imprecise-scrolling t)
(setq redisplay-skip-fontification-on-input t)
(setq frame-inhibit-implied-resize t)
(setq ffap-machine-p-known 'reject)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Initialize packages
(require 'package)
(require 'cl-lib)

(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

;; Install into separate package dirs for each Emacs version
(setq package-user-dir (expand-file-name (format "elpkg-%s.%s"
                                                 emacs-major-version
                                                 emacs-minor-version)
                                         user-emacs-directory))

(unless (bound-and-true-p package--initialized)
  (setq package-enable-at-startup nil)
  (package-initialize))

(use-package diminish
  :ensure t
  :config
  (diminish 'eldoc-mode))

(use-package bind-key :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Garbage Collector Magic Hack
(use-package gcmh
  :ensure t
  :diminish (gcmh-mode)
  :config
  (setq gcmh-idle-delay 'auto)
  (setq gcmh-auto-idle-delay-factor 10)
  (setq gcmh-high-cons-threshold most-positive-fixnum)
  (gcmh-mode 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; To measure the startup time
(use-package benchmark-init
  :ensure t
  :config
  (add-hook 'after-init-hook #'benchmark-init/deactivate))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Bootstrap process
;;
;; Load path
(push (expand-file-name "lisp/" user-emacs-directory) load-path)

;; Setup `custom.el'
(setq custom-file (locate-user-emacs-file "custom.el"))

;; Call the function to setup Org Mode
;;
;; Site packages
(use-package org
  :load-path "site-lisp/org-lisp/")

(use-package hl-column
  :load-path "site-lisp/emacs-hl-column/"
  :diminish (hl-column-mode)
  :config
  (add-hook 'prog-mode-hook #'(lambda ()
                                (hl-column-mode 1))))

(use-package copilot
  :load-path "site-lisp/copilot.el/"
  :defer t
  :diminish (copilot-mode)
  :init
  (use-package dash
    :ensure t
    :demand t)
  (use-package editorconfig
    :ensure t
    :demand t)
  :config
  (define-key copilot-completion-map (kbd "s-.") 'copilot-accept-completion)
  (add-hook 'prog-mode-hook #'(lambda ()
                                (copilot-mode 1))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Load components
(require 'init-system)
(require 'init-gui-frames)
(require 'init-editing-utils)
(require 'init-projects)
(require 'init-comp)
(require 'init-temp)
(require 'init-org)
(require 'init-eglot)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; init.el ends here
