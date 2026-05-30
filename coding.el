(use-package citre
  :ensure t
  :vc (:url "https://github.com/covanam/citre.git" :rev :newest)
  :init
  :config
    (add-hook 'xref-backend-functions #'citre-xref-backend nil nil)
)

(use-package dtrt-indent
  :ensure t
  :custom
    (dtrt-indent-global-mode t)
  :vc (:url "https://github.com/covanam/dtrt-indent.git" :rev :newest)
)

(setq grep-command "git --no-pager grep --color -nH ")
(setq grep-use-null-device nil)
