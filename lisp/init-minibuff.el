;;; init-minibuff.el --- Config for minibuffer completion -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package vertico
  :straight (:files (:defaults "extensions/*.el"))
  :init
  (vertico-mode 1)
  :config

  ;; Load extensions
  (require 'vertico-directory)

  ;; Correct file path when changed
  (add-hook 'rfn-eshadow-update-overlay-hook #'vertico-directory-tidy)

  (setq vertico-count 8)
  (setq vertico-resize nil)
  (setq vertico-cycle t)
  :bind
  ((:map vertico-map
         ("<tab>" . vertico-insert)
	 ("RET" . vertico-directory-enter)
         ("DEL" . vertico-directory-delete-char)
         ("s-DEL" . vertico-directory-delete-word))))

;; Persist history over Emacs restarts
(with-eval-after-load 'vertico
  (require 'savehist)
  (savehist-mode 1))

(use-package consult
  :init
  (global-unset-key (kbd "C-x b"))
  (global-set-key (kbd "s-b")
                  'switch-to-buffer)
  (global-set-key [remap switch-to-buffer]
                  'consult-buffer)
  (global-set-key [remap switch-to-buffer-other-window]
                  'consult-buffer-other-window)
  (global-set-key [remap switch-to-buffer-other-frame]
                  'consult-buffer-other-frame)
  (global-set-key [remap goto-line] 'consult-goto-line)

  ;; Customize the register formatting
  (setq register-preview-delay 0.5)
  (setq register-preview-function #'consult-register-format)
  (advice-add #'register-preview
              :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref)
  (setq xref-show-definitions-function #'consult-xref)
  :config
  (setq consult-project-function
        #'consult--default-project-function)

  (setq consult-narrow-key "􀄫")

  ;; Customize Consult buffers
  (with-eval-after-load 'vertico
    (set-face-attribute 'vertico-group-title nil
                        :slant 'normal))

  (add-hook 'completion-list-mode #'consult-preview-at-point-mode)
  :bind
  (("C-s" . consult-line)
   ("M-s" . consult-ripgrep)))


(setq resize-mini-windows t)
(setq minibuffer-eldef-shorten-default t)

(setq echo-keystrokes 0.25)


(use-package embark
  :init  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)
  (setq embark-confirm-act-all nil)
  :config  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none))))
  :bind
  (("C-." . embark-act)
   ("M-." . embark-dwim)
   ("C-h B" . embark-bindings)))

(use-package embark-consult
  :after (embark consult)
  :config
  (add-hook 'embark-collect-mode-hook #'consult-preview-at-point-mode 1))


;; Enable rich annotations
(use-package marginalia
  :init
  (setq marginalia-max-relative-age 0)
  (marginalia-mode 1))


(provide 'init-minibuff)
;;; init-minibuff.el ends here
