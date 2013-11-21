;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Example .emacs file for VLSI I exercises
;; Author: Stephan Oetiker
;; Created 23.03.2004
;; Last modified: 23.4.2004
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Reload file in place: M-x eval-buffer

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;      DEFAULT VARIABLE SETTINGS
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq-default auto-save-default nil)
(setq-default truncate-lines nil)
(setq inhibit-startup-message t)
(setq-default display-time-day-and-date t)
(setq-default display-time-24hr-format t)
(setq-default line-number-mode t)
(setq-default line-number-display-limit 30000000)
(setq-default transient-mark-mode t)
(setq-default save-place t)
(setq-default comint-scroll-to-bottom-on-input t)
(setq-default mouse-scroll-delay 0)

(defalias 'yes-or-no-p 'y-or-n-p)

;(setq-default tab-width 2)
;(setq-default auto-save-interval 3000)
(setq-default truncate-lines t)
;(setq-default truncate-lines false)

;(display-time)
(column-number-mode)
(menu-bar-mode 0)
(tool-bar-mode 0)
(show-paren-mode 1)
(set-background-color "black")
(set-foreground-color "gray90")
(set-cursor-color "red")

(server-start)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;      Track and Highlight Changes in Filebuffers
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; changes mode always on, but hide initially (would not track changes otherwise)
(global-highlight-changes-mode t)
(setq highlight-changes-visibility-initial-state nil)

;; toggle visibility
(global-set-key (kbd "<f12>")      'highlight-changes-visible-mode)

;; remove the change-highlight in region
(global-set-key (kbd "S-<f12>")    'highlight-changes-remove-highlight)

;; jump to the previous/next change (Alt-PgUp/PgDown)
(global-set-key (kbd "<M-next>") 'highlight-changes-next-change)
(global-set-key (kbd "<M-prior>")  'highlight-changes-previous-change)

;; remove tracked changes after save
(add-hook 'after-save-hook
  '(lambda()
    (if (boundp 'highlight-changes-mode)
      (highlight-changes-remove-highlight (point-min) (point-max)))))

(set-default-font "-*-courier-medium-r-*-*-12-*-*-*-*-*-*-15")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;      Hippie Expand on Help key
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq hippie-expand-try-functions-list '( try-expand-dabbrev
                                          try-expand-dabbrev-all-buffers
                                          try-complete-file-name
                                          try-expand-all-abbrevs
                                          try-expand-line
                                          try-complete-lisp-symbol))

(global-set-key '[help] 'hippie-expand)
(global-set-key "\M- " 'hippie-expand)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;      Electrical buffer list on Meta-b
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key "\M-b" 'electric-buffer-list)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;      Toggle Buffer on Meta-t (uses Meta-b electrical buffer list)
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(fset 'toggle-buffer
   [?\M-b down return])

(global-set-key "\M-t" 'toggle-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;      DEFAULT KEYBOARD DEFINITIONS
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key "\M-g"         'goto-line)
(global-set-key "\M-z"         'shell)
(global-set-key "\M-k"         'kill-buffer)
(global-set-key "\M-u"         'undo)
(global-set-key '[home]        'beginning-of-line)
(global-set-key '[end]         'end-of-line)
(global-set-key '[C-up]        'scroll-down-in-place)
(global-set-key '[C-down]      'scroll-up-in-place)
(global-set-key '[C-home]      'beginning-of-buffer)
(global-set-key '[C-end]       'end-of-buffer)
(global-set-key '[C-right]     'my-scroll-left);
(global-set-key '[C-left]      'my-scroll-right);
(global-set-key '[S-right]     'forward-word);
(global-set-key '[S-left]      'backward-word);
(global-set-key '[f1]          'defining-kbd-macro)
(global-set-key '[f2]          'end-kbd-macro)
(global-set-key '[f3]          'call-last-kbd-macro)
(global-set-key '[f5]          'clipboard-kill-region)
(global-set-key '[f6]          'clipboard-kill-ring-save)
(global-set-key '[f7]          'clipboard-yank)
(global-set-key '[f9]          'other-window)
(global-set-key '[C-backspace] 'kill-whole-word)
(global-set-key '[C-tab]       'swap-windows)
(global-set-key '[backtab]     'switch-other)

;; Easily switch buffer windows
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)

(defvar act-search-string nil)

(defun my-scroll-left ()
  ""
  (interactive)
  (scroll-left 2))

(defun my-scroll-right ()
  ""
  (interactive)
  (scroll-right 2))

(defun scroll-down-in-place (n)
  (interactive "p")
;  (previous-line n)
  (scroll-down n))

(defun scroll-up-in-place (n)
  (interactive "p")
;  (next-line n)
  (scroll-up n))

(defun kill-whole-word (n)
  (interactive "p")
  (forward-word n)
  (backward-kill-word n))

(defun kill-whole-word (n)
  (interactive "p")
  (search-forward-regexp "\\>") ; go to end of word (if not already there)
  (backward-kill-word n))

(defun swap-windows ()
  (interactive)
  (let* (
	 (this (selected-window))
	 (other (next-window))
	 (this-buffer (window-buffer this))
	 (other-buffer (window-buffer other)))
    (set-window-buffer other this-buffer)
    (set-window-buffer this other-buffer)
    )
  )

(defun switch-other (n)
  (interactive "p")
  (other-window 1)
  (next-buffer)
  (other-window 1))

;(defvar *color-mode* 'light)
;(defun switch-colors ()
;  (interactive)
;  ;(if (equal *color-mode* 'light)
;  ;  (
;     (set-background-color "black")
;     (set-foreground-color "gray90")
;     (setq *color-mode* 'dark)
;     '(linum ((t (:inherit (shadow default) :background "gray80" :foreground "grey60"))))
;  ;   )
;  ;  (
;     (set-background-color "beige")
;     (set-foreground-color "black")
;     (setq *color-mode* 'light)
;     '(linum ((t (:inherit (shadow default) :background "gainsboro" :foreground "grey60"))))
;  ;  )
;  ;  )
;  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;      VHDL Mode stuff when not correctly defined
;;;      in the start-site-local.el
;;;
;;;      problems:
;;;      emacs 21.2 uses beta mode VHDL mode
;;;      vhdl-compiler-alist has changed for newer VHDL modes
;;;      emacs 21.3 has (had) wrong site-start-local file
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; for the emacs 21.3
;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 ;;'(backup-directory-alist (quote ((".*" . "~\\emacs_backups"))))
 '(c-basic-offset 2)
 '(c-default-style (quote ((c-mode . "ellemtel") (java-mode . "java") (awk-mode . "awk") (other . "ellemtel"))))
 '(global-font-lock-mode t nil (font-lock))
 '(load-home-init-file t t)
 '(make-backup-files nil)
 '(vc-cvs-stay-local nil)
 '(vc-make-backup-files nil)
 '(version-control (quote never))
 '(vhdl-clock-name "Clk")
 '(vhdl-clock-rising-edge t)
 '(vhdl-company-name "Supercomputing Systems AG")
 '(vhdl-file-header "-----------------------------------------------------------------------------
--  Copyright (c) <year> <company>
--  All rights reserved.
-----------------------------------------------------------------------------
")
 '(vhdl-highlight-case-sensitive t)
 '(vhdl-highlight-special-words t)
 '(vhdl-instance-name (quote (".*" . "i_\\&")))
 '(vhdl-optional-labels (quote none))
 '(vhdl-reset-active-high t)
 '(vhdl-reset-kind (quote none))
 '(vhdl-reset-name "Rst")
 '(vhdl-special-syntax-alist (quote (("signal-clr" "Clr[A-Za-z0-9_]*" "Tomato" "red5") ("signal-clock" "Clk[A-Za-z0-9_]*" "LimeGreen" "lightseagreen") ("signal-reset" "Rst[A-Za-z0-9_]*" "Tomato" "red3") ("type-definition" "\\<\\w+_[tT]\\>" "aquamarine3" "mediumaquamarine") ("record-definition" "\\<\\w+_[rR]\\>" "magenta2" "magenta2") ("constant" "\\<\\w+_[cC]\\>" "DodgerBlue3" "dodgerblue3") ("generic" "\\<\\w+_[gG]\\>" "DarkOrange" "darkorange") ("instance" "\\<[iI]_\\w+\\>" "Grey50" "gray30"))))
 '(vhdl-underscore-is-part-of-word t)
 '(vhdl-use-direct-instantiation (quote always)))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(diff-added ((t (:foreground "Green"))) 'now)
 '(diff-removed ((t (:foreground "Red"))) 'now)
 '(highlight-changes ((((min-colors 88) (class color)) (:background "yellow" :foreground "red1"))))
 '(highlight-changes-delete ((((min-colors 88) (class color)) (:background "yellow" :foreground "red1" :underline t))))
 '(linum ((t (:inherit (shadow default) :background "gainsboro" :foreground "grey60")))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Highlight SCS naming conventions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Include line nr package and show by default
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'linum)
(global-linum-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; TeX mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
(eval-after-load "tex-mode" '(fset 'tex-font-lock-suscript 'ignore))

