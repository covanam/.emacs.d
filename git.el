(use-package with-editor
  :ensure t
  :config
    (setq shell-command-with-editor-mode t)
    (add-hook 'shell-mode-hook  'with-editor-export-editor)
    (add-hook 'shell-mode-hook  'with-editor-export-git-editor)
    (add-hook 'eshell-mode-hook 'with-editor-export-editor)
    (add-hook 'eshell-mode-hook 'with-editor-export-git-editor)
    (add-hook 'term-exec-hook   'with-editor-export-editor)
    (add-hook 'term-exec-hook   'with-editor-export-git-editor)
    (add-hook 'vterm-mode-hook  'with-editor-export-editor)
    (add-hook 'vterm-mode-hook  'with-editor-export-git-editor)
    (add-hook 'server-visit-hook (lambda () (with-editor-mode 1)))
)

(defalias 'git-status 'vc-dir)

(defun git-blame ()
  (interactive)
  (let ((fname (buffer-name)))
    (if (and fname (string-match "\\(.*\\)\\.~\\([^~]+\\)~$" fname))
      (let ((path (match-string 1 fname))
            (hash (match-string 2 fname)))
        (vc-annotate path hash 'fullscale nil (line-number-at-pos))
      )
      (call-interactively #'vc-annotate)
    )
  )
)

(setq vc-log-show-limit 100)
(defalias 'git-log-- 'vc-print-log)
(defalias 'git-diff-- 'vc-diff)
(defalias 'git-diff 'vc-root-diff)
(defalias 'git-blame-deeper 'vc-annotate-revision-previous-to-line)

(defun git-show (commit)
  (interactive "srevision: ")
  (vc-print-root-log 1 commit))

(defun git-log (branch)
  (interactive "sbranch: ")
  (if (string= "" branch)
    (call-interactively #'vc-print-root-log)
    (vc-print-branch-log branch)
  )
)

(defun git (options)
  (interactive "sgit ")
  (with-editor
    (async-shell-command
      (concat "git " options)
    )
  )
)

(defun diff-hunk-revert ()
  (interactive)
  (setq current-prefix-arg '(4)) ; C-u
  (call-interactively 'diff-apply-hunk)
)
(defalias 'diff-hunk-apply 'diff-apply-hunk)
(defalias 'diff-buffer-apply 'diff-apply-buffer)
(defalias 'diff-hunk-refine 'diff-refine-hunk)
(defalias 'diff-hunk-refresh 'diff-refresh-hunk)
(defalias 'diff-hunk-split 'diff-split-hunk)
