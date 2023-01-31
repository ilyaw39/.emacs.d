;;; init-corfu.el --- Completion in buffers -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(setq tab-always-indent 'complete)


;; Add extensions
(use-package cape
  :init
  (push 'cape-dabbrev completion-at-point-functions)
  (push 'cape-file completion-at-point-functions)
  (push 'cape-ispell completion-at-point-functions)
  :config
  (setq cape-dabbrev-min-length 3))


(use-package orderless
  :init
  (setq completion-styles '(orderless partial-completion basic))
  (setq completion-category-defaults nil)
  (setq completion-category-override nil))

(setq completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

(use-package corfu
  :straight (:files (:defaults "extensions/*.el"))
  :init
  (global-corfu-mode 1)
  :config

  ;; Load extensions
  (require 'corfu-history)

  ;; Remember the latest choice
  (corfu-history-mode 1)

  (setq-default corfu-auto t)
  (setq-default corfu-auto-prefix 2)
  (setq-default corfu-cycle t)
  (setq-default corfu-quit-at-boundary t)
  (setq-default corfu-quit-no-match 'separator)
  (setq-default corfu-preselect 'first)

  (with-eval-after-load 'eshell
    (add-hook 'eshell-mode-hook (lambda ()
                                  (setq-local corfu-auto nil))))

  (with-eval-after-load 'org
    ;; Aggressive completion, cheap prefix filtering
    (add-hook 'org-mode-hook #'(lambda ()
                                 (setq-local corfu-auto-delay 0)
                                 (setq-local corfu-auto-prefix 1)
                                 (setq-local completion-styles '(basic)))))
  :bind
  (:map corfu-map
        ("<down>" . corfu-next)
        ("<up>" . corfu-previous)
        ("<space>" . corfu-quit)
        ("<escape>" . corfu-quit)))


(provide 'init-corfu)
;;; init-corfu.el ends here
