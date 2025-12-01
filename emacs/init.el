;;; package --- Summary
;;; Commentary:
;;; AKellermann's .emacs file
;; Alexander K. Kellermann
;; Updated: December 1st, 2025
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

;;; ============================================================================
;;; Package Management Setup
;;; ============================================================================

(require 'package)

;; Add package archives
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("nongnu" . "https://elpa.nongnu.org/nongnu/"))

(package-initialize)

;; Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;;; ============================================================================
;;; Performance Optimization
;;; ============================================================================

;; Increase garbage collection threshold during startup
(setq gc-cons-threshold (* 50 1000 1000))

;; Reset it after startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 2 1000 1000))))

;;; ============================================================================
;;; UI Configuration
;;; ============================================================================

;; Font preference - San Francisco Mono, size 13 (Mac exclusive)
(add-to-list 'default-frame-alist '(font . "SF Mono-13"))
(set-face-attribute 'default t :font "SF Mono-13")

;; Load custom theme
(use-package nord-theme
             :config
             (load-theme 'nord t))
;;(setq nord-comment-brightness 10)
;;(load-theme 'nord t)

;; Remove UI clutter
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq frame-title-format "")

;;; ============================================================================
;;; Mac OS Specific
;;; ============================================================================

;; Set correct PATH on Mac OS
(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

;; Mac modifier key management for emacs-plus
(setq ns-command-modifier 'meta)       ; Command key = super
(setq ns-option-modifier 'super)         ; Option key = meta
(setq ns-control-modifier 'control)     ; Control key = control
(setq ns-right-option-modifier 'none)   ; Right Option for special characters

;; Transparent titlebar (works on native Mac OS)
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))

;; Whitespace margins for breathing room
(set-frame-parameter nil 'internal-border-width 10)

;; Cursor and line highlighting
(blink-cursor-mode 0)
(global-hl-line-mode 1)

;; Line numbers (relative)
(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Show matching parentheses
(show-paren-mode 1)

;;; ============================================================================
;;; Better Defaults
;;; ============================================================================

(setq-default
 indent-tabs-mode nil           ; Use spaces, not tabs
 truncate-lines nil             ; Wrap long lines
 create-lockfiles nil           ; Don't create lockfiles
 make-backup-files nil)         ; Don't create backup~ files

(setq load-prefer-newer t)      ; Load newer .el files

;; Auto-indent on RET
(define-key global-map (kbd "RET") 'newline-and-indent)

;; Recent files
(recentf-mode 1)
(setq recentf-max-saved-items 100)

;;; ============================================================================
;;; Completion & Search
;;; ============================================================================

;; Company mode for auto-completion
(use-package company
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 2))

;; Ivy, Counsel, and Swiper for completion and search
(use-package ivy
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
        enable-recursive-minibuffers t))

(use-package counsel
  :bind (("C-x C-f" . counsel-find-file)))

(use-package swiper)

;; Which-key: shows available key bindings
(use-package which-key
  :config
  (which-key-mode))

;;; ============================================================================
;;; LSP & Language Support
;;; ============================================================================

;; Eglot for LSP support
(use-package eglot
  :hook ((python-mode . eglot-ensure)
         (rust-mode . eglot-ensure)
         (javascript-mode . eglot-ensure)
         (typescript-mode . eglot-ensure)
         (c-mode . eglot-ensure)
         (c++-mode . eglot-ensure))
  :config
  (setq eglot-autoshutdown t))

;; Flycheck for linting
(use-package flycheck
  :hook (prog-mode . flycheck-mode))

;; Rust support
(use-package rust-mode
  :mode "\\.rs\\'"
  :config
  (setq rust-format-on-save t))

;;; ============================================================================
;;; Ocaml Setup
;;; ============================================================================
(use-package ocaml-eglot
  :ensure t
  :after tuareg
  :hook
  (tuareg-mode . ocaml-eglot)
  (ocaml-eglot . eglot-ensure))

(setq lsp-enable-indentation nil)

(use-package utop
  :config
  (setq utop-command "opam exec -- utop -emacs"))

;;; ============================================================================
;;; Project Management
;;; ============================================================================

(use-package projectile
  :config
  (projectile-mode +1)
  :bind-keymap
  ("C-c p" . projectile-command-map))

;;; ============================================================================
;;; Git Integration
;;; The `with-editor` line exists to get emacs to stop
;;; warning on startup.
;;; ============================================================================

(use-package magit)
(setq-default with-editor-emacsclient-executable "emacsclient")

;;; ============================================================================
;;; Claude Code and EAT
;;; ============================================================================

;; install required inheritenv dependency:
(use-package inheritenv
  :vc (:url "https://github.com/purcell/inheritenv" :rev :newest))

;; for eat terminal backend:
(use-package eat :ensure t)

;; install claude-code.el
(use-package claude-code :ensure t
  :vc (:url "https://github.com/stevemolitor/claude-code.el" :rev :newest)
  :config

  (claude-code-mode)
  :bind-keymap ("C-c c" . claude-code-command-map))


;;; ============================================================================
;;; Evil Mode (Vim Emulation)
;;; ============================================================================

(use-package evil
  :config
  (evil-mode 1)
  ;; Make underscores part of words for evil commands
  (add-hook 'prog-mode-hook #'(lambda () (modify-syntax-entry ?_ "w"))))

(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

;;; ============================================================================
;;; Custom Keybindings (Spacemacs-style Leader Key)
;;; ============================================================================

(defun add-to-map (keys func)
  "Add KEYS to FUNC in evil normal state map."
  (define-key evil-normal-state-map (kbd keys) func))

;; Leader key mappings (SPC)
(add-to-map "<SPC>" nil)
(add-to-map "<SPC> s" 'switch-to-buffer)
(add-to-map "<SPC> q" 'kill-buffer)
(add-to-map "<SPC> f" 'counsel-find-file)
(add-to-map "<SPC> r" 'recentf-open-files)
(add-to-map "<SPC> m" 'magit-status)
(add-to-map "<SPC> p" 'projectile-command-map)

;; Window navigation
(add-to-map "<SPC> j" 'windmove-down)
(add-to-map "<SPC> k" 'windmove-up)
(add-to-map "<SPC> h" 'windmove-left)
(add-to-map "<SPC> l" 'windmove-right)

;; Window management
(add-to-map "<SPC> 0" 'delete-window)
(add-to-map "<SPC> 1" 'delete-other-windows)
(add-to-map "<SPC> 2" 'split-window-below)
(add-to-map "<SPC> 3" 'split-window-right)

;; Utilities
(add-to-map "<SPC> b" 'ibuffer)
(add-to-map "<SPC> d" 'display-line-numbers-mode)
(add-to-map "<SPC> x" 'execute-extended-command)
(add-to-map "<SPC> ac" 'apropos-command)
(add-to-map "<SPC> ad" 'apropos-documentation)

;; ESC quits
(define-key key-translation-map (kbd "ESC") (kbd "C-g"))

;; Windmove with Shift-Arrow keys
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;;; ============================================================================
;;; Remote File Editing
;;; ============================================================================

;; Use SSH for TRAMP
(setq tramp-default-method "ssh")

;;; ============================================================================
;;; Custom Variables
;;; ============================================================================

(provide '.emacs)
;;; .emacs ends here
