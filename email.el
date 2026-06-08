(use-package smtpmail
  :ensure t
  :init
    (setq smtpmail-smtp-server "mail.linutronix.de")
    (setq smtpmail-smtp-user "namcao")
    (setq smtpmail-smtp-service 465)
    (setq smtpmail-stream-type 'ssl)
  :config
    (setq send-mail-function 'smtpmail-send-it)
    (setq message-send-mail-function 'smtpmail-send-it)
    (setq user-mail-address "namcao@linutronix.de")
    (setq user-full-name "Nam Cao")
    (setq message-user-fqdn "yellow.woof")
)

(use-package notmuch
  :load-path "notmuch/emacs"
  :init
    (setq notmuch-search-oldest-first nil)
    ;; pgp information
    ;;(setq pgp-default-user-id user-mail-address)
    ;;(setq mml-secure-openpgp-sign-with-sender 1)
  :config
    (setq notmuch-fcc-dirs "Sent -unread -inbox +sent")
    (setq notmuch-draft-folder "Drafts")
    (defun review-patch ()
      (interactive)
      (let*
        (
          (id (notmuch-show-get-message-id))
          (msg (notmuch-show-get-message-properties))
          (part (notmuch-show-get-part-properties))
          (subject (notmuch-show-get-subject))
          (diff-default-read-only t)
          (buf (get-buffer-create (concat "*notmuch-patch-" id "*")))
        )
        (switch-to-buffer buf)
        (let ((inhibit-read-only t))
        (erase-buffer)
        (insert subject)
        (insert "\n\n")
        (insert (notmuch-get-bodypart-text msg part nil)))
        (set-buffer-modified-p nil)
        (diff-mode)
        (goto-char (point-min))
      )
    )
)

