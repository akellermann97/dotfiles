;;; package --- Summary
;;; Commentary:
;;; AKellermann's .emacs file
;; Alexander K. Kellermann
;; 5 September 2017
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

;; I use Melpa Stable to keep things a bit more under control
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'default-frame-alist '(font . "SF Mono-13"))
(set-face-attribute 'default t :font "SF Mono-13")

;; Load the custom package emacs-htmlize
(add-to-list 'load-path "~/.emacs.d/emacs-htmlize")
(add-to-list 'load-path "~/.emacs.d/flycheck-rust")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/nord-emacs")

(package-initialize)

;; This is only to set the correct path on MAC OS
(use-package exec-path-from-shell
  :ensure t
  )
;; (setq mac-right-option-modifier 'meta)
;; (setq mac-option-modifier 'meta)
;; This is for using the mac port of windows. But only the bitbucket version

;; If the windowing system is Mac OS, then run the extension exec-path
;; to get the correct path.
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

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
  :init
  (add-hook 'prog-mode-hook 'flycheck-mode)
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
  )

;; Auto-fill mode is already installed, we just need to enable it on a
;; per-programming buffer basis.
(add-hook 'prog-mode-hook 'auto-fill-mode)

;; I want line numbers, but only on programming related buffers.
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(setq display-line-numbers-type (quote relative))

;; Makes the title-bar transparent
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))

;; I don't know if I like this behavior yet.
(define-key global-map (kbd "RET") 'newline-and-indent)

;; This is which-key, tells you what keys to press
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;;(use-package nord-theme
;;  :ensure t
;;  :init
;;  (setq nord-comment-brightness 12)
;;  )

;; Remember to load nord
(setq nord-comment-brightness 10)

;;(load-theme 'nord)

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

;;(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)

(setq-default indent-tabs-mode nil)
(setq load-prefer-newer t)

;; Remove the tool bar up top, and the scroll bar on the side. And I
;; don't want any text on my titlebar
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq frame-title-format "")

;;;; Rust plug-ins
;;(use-package racer
;;  :ensure t
;;  :config
;;  (add-hook 'rust-mode-hook #'racer-mode)
;;  (add-hook 'racer-mode-hook #'eldoc-mode)
;;  ;;(add-hook 'racer-mode-hook #'company-mode)
;;)
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

;; Highlight the line the cursor is currently at.
(global-hl-line-mode 1)

;; Use SSH for maximum security
(setq tramp-default-method "ssh")

;; Windmove - Lets you use Shift-Arrow for navigating splits
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "red3" "ForestGreen" "yellow3" "blue" "magenta3" "DeepSkyBlue" "gray50"])
 '(battery-mode-line-format nil)
 '(custom-safe-themes
   (quote
    ("42b9d85321f5a152a6aef0cc8173e701f572175d6711361955ecfb4943fe93af" "b2b86aedf22eb69156420e54b28aa39375277d38ee953bbce8342e71a2e68c41" "e11569fd7e31321a33358ee4b232c2d3cf05caccd90f896e1df6cab228191109" "73bff6f2ef60f8a1238a9ca666235d258e3acdeeed85d092ca532788dd7a33c4" "05eeb814f74b2fd4f2e6e37b4d604eb9b1daaaedfa5e692f1d485250c6b553eb" "c63a789fa2c6597da31f73d62b8e7fad52c9420784e6ec34701ae8e8f00071f6" "ff7625ad8aa2615eae96d6b4469fcc7d3d20b2e1ebc63b761a349bebbb9d23cb" "66a45115e60ae1a1afcb313609dea1e78dbe13faf203f25c4461ee3a73c73724" "9c6821068c0667b97bad53e36e1564d3332495c9495d38938bf4ebb6758e2697" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "90ea0413ad77ae560f150de2e3888da4a2088590209705306156a307899a37ec" "11878ac0a75f25057b217f74d9098adbd893dc1374da94d81f715b70f4efa00b" "ce0788113995714fd96970417e8e71d5182d02bc40cc7ffef307f5e01e55942f" "4ee4a855548a7a966fe8722401441499b0d8b2fcf3d12438f81e016b6efed0e6" "ed2b5df51c3e1f99207074f8a80beeb61757ab18970e43d57dec34fe21af2433" "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "40da996f3246a3e99a2dff2c6b78e65307382f23db161b8316a5440b037eb72c" default)))
 '(display-battery-mode t)
 '(display-line-numbers nil)
 '(display-line-numbers-type (quote relative))
 '(display-line-numbers-width nil)
 '(flycheck-rust-crate-type "bin")
 '(fringe-mode nil nil (fringe))
 '(global-display-line-numbers-mode nil)
 '(global-hl-line-mode t)
 '(initial-buffer-choice nil)
 '(package-selected-packages
   (quote
    (company-racer dracula-theme rust-mode olivetti chess cargo use-package counsel org-ref evil-leader ivy sublimity solarized-theme smex racer projectile powerline markdown-mode magit linum-relative ido-vertical-mode gruvbox-theme flycheck exec-path-from-shell evil dashboard company-anaconda auto-complete auctex)))
 '(pixel-scroll-mode nil)
 '(python-shell-exec-path (quote ("")))
 '(python-shell-interpreter "python3.6")
 '(racer-rust-src-path "/Users/Alexander/gitStuff/rustSource/rust/src")
 '(tramp-syntax (quote default) nil (tramp)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(provide '.emacs)
;;; .emacs ends here
