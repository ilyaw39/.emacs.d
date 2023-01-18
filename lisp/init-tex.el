;;; init-tex.el --- LaTeX configuration -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Install AUCTeX
(use-package latex
  :straight auctex)

(with-eval-after-load 'LaTeX-mode
  (setq TeX-engine 'xetex)
  (setq TeX-master nil)
  (setq TeX-PDF-mode t)
  (setq reftex-plug-into-AUCTeX t)
  (setq TeX-auto-save t)
  (setq TeX-parse-self t))

(add-hook 'LaTeX-mode-hook #'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook #'turn-on-reftex)


(setq-default org-latex-preview-ltxpng-directory
              (expand-file-name "ltximg/" user-emacs-directory))

;; Setup `dvisvgm' to preview LaTeX fragments
(setq org-preview-latex-default-process 'dvisvgm)
(setq org-preview-latex-process-alist
      '((dvisvgm
         :programs ("latex" "dvisvgm")
         :description "dvi > svg"
         :image-input-type "dvi"
         :image-output-type "svg"
         :image-size-adjust (1.7 . 1.5)
         :latex-compiler
         ("latex -interaction nonstopmode -output-directory %o %f")
         :image-converter
         ("dvisvgm %f --no-fonts --exact-bbox --scale=%S --output=%O"))))

;; Org LaTeX packages
(setq org-latex-packages-alist
      '(("" "mathtools" t)
        ("retain-explicit-decimal-marker" "siunitx" t)
        ("" "physics" t)
        ("version=4" "mhchem" t)
        ("" "mlmodern" t)))

(setq org-format-latex-options
      '(
        :foreground default
        :background "Transparent"
        :scale 1.55
        :html-foreground default
        :html-background "Transparent"
        :html-scale 1.25
        :matchers '("begin" "$1" "$" "\\[")))

;; Match the text baseline of an LaTeX fragment to the surrounding text
(defun my/org--latex-header-preview (orig &rest args)
  "Setup dedicated `org-format-latex-header'
to `my/org--match-text-baseline-ascent'."
  (let ((org-format-latex-header "\\documentclass[preview]{standalone}
  \\usepackage[usenames]{color}
  [PACKAGES]
  [DEFAULT-PACKAGES]"))
    (apply orig args)))

(defun my/org--match-text-baseline-ascent (imagefile)
  "Set `:ascent' to match the text baseline of an image to the surrounding text.
  Calculate `ascent' with the data collected in IMAGEFILE."
  (advice-add 'org-create-formula-image :around #'my/org--latex-header-preview)
  (let* ((viewbox (split-string
                   (xml-get-attribute (car (xml-parse-file imagefile)) 'viewBox)))
         (min-y (string-to-number (nth 1 viewbox)))
         (height (string-to-number (nth 3 viewbox)))
         (ascent (round (* -100 (/ min-y height)))))
    (if (or (< ascent 0) (>= ascent 100))
        'center
      ascent)))

(defun org--make-preview-overlay (beg end image &optional imagetype)
  "Build an overlay between BEG and END using IMAGE file.
  Argument IMAGETYPE is the extension of the displayed image,
  as a string.  It defaults to \"png\"."
  (let ((ov (make-overlay beg end))
	(imagetype (or (intern imagetype) 'png)))
    (let ((ascent (my/org--match-text-baseline-ascent image)))
      (overlay-put ov 'org-overlay-type 'org-latex-overlay)
      (overlay-put ov 'evaporate t)
      (overlay-put ov
		   'modification-hooks
		   (list (lambda (o _flag _beg _end &optional _l)
			   (delete-overlay o))))
      (overlay-put ov
		   'display
		   (list 'image :type imagetype :file image :ascent ascent)))))

;; From: `https://kitchingroup.cheme.cmu.edu/blog/'
;; Justify displaying math equations
(defun my/org--justify-fragment-overlay (beg end image imagetype)
  "Center LaTeX fragments in display."
  (let* ((img (create-image image 'svg t))
         (ov (car (overlays-at (/ (+ beg end) 2) t)))
         (width (car (image-display-size (overlay-get ov 'display))))
         (display-p (/= (char-after beg) 36))
         offset)
    (when (and (= beg (line-beginning-position))
               display-p)
      (setq offset (floor (- (/ fill-column 2)
                             (/ width 2))))
      (when (< offset 0)
        (setq offset 0))
      (overlay-put ov 'before-string (make-string offset ? )))))

(advice-add 'org--make-preview-overlay
            :after #'my/org--justify-fragment-overlay)

;; Better equation numbering in LaTeX fragments
(defun my/org-renumber-environment (orig-func &rest args)
  (let ((results '())
        (counter -1)
        (numberp))
    (setq results (cl-loop for (begin .  env) in
                           (org-element-map (org-element-parse-buffer)
                               'latex-environment
                             (lambda (env)
                               (cons
                                (org-element-property :begin env)
                                (org-element-property :value env))))
                           collect
                           (cond
                            ((and (string-match "\\\\begin{equation}" env)
                                  (not (string-match "\\\\tag{" env)))
                             (cl-incf counter)
                             (cons begin counter))
                            ((and (string-match "\\\\begin{align}" env)
                                  (string-match "\\\\notag" env))
                             (cl-incf counter)
                             (cons begin counter))
                            ((string-match "\\\\begin{align}" env)
                             (prog2
                                 (cl-incf counter)
                                 (cons begin counter)
                               (with-temp-buffer
                                 (insert env)
                                 (goto-char (point-min))
                                 (cl-incf counter (count-matches "\\\\$"))
                                 (goto-char (point-min))
                                 (cl-decf counter
                                          (count-matches "\\nonumber")))))
                            (t
                             (cons begin nil)))))
    (when (setq numberp (cdr (assoc (point) results)))
      (setf (car args)
            (concat
             (format "\\setcounter{equation}{%s}\n" numberp)
             (car args)))))
  (apply orig-func args))

(advice-add 'org-create-formula-image :around #'my/org-renumber-environment)


;; Better LaTeX editor for Org mode
;; Setup `CDLaTeX'
(use-package cdlatex
  :demand t
  :diminish (org-cdlatex-mode)
  :config
  (add-hook 'LaTeX-mode-hook #'turn-on-cdlatex)
  (add-hook 'org-mode-hook #'turn-on-org-cdlatex))


(provide 'init-tex)
;;; init-tex.el ends here
