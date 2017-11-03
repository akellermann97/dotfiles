;;; package --- Summary
;;; Commentary:
;;;; AKellermann's .emacs file
; Alexander K. Kellermann
; 5 September 2017

 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
(setq tramp-default-method "ssh")

(require 'package)
;;(require 'dashboard)

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'default-frame-alist '(font . "SF Mono-13"))
(set-face-attribute 'default t :font "SF Mono-13")
(add-to-list 'custom-theme-load-path (expand-file-name "~/.emacs.d/themes/"))

;; This is the dashboard code (the startup screen for emacs)
;;(dashboard-setup-startup-hook)

(add-hook 'after-init-hook 'global-company-mode)
(package-initialize)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
(define-key global-map (kbd "RET") 'newline-and-indent)

;; This is which-key, tells you what keys to pres
(which-key-mode) 
(require 'ido)
(ido-mode t)

;; Rust plug-ins
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

(require 'rust-mode)
(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)
;; End of Rust plug-ins

;;Python plug-ins
(eval-after-load "company"
  '(add-to-list 'company-backends 'company-anaconda))
(add-hook 'python-mode-hook 'anaconda-mode)

(require 'powerline)
(powerline-vim-theme)

;; esc quits
(load-theme 'gruvbox t)
;;; .emacs ends here
(require 'evil)
(evil-mode 1)

;; Windmove
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "bfdcbf0d33f3376a956707e746d10f3ef2d8d9caa1c214361c9c08f00a1c8409" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "b2b86aedf22eb69156420e54b28aa39375277d38ee953bbce8342e71a2e68c41" "4eb982b248bf818a72877ecb126a2f95d71eea24680022789b14c3dec7629c1b" "65d9573b64ec94844f95e6055fe7a82451215f551c45275ca5b78653d505bc42" "7f3ef7724515515443f961ef87fee655750512473b1f5bf890e2dc7e065f240c" "527df6ab42b54d2e5f4eec8b091bd79b2fa9a1da38f5addd297d1c91aa19b616" "fee4e306d9070a55dce4d8e9d92d28bd9efe92625d2ba9d4d654fc9cd8113b7f" "93268bf5365f22c685550a3cbb8c687a1211e827edc76ce7be3c4bd764054bad" default)))
 '(display-battery-mode nil)
 '(fringe-mode 0 nil (fringe))
 '(global-linum-mode nil)
 '(linum-format (quote dynamic))
 '(menu-bar-mode t)
 '(package-selected-packages
   (quote
    (nlinum zenburn-theme solarized-theme company-anaconda company-jedi anaconda-mode dashboard racer rust-mode which-key gruvbox-theme magit evil-escape with-editor telephone-line projectile powerline nord-theme markdown-mode magit-popup linum-relative flycheck exec-path-from-shell evil company base16-theme auto-complete auctex)))
 '(scroll-bar-mode nil)
 '(send-mail-function (quote sendmail-send-it))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fringe ((t nil)))
 '(scroll-bar ((t nil))))
