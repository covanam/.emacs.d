;;; -*- lexical-binding: t; -*-

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")))
(setq custom-file (concat user-emacs-directory ".custom.el"))
(when (display-graphic-p) (tool-bar-mode -1))
(menu-bar-mode -1)
(setq inhibit-startup-screen t)
(setq confirm-kill-emacs 'y-or-n-p)
(setq make-backup-files nil)
(setq remote-file-name-inhibit-locks t)

(use-package evil
  :load-path "evil"
  :custom
    (evil-want-keybinding nil)
    (evil-want-C-u-scroll t)
  :init
    (setq evil-search-module 'evil-search)
  :config
    (evil-mode 1)
    (define-key evil-normal-state-map (kbd "SPC") 'avy-goto-word-0)
    (define-key evil-visual-state-map (kbd "SPC") 'avy-goto-word-0)
    (define-key evil-motion-state-map (kbd "SPC") 'avy-goto-word-0)
)

(use-package evil-collection
  :load-path "evil-collection"
  :custom
    (evil-collection-setup-minibuffer t)
    (evil-collection-repl-submit-state 'insert)
  :config
    (evil-collection-init)
    (setq evil-collection-key-blacklist '("C-d" "C-u" "SPC" "*" "#"))
)

(use-package avy
  :ensure t
)

(with-eval-after-load "tramp"
  ; make user-local binaries (e.g. ctags, readtags) available
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path)
)

(add-hook 'after-change-major-mode-hook
  (lambda ()
    (modify-syntax-entry ?_ "w")
    (modify-syntax-entry ?$ "." (syntax-table))
  )
)

(load-file (expand-file-name "coding.el" user-emacs-directory))
(load-file (expand-file-name "email.el" user-emacs-directory))
(load-file (expand-file-name "git.el" user-emacs-directory))
