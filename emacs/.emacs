;;; package --- Summary
;;; Commentary:
;;;; AKellermann's .emacs file
; Alexander K. Kellermann
; 5 September 2017


(require 'package)

;; I use Melpa Stable to keep things a bit more under control
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'default-frame-alist '(font . "SF Mono-13"))
(set-face-attribute 'default t :font "SF Mono-13")
(add-to-list 'custom-theme-load-path (expand-file-name "~/.emacs.d/themes/"))

;; I want to use company mode all over emacs by default
(add-hook 'after-init-hook 'global-company-mode)
(package-initialize)

;; Makes the title-bar transparent
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . t))

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
(define-key global-map (kbd "RET") 'newline-and-indent)

;; This is which-key, tells you what keys to press
(which-key-mode)

;; Interactive do mode
(ido-mode 1)
(ido-vertical-mode 1)

;; Remove the tool bar up top, and the scroll bar on the side
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Whatever theme I'm using atm
(load-theme 'nord t)

;; Rust plug-ins
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

(require 'rust-mode)
(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)
;; End of Rust plug-ins

;;Python plug-ins, add this particular back-end to company
(eval-after-load "company"
  '(add-to-list 'company-backends 'company-anaconda))
(add-hook 'python-mode-hook 'anaconda-mode)

;;; VIM Keybindings
(require 'evil)
(evil-mode 1)

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
 '(custom-safe-themes
   (quote
    ("40da996f3246a3e99a2dff2c6b78e65307382f23db161b8316a5440b037eb72c" default)))
 '(display-line-numbers (quote relative))
 '(display-line-numbers-type (quote relative))
 '(display-line-numbers-width nil)
 '(global-display-line-numbers-mode nil)
 '(package-selected-packages
   (quote
    (ivy zenburn-theme which-key sublimity solarized-theme smex racer projectile powerline nord-theme nlinum markdown-mode magit linum-relative ido-vertical-mode gruvbox-theme flycheck exec-path-from-shell evil dashboard company-jedi company-anaconda auto-complete auctex)))
 '(tramp-syntax (quote default) nil (tramp)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(provide '.emacs)
;; .emacs ends here
