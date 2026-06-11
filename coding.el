;;; -*- lexical-binding: t; -*-

(use-package citre
  :load-path "citre"
  :init
  :config
    (add-hook 'xref-backend-functions #'citre-xref-backend nil nil)
)

(use-package dtrt-indent
  :custom
    (dtrt-indent-global-mode t)
  :load-path "dtrt-indent"
)

(setq grep-command "git --no-pager grep --color -nH ")
(setq grep-use-null-device nil)
