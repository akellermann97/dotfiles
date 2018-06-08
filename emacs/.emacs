;;; package --- Summary
;;; Commentary:
;;; AKellermann's .emacs file
;; Alexander K. Kellermann
;; June 5th, 2019
;;
;;       ___           ___           ___           ___           ___
;;      /\  \         /\__\         /\  \         /\  \         /\  \
;;     /::\  \       /::|  |       /::\  \       /::\  \       /::\  \
;;    /:/\:\  \     /:|:|  |      /:/\:\  \     /:/\:\  \     /:/\ \  \
;;   /::\~\:\  \   /:/|:|__|__   /::\~\:\  \   /:/  \:\  \   _\:\~\ \  \
;;  /:/\:\ \:\__\ /:/ |::::\__\ /:/\:\ \:\__\ /:/__/ \:\__\ /\ \:\ \ \__\
;;  \:\~\:\ \/__/ \/__/~~/:/  / \/__\:\/:/  / \:\  \  \/__/ \:\ \:\ \/__/
;;   \:\ \:\__\         /:/  /       \::/  /   \:\  \        \:\ \:\__\
;;    \:\ \/__/        /:/  /        /:/  /     \:\  \        \:\/:/  /
;;     \:\__\         /:/  /        /:/  /       \:\__\        \::/  /
;;      \/__/         \/__/         \/__/         \/__/         \/__/

;;; Code:

(require 'package)

;; Use regular melpa so I can actually get all the packages I want
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;; Font preference is San Fransico, size 13. Which is mac Exclusive
(add-to-list 'default-frame-alist '(font . "SF Mono-13"))
(set-face-attribute 'default t :font "SF Mono-13")


;; Load the custom package emacs-htmlize
(add-to-list 'load-path "~/.emacs.d/emacs-htmlize")
(add-to-list 'load-path "~/.emacs.d/flycheck-rust")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/nord-emacs")
(add-to-list 'load-path "~/.emacs.d/elpa/eglot/")
(require 'eglot) ; Requires emacs 26!

(package-initialize)

;; This is only to set the correct PATH on MAC OS
(use-package exec-path-from-shell
  :ensure t
  )
;; If the windowing system is Mac OS, then run the extension exec-path
;; to get the correct path.
;; See above customization
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; This adds the whitespace margins around the text area. Used for
;; breathing room.
(set-frame-parameter nil 'internal-border-width 10)

;; When using the particular port of Emacs I'm using, the program
;; attempts to switch the alt and meta which I don't like. I call this
;; function when I want to switch it back to my preffered state.
(defun emacs-mac-port-switcher ()
  (interactive)
 (setq mac-right-option-modifier 'meta)
 (setq mac-option-modifier 'meta)
 )

;; Stops the cursor from blinking.
(blink-cursor-mode 0)

;; Remember to load nord
(setq nord-comment-brightness 10)
(load-theme 'nord t) ;; Nord Theme

;; 'Git Porcelain'
(use-package magit
  :ensure t
  )

;; Company allows for auto-complete in emacs
(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  )

;; Flycheck is a linter, we should have this on every programming mode
(use-package flycheck
  :ensure t
  ;:init
  ;(add-hook 'prog-mode-hook 'flycheck-mode)
  ;(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
  )

;; per-programming buffer basis.
(add-hook 'prog-mode-hook 'auto-fill-mode)

;; Uncomment line before
;(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(setq display-line-numbers-type (quote relative))

;; Makes the title-bar transparent
;; There are issues with this on the
;; https://bitbucket.org/mituharu/emacs-mac/ verions of emacs, but it
;; works on the native Mac OS version
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))

;; I don't know if I like this behavior yet.
(define-key global-map (kbd "RET") 'newline-and-indent)

;; This is which-key, tells you what keys to press
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package swiper
  :ensure t
  )

(use-package counsel
  :ensure t
  )

;; Interactive do mode
(use-package ivy
  :init
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (setq ivy-re-builders-alist
        '((t . ivy--regex-fuzzy)))
  :config
  (ivy-mode 1)
  )

;; mac switch meta key
(defun mac-switch-meta nil
  "Switch meta between Option and Command."
  (interactive)
  (if (eq mac-option-modifier nil)
      (progn
	(setq mac-option-modifier 'meta)
	(setq mac-command-modifier 'hyper)
	)
    (progn
      (setq mac-option-modifier nil)
      (setq mac-command-modifier 'meta)
      )
    )
  )

(global-set-key (kbd "C-x C-f") 'counsel-find-file)

(setq-default indent-tabs-mode nil)
(setq load-prefer-newer t)

;; Remove the tool bar up top, and the scroll bar on the side. And I
;; don't want any text on my titlebar
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq frame-title-format "")
;; Highlight the line the cursor is currently at.
(global-hl-line-mode 1)

;; This package is asynchronous, but is of pretty poor quality. The
;; other racer code unfortunately works much better, but will lock up
;; the emacs session when populating the compleition list.
(use-package company-racer
  :ensure t
  :config
  (with-eval-after-load 'company
    (add-to-list 'company-backends 'company-racer))
  )

;;; VIM Keybindings
(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  ;; Make under_score words one word for evil commands
  (add-hook 'prog-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
  )

;;; This is a evil clone of the surround package found in Vim.
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1)
  )
;; We're abusing the evil-mode extension in order to get
;; cool vim-like <leader> key ability
(defun add-to-map (keys func)
  (define-key evil-normal-state-map (kbd keys) func))

(add-to-map "<SPC>" nil)
(add-to-map "<SPC> s" 'switch-to-buffer)
(add-to-map "<SPC> q" 'kill-buffer)
(add-to-map "<SPC> f" 'counsel-find-file)
(add-to-map "<SPC> m" 'magit-status)
(add-to-map "<SPC> j" 'windmove-down)
(add-to-map "<SPC> k" 'windmove-up)
(add-to-map "<SPC> b" 'ibuffer)
(add-to-map "<SPC> h" 'windmove-left)
(add-to-map "<SPC> l" 'windmove-right)
(add-to-map "<SPC> 0" 'delete-window)
(add-to-map "<SPC> 1" 'delete-other-windows)
(add-to-map "<SPC> 2" 'split-window-below)
(add-to-map "<SPC> 3" 'split-window-right)
(add-to-map "<SPC> ac" 'apropos-command)
(add-to-map "<SPC> ad" 'apropos-documentation)
(add-to-map "<SPC> d" 'display-line-numbers-mode)
(add-to-map "<SPC> x" 'execute-extended-command)

(define-key key-translation-map (kbd "ESC") (kbd "C-g"))


;; Use SSH for maximum security
(setq tramp-default-method "ssh")

;; Windmove - Lets you use Shift-Arrow for navigating splits
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(provide '.emacs)
;;; .emacs ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("fe666e5ac37c2dfcf80074e88b9252c71a22b6f5d2f566df9a7aa4f9bea55ef8" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "66a45115e60ae1a1afcb313609dea1e78dbe13faf203f25c4461ee3a73c73724" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
