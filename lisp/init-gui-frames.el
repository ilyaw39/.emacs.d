;; init-gui-frames.el --- Behaviours of GUI frames -*- lexical-binding: t -*-
;;
;; Copyright (C) 2022-2023 Ilya Wang
;;
;; This file is not part of GNU Emacs.
;;
;; Commentary:
;;
;; This file is inspired by https://github.com/purcell/emacs.d/.
;;
;; Code:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Optimization
(setq idle-update-delay 1.0)

(setq-default cursor-in-non-selected-windows nil)
(setq highlight-nonselected-windows nil)

(setq frame-resize-pixelwise t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Themes
(use-package modus-themes :straight t
  :init  
  (setq modus-themes-common-palette-overrides
        '((border-mode-line-active unspecified)
          (border-mode-line-inactive unspecified)))
  :config (load-theme 'modus-vivendi t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Clean up the title bar content
(setq-default frame-title-format nil)
(setq-default ns-use-proxy-icon nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Customize faces
(set-face-attribute 'button nil
                    :underline "#959595"
                    :foreground 'unspecified)

(set-face-attribute 'link nil :foreground 'unspecified)

(set-face-attribute 'fill-column-indicator nil :height 0.15)

(set-face-background 'fringe (face-attribute 'default :background))

;; Cursor faces
(setq-default blink-cursor-mode nil)
(setq-default cursor-type '(bar . 1))
(set-cursor-color "#ff66ff")

;; highlight current line
(global-hl-line-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Custom font
;;
;; Main typeface
(set-face-attribute 'default nil :family "PragmataPro" :height 140)

;; Font settings
(set-fontset-font "fontset-default" 'unicode "PragmataPro")
(set-fontset-font "fontset-default" 'han "Noto Serif CJK SC")

(set-face-attribute 'italic nil :slant 'normal)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Use icons
(global-prettify-symbols-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Default startup message
(defun display-startup-echo-area-message ()
  (message " Funding for this program was made possible by viewers like you."))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Stop showing fringe bitmaps
(setf (cdr (assq 'continuation fringe-indicator-alist)) '(nil nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; PragmataPro™ specified configuration
(setq prettify-symbols-unprettify-at-point 'right-edge)

(defconst pragmatapro-prettify-symbols-alist
  (mapcar (lambda (s)
            `(,(car s)
              .
              ,(vconcat
                (apply 'vconcat
                       (make-list
                        (- (length (car s)) 1)
                        (vector (decode-char 'ucs #X0020) '(Br . Bl))))
                (vector (decode-char 'ucs (cadr s))))))
          '(("[INFO ]"    #XE280)
            ("[WARN ]"    #XE281)
            ("[PASS ]"    #XE282)
            ("[VERBOSE]"  #XE283)
            ("[KO]"       #XE284)
            ("[OK]"       #XE285)
            ("[PASS]"     #XE286)
            ("[ERROR]"    #XE2C0)
            ("[DEBUG]"    #XE2C1)
            ("[INFO]"     #XE2C2)
            ("[WARN]"     #XE2C3)
            ("[WARNING]"  #XE2C4)
            ("[ERR]"      #XE2C5)
            ("[FATAL]"    #XE2C6)
            ("[TRACE]"    #XE2C7)
            ("[FIXME]"    #XE2C8)
            ("[TODO]"     #XE2C9)
            ("[BUG]"      #XE2CA)
            ("[NOTE]"     #XE2CB)
            ("[HACK]"     #XE2CC)
            ("[MARK]"     #XE2CD)
            ("[FAIL]"     #XE2CE)
            ("# ERROR"    #XE2F0)
            ("# DEBUG"    #XE2F1)
            ("# INFO"     #XE2F2)
            ("# WARN"     #XE2F3)
            ("# WARNING"  #XE2F4)
            ("# ERR"      #XE2F5)
            ("# FATAL"    #XE2F6)
            ("# TRACE"    #XE2F7)
            ("# FIXME"    #XE2F8)
            ("# TODO"     #XE2F9)
            ("# BUG"      #XE2FA)
            ("# NOTE"     #XE2FB)
            ("# HACK"     #XE2FC)
            ("# MARK"     #XE2FD)
            ("# FAIL"     #XE2FE)
            ("// ERROR"   #XE2E0)
            ("// DEBUG"   #XE2E1)
            ("// INFO"    #XE2E2)
            ("// WARN"    #XE2E3)
            ("// WARNING" #XE2E4)
            ("// ERR"     #XE2E5)
            ("// FATAL"   #XE2E6)
            ("// TRACE"   #XE2E7)
            ("// FIXME"   #XE2E8)
            ("// TODO"    #XE2E9)
            ("// BUG"     #XE2EA)
            ("// NOTE"    #XE2EB)
            ("// HACK"    #XE2EC)
            ("// MARK"    #XE2ED)
            ("// FAIL"    #XE2EE)
            ("!="         #XE900)
            ("!=="        #XE901)
            ("!=="        #XE902)
            ("!≡"         #XE903)
            ("!≡≡"        #XE904)
            ("#("         #XE90C)
            ("#_"         #XE90D)
            ("#{"         #XE90E)
            ("#?"         #XE90F)
            ("##"         #XE910)
            ("#_("        #XE911)
            ("#["         #XE912)
            ("%="         #XE920)
            ("&%"         #XE92C)
            ("&&"         #XE92D)
            ("&+"         #XE92E)
            ("&-"         #XE92F)
            ("&/"         #XE930)
            ("&="         #XE931)
            ("&&&"        #XE932)
            ("$>"         #XE93A)
            ("(|"         #XE940)
            ("*>"         #XE946)
            ("++"         #XE94C)
            ("+++"        #XE94D)
            ("+="         #XE94E)
            ("+>"         #XE94F)
            ("++="        #XE950)
            ("--"         #XE960)
            ("-<"         #XE961)
            ("-<<"        #XE962)
            ("-="         #XE963)
            ("->"         #XE964)
            ("->>"        #XE965)
            ("---"        #XE966)
            ("-->"        #XE967)
            ("-+-"        #XE968)
            ("-\\/"       #XE969)
            ("-|>"        #XE96A)
            ("-<|"        #XE96B)
            ("->-"        #XE96C)
            ("-<-"        #XE96D)
            ("-|"         #XE96E)
            ("-||"        #XE96F)
            ("-|:"        #XE970)
            (".="         #XE979)
            ("//="        #XE994)
            ("/="         #XE995)
            ("/=="        #XE996)
            ("/-\\"       #XE997)
            ("/-:"        #XE998)
            ("/->"        #XE999)
            ("/=>"        #XE99A)
            ("/-<"        #XE99B)
            ("/=<"        #XE99C)
            ("/=:"        #XE99D)
            (":="         #XE9AC)
            (":≡"         #XE9AD)
            (":=>"        #XE9AE)
            (":-\\"       #XE9AF)
            (":=\\"       #XE980)
            (":-/"        #XE981)
            (":=/"        #XE982)
            (":-|"        #XE983)
            (":=|"        #XE984)
            (":|-"        #XE985)
            (":|="        #XE986)
            ("<$>"        #XE9C0)
            ("<*"         #XE9C1)
            ("<*>"        #XE9C2)
            ("<+>"        #XE9C3)
            ("<-"         #XE9C4)
            ("<<="        #XE9C5)
            ("<=>"        #XE9C7)
            ("<>"         #XE9C8)
            ("<|>"        #XE9C9)
            ("<<-"        #XE9CA)
            ("<|"         #XE9CB)
            ("<=<"        #XE9CC)
            ("<~"         #XE9CD)
            ("<~~"        #XE9CE)
            ("<<~"        #XE9CF)
            ("<$"         #XE9D0)
            ("<+"         #XE9D1)
            ("<!>"        #XE9D2)
            ("<@>"        #XE9D3)
            ("<#>"        #XE9D4)
            ("<%>"        #XE9D5)
            ("<^>"        #XE9D6)
            ("<&>"        #XE9D7)
            ("<?>"        #XE9D8)
            ("<.>"        #XE9D9)
            ("</>"        #XE9DA)
            ("<\\>"       #XE9DB)
            ("<\">"       #XE9DC)
            ("<:>"        #XE9DD)
            ("<~>"        #XE9DE)
            ("<**>"       #XE9DF)
            ("<<^"        #XE9E0)
            ("<="         #XE9E1)
            ("<->"        #XE9E2)
            ("<!--"       #XE9E3)
            ("<--"        #XE9E4)
            ("<~<"        #XE9E5)
            ("<==>"       #XE9E6)
            ("<|-"        #XE9E7)
            ("<||"        #XE9E8)
            ("<<|"        #XE9E9)
            ("<-<"        #XE9EA)
            ("<-->"       #XE9EB)
            ("<<=="       #XE9EC)
            ("<=="        #XE9ED)
            ("<-\\"       #XE9EE)
            ("<-/"        #XE9EF)
            ("<=\\"       #XE9F0)
            ("<=/"        #XE9F1)
            ("=<<"        #XEA00)
            ("=="         #XEA01)
            ("==="        #XEA02)
            ("==>"        #XEA03)
            ("=>"         #XEA04)
            ("=~"         #XEA05)
            ("=>>"        #XEA06)
            ("=~="        #XEA07)
            ("==>>"       #XEA08)
            ("=>="        #XEA09)
            ("=<="        #XEA0A)
            ("=<"         #XEA0B)
            ("==<"        #XEA0C)
            ("=<|"        #XEA0D)
            ("=/="        #XEA0F)
            ("=/<"        #XEA10)
            ("=|"         #XEA11)
            ("=||"        #XEA12)
            ("=|:"        #XEA13)
            (">-"         #XEA20)
            (">>-"        #XEA22)
            (">>="        #XEA23)
            (">=>"        #XEA24)
            (">>^"        #XEA25)
            (">>|"        #XEA26)
            (">!="        #XEA27)
            (">->"        #XEA28)
            (">=="        #XEA29)            
            (">="         #XEA2A)
            (">/="        #XEA2B)
            (">-|"        #XEA2C)
            (">=|"        #XEA2D)
            (">-\\"       #XEA2E)
            (">=\\"       #XEA2F)
            (">-/"        #XEA30)
            (">=/"        #XEA31)
            (">λ="        #XEA32)
            ("?."         #XEA3F)
            ("^="         #XEA43)
            ("^<<"        #XEA48)
            ("^>>"        #XEA49)
            ("\\="        #XEA54)
            ("\\=="       #XEA55)
            ("\\/="       #XEA56)
            ("\\-/"       #XEA57)
            ("\\-:"       #XEA58)
            ("\\->"       #XEA59)
            ("\\=>"       #XEA5A)
            ("\\-<"       #XEA5B)
            ("\\=<"       #XEA5C)
            ("\\=:"       #XEA5D)
            ("|="         #XEA69)
            ("|>="        #XEA6A)
            ("|>"         #XEA6B)
            ("|+|"        #XEA6C)
            ("|->"        #XEA6D)
            ("|-->"       #XEA6E)
            ("|=>"        #XEA6F)
            ("|==>"       #XEA70)
            ("|>-"        #XEA71)
            ("|<<"        #XEA72)
            ("||>"        #XEA73)
            ("|>>"        #XEA74)
            ("|-"         #XEA75)
            ("||-"        #XEA76)
            ("||="        #XEA77)
            ("|)"         #XEA78)
            ("|]"         #XEA79)
            ("|-:"        #XEA7A)
            ("|=:"        #XEA7B)
            ("|-<"        #XEA7C)
            ("|=<"        #XEA7D)
            ("|--<"       #XEA7E)
            ("|==<"       #XEA7F)
            ("~="         #XEA8A)
            ("~>"         #XEA8B)
            ("~~>"        #XEA8C)
            ("~>>"        #XEA8D)
            ("[["         #XEA8F)
            ("[|"         #XEA90)
            ("_|_"        #XEA97)
            ("]]"         #XEAA0)
            ("≡≡"         #XEAB3)
            ("≡≡≡"        #XEAB4)
            ("≡:≡"        #XEAB5)
            ("≡/"         #XEAB6)
            ("≡/≡"        #XEAB7))))

(defun add-pragmatapro-prettify-symbols-alist ()
  (setq prettify-symbols-alist pragmatapro-prettify-symbols-alist))

;; Enable prettified symbols on comments
(defun setup-compose-predicate ()
  (setq prettify-symbols-compose-predicate
        (defun my-prettify-symbols-default-compose-p (start end _match)
          "Same as `prettify-symbols-default-compose-p', except compose symbols
in comments as well."
          (let* ((syntaxes-beg (if (memq (char-syntax (char-after start)) '(?w ?_))
                                   '(?w ?_) '(?. ?\\)))
                 (syntaxes-end (if (memq (char-syntax (char-before end)) '(?w ?_))
                                   '(?w ?_) '(?. ?\\))))
            (not (or (memq (char-syntax (or (char-before start) ?\s)) syntaxes-beg)
                     (memq (char-syntax (or (char-after end) ?\s)) syntaxes-end)
                     (nth 3 (syntax-ppss))))))))

;; Main hook function
(defun prettify-hook ()
  (add-pragmatapro-prettify-symbols-alist)
  (setup-compose-predicate))

(add-hook 'prog-mode-hook #'prettify-hook)
(add-hook 'text-mode-hook #'prettify-hook)

(provide 'init-gui-frames)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; init-gui-frames.el ends here
