(setq custom-file (concat user-emacs-directory ".custom.el"))
(when (display-graphic-p) (tool-bar-mode -1))
(menu-bar-mode -1)
(setq inhibit-startup-screen t)
(setq confirm-kill-emacs 'y-or-n-p)
(setq make-backup-files nil)
(setq remote-file-name-inhibit-locks t)

(use-package evil
  :ensure t
  :vc (:url "https://github.com/covanam/evil.git" :rev :newest)
  :custom
    (evil-want-keybinding nil)
    (evil-want-C-u-scroll t)
    (evil-search-module 'evil-search)
  :config
    (evil-mode 1)
    (define-key evil-normal-state-map (kbd "SPC") 'avy-goto-word-0)
    (define-key evil-visual-state-map (kbd "SPC") 'avy-goto-word-0)
)

(use-package annalist
  ; required by evil-collection
  :ensure t
  :vc (:url "https://github.com/covanam/annalist.el.git" :rev :newest)
)

(use-package evil-collection
  :ensure t
  :vc (:url "https://github.com/covanam/evil-collection.git" :rev :newest)
  :custom
    (evil-collection-setup-minibuffer t)
    (evil-collection-repl-submit-state 'insert)
  :config
    (evil-collection-init)
    (with-eval-after-load 'vc-annotate
      (evil-define-key 'normal vc-annotate-mode-map (kbd "RET") 'vc-annotate-show-log-revision-at-line)
    )
    (with-eval-after-load 'log-view
      (evil-define-key 'normal log-view-mode-map (kbd "RET") 'log-view-toggle-entry-display)
    )
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
