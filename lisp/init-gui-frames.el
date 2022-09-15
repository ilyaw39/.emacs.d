;;; init-gui-frames.el --- Behaviour specific to GUI frames -*- lexical-binding: t -*-
;;; Commentary:

;; This file is inspired by https://github.com/purcell/emacs.d/.

;;; Code:


;; Stop C-z from minimizing windows under macOS
(global-set-key (kbd "C-z") 'suspend-frame)


;; Suppress GUI features
(setq use-file-dialog nil)
(setq use-dialog-box nil)
(setq inhibit-startup-screen t)
(setq visible-bell t)


;; Window size and features
(setq-default
 window-resize-pixelwise t
 frame-resize-pixelwise t)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'set-scroll-bar-mode)
  (set-scroll-bar-mode nil))
(menu-bar-mode -1)
(let ((no-border '(internal-border-width . 0)))
  (add-to-list 'default-frame-alist no-border)
  (add-to-list 'default-frame-alist '(width . 105))
  (add-to-list 'default-frame-alist '(height . 40))
  (add-to-list 'initial-frame-alist no-border))


;; Using `M-f' to toggle fullscreen
(global-set-key (kbd "M-ƒ") 'toggle-frame-fullscreen)


;;; Title bar settings
;; Using modern title bar faces
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . light))


;; Default startup message
(defun display-startup-echo-area-message ()
  (message
   "欢迎回来!"))

;; Always show the pointer's position
(setq make-pointer-invisible nil)


;; Cleanup the text & icons
(setq ns-use-proxy-icon nil)
(setq frame-title-format nil)

;;; Diminish prompt messages
;; Disable these messages such ignore unused signals
(defun filter-command-error-function (data context caller)
  (when (not (memq (car data) '(buffer-read-only
                                beginning-of-line
                                end-of-line
                                beginning-of-buffer
                                end-of-buffer)))
    (command-error-default-function data context caller)))
(setq command-error-function #'filter-command-error-function)

;; Disable unnecessary warnings
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'erase-buffer 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)


;; Non-zero values for `line-spacing' can mess up ansi-term and co
;; so we zero it explicitly in those cases
(add-hook 'term-mode-hook
          (lambda ()
            (setq line-spacing 0)))


(provide 'init-gui-frames)
;;; init-gui-frames.el ends here
