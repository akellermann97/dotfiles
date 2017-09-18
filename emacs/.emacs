;;; package --- Summary
;;; Commentary:
;;;; AKellermann's .emacs file
; Alexander K. Kellermann
; 5 September 2017

 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
(scroll-bar-mode -1)
(setq tramp-default-method "ssh")

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'default-frame-alist '(font . "SF Mono-13"))
(add-to-list 'load-path "~/.emacs.d/evil")
(set-face-attribute 'default t :font "SF Mono-13")
(add-to-list 'custom-theme-load-path (expand-file-name "~/.emacs.d/themes/"))

(add-hook 'after-init-hook 'global-company-mode)
(package-initialize)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
(define-key global-map (kbd "RET") 'newline-and-indent)

(require 'ido)
(ido-mode t)

(require 'powerline)
(powerline-vim-theme)

;; esc quits
(load-theme 'base16-nord t)
;;; .emacs ends here
(require 'evil)
(evil-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fringe-mode 0 nil (fringe))
 '(menu-bar-mode t)
 '(package-selected-packages
   (quote
    (magit evil-escape with-editor telephone-line projectile powerline nord-theme markdown-mode magit-popup linum-relative flycheck exec-path-from-shell evil company base16-theme auto-complete auctex)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
