;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
(setq user-full-name "Thomas Stenhaug"
      user-mail-address "thomas.stenhaug@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font';; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "DejaVu Sans Mono" :size 22))
(setq doom-font (pcase (system-name)
                  ("korhal" (font-spec :family "JetBrains Mono" :size 22))
                  ("shakuras" (font-spec :family "JetBrains Mono" :size 16))
                  (_ (font-spec :family "DejaVu Sans Mono" :size 24))))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-nord)

;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/df/org")

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type t)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; Karvus' config
;; * General
(setq which-key-idle-delay 0.3)
(setq confirm-kill-emacs nil)
(setq max-specpdl-size 13000)
(setq +evil-want-o/O-to-continue-comments nil)
(setq large-file-warning-threshold (* 1024 1024 100))
(setq select-enable-primary t)


;; * Global keybinds
(setq doom-localleader-key ",")
;; (map! "M-s" 'swiper)
;; (map! "M-h" 'windmove-left)
;; (map! "M-l" 'windmove-right)
;; (map! "M-j" 'windmove-down)
;; (map! "M-k" 'windmove-up)
(map! "M-0" 'treemacs-select-window)
(map! "M-f" 'evil-avy-goto-char-2)
(map! :leader
      :prefix "t"
      "S" #'solaire-mode
      "P" #'smartparens-mode)
(map! :leader
      :prefix "g"
      :desc "Magit status in YADM" "k" #'ke/yadm)

;; separate TAB from C-i, and bind it to yas-expand
(define-key input-decode-map [?\C-i] [C-i])
(map! "<C-i>" 'yas-expand)

;; ** leader keybinds

(map! :leader
      :desc "Diff buffer with file" "b =" #'ke/diff-current-buffer-with-file
      :desc "Rainbow Delimiters Mode" "t d" #'rainbow-delimiters-mode
      :desc "Zoom" "t Z" #'+hydra/text-zoom/body
      :desc "Window hydra" "w d" #'+hydra/window-nav/body)

(defun ke/diff-current-buffer-with-file ()
  "As `diff-buffer-with-file', without prompt."
  (interactive)
  (diff-buffer-with-file (current-buffer)))

(defun doom/ediff-init-and-example ()
  "ediff the current `init.el' with the example in doom-emacs-dir"
  (interactive)
  (ediff-files (concat doom-private-dir "init.el")
               (concat doom-emacs-dir "init.example.el")))

; (define-key! help-map
;   "di"   #'doom/ediff-init-and-example
;   )

;; * Hydras

;; ** hydra-open

(defhydra hydra-open (:color blue)
  "open"
  ("9" (find-file "~/sdu/dm879-artificial-intelligence/dm879.org")
   "DM879 Artificial Intelligence")
  ("6" (find-file "~/sdu/dm566-data-mining-and-machine-learning/dm566.org")
   "DM565 Data Mining and Machine Learning")
  ("d" (find-file "~/df/notes/diary.org.gpg"))
  ("g" (find-file "~/df/org/gtd.org") "gtd")
  ("h" (find-file "~/df/org/habits.org") "habits")
  ("i" (find-file "~/.config/i3/config") "i3-config")
  ("j" (find-file "~/df/notes/journal.org") "journal")
  ("k" (find-file "~/ke") "ke")
  ("n" (find-file "~/df/notes/notes.org") "notes")
  ("p" (find-file "~/df/notes/projects.org" "projects"))
  ("r" (find-file "~/df/repetition/anki.org") "rep")
  ("s" (find-file "~/scratch/scratch.org") "scratch")
  ("t" (find-file "~/df/org/todo.org")))

(global-set-key (kbd "<f2>") 'hydra-open/body)

;; * Packages

;; ** abbrev-mode

(use-package abbrev
  :diminish abbrev-mode
  :init
  (setq save-abbrevs 'silently)
  (setq-default abbrev-mode 1)
  :config
  (if (file-exists-p abbrev-file-name)
      (quietly-read-abbrev-file)))

;; ** blink-cursor
;;
(blink-cursor-mode 't)

;; ** calendar

;; (use-package! calendar
;;   :config
;;   (copy-face font-lock-constant-face 'calendar-iso-week-face)
;;   (set-face-attribute 'calendar-iso-week-face nil
;;                       :height 0.5)
;;   (calendar-set-date-style 'iso)        ; YYYY-MM-DD
;;   (setq calendar-week-start-day 1)      ; monday
;;   ;; display ISO week number
;;   (setq calendar-intermonth-text
;;         '(propertize
;;           (format "%2d"
;;                   (car
;;                    (calendar-iso-from-absolute
;;                     (calendar-absolute-from-gregorian (list month day year)))))
;;           'font-lock-face calendar-iso-week-face))
;;   (evil-define-key 'normal 'calendar-mode-map
;;     "p" 'calendar-iso-print-date))

;; ** auctex

(after! tex
  (setq TeX-command-extra-options "-shell-escape"))

(after! preview
  (setq preview-scale 2))

;; ** deft


(defun ke-deft-strip-quotes (str)
  (cond ((string-match "\"\\(.+\\)\"" str) (match-string 1 str))
        ((string-match "'\\(.+\\)'" str) (match-string 1 str))
        (t str)))

(defun ke-deft-parse-title-from-front-matter-data (str)
  (if (string-match "^title: \\(.+\\)" str)
      (let* ((title-text (ke-deft-strip-quotes (match-string 1 str)))
             (is-draft (string-match "^draft: true" str)))
        (concat (if is-draft "[DRAFT] " "") title-text))))

(defun ke-deft-deft-file-relative-directory (filename)
  (file-name-directory (file-relative-name filename deft-directory)))

(defun ke-deft-title-prefix-from-file-name (filename)
  (let ((reldir (ke-deft-deft-file-relative-directory filename)))
    (if reldir
        (concat (directory-file-name reldir) " > "))))

(defun ke-deft-parse-title-with-directory-prepended (orig &rest args)
  (let ((str (nth 1 args))
        (filename (car args)))
    (concat
     (ke-deft-title-prefix-from-file-name filename)
     (let ((nondir (file-name-nondirectory filename)))
       (if (or (string-prefix-p "README" nondir)
               (string-suffix-p ".txt" filename))
           nondir
         (if (string-prefix-p "---\n" str)
             (ke-deft-parse-title-from-front-matter-data
              (car (split-string (substring str 4) "\n---\n")))
           (apply orig args)))))))

(after! deft
  (setq deft-directory "~/df/roam")
  (setq deft-recursive t)
  (setq deft-strip-summary-regexp
        (concat "\\("
                "[\n\t]" ;; blank
                "\\|^#\\+[[:alpha:]_]+:.*$" ;; org-mode metadata
                "\\|^:PROPERTIES:\n\\(.+\n\\)+:END:.*$"
                "\\)")))

(advice-add 'deft-parse-title :override
            (lambda (file contents)
              (if deft-use-filename-as-title
                  (deft-base-filename file)
                (let* ((case-fold-search 't)
                       (begin (string-match "#\\+title: " contents))
                       (end-of-begin (match-end 0))
                       (end (string-match "\n" contents begin)))
                  (if begin
                      (substring contents end-of-begin end)
                    (format "%s" file))))))


;; ** evil

(after! evil
  (setq evil-move-cursor-back nil))

;; ** evil-org

(after! evil-org
  (remove-hook 'org-tab-first-hook #'+org-cycle-only-current-subtree-h))

;; ** graphviz-dot-mode

(use-package! graphviz-dot-mode)

;; ** haskell-interactive-mode

(after! haskell-interactive-mode
  (evil-define-key 'normal haskell-error-mode-map
    "q" 'quit-window))

;; ** image-mode

(after! image-mode
  (map! :map image-mode-map
        :n "+" #'image-increase-size
        :n "-" #'image-decrease-size))
;;
;; ** ispell

;; Force ispell to use default dictionary, otherwise Doom Emacs tries to use one
;; under ~/.emacs.d/locate/etc
(after! ispell
  (setq ispell-personal-dictionary nil))

;; ** ivy

;; (after! ivy
;;   (map! :map ivy-minibuffer-map
;;         "C-k" #'ivy-kill-line
;;         "M-f" #'forward-word))

;; ** lispyville


(after! lispy ()
  (map! :map lispy-mode-map
        :i ";" #'self-insert-command))

(after! lispyville
  (lispyville-set-key-theme
   '((operators normal) c-w
     text-objects
     (prettify insert)
     (atom-movement normal visual)
     slurp/barf-lispy
     (wrap normal insert)
     additional
     additional-insert
     additional-movement
     (additional-wrap normal insert)
     (escape insert))))


;; ** lsp-mode

(after! lsp
  (setq lsp-eslint-package-manager "pnpm")
  (setq lsp-eslint-enable t)
  (setq lsp-eslint-lint-task-enable t)
  (setq lsp-eslint-provide-lint-task t)
  (setq lsp-typescript-npm "pnpm"))


;;
;; ** lorem ipsum

(use-package! lorem-ipsum
  :config
  (map! :leader
        :desc "Lipsum paragraph" "i l" #'lorem-ipsum-insert-paragraphs))

;; ** mu4e

(after! mu4e
  ;; mailbox.org config
  (setq mu4e-update-interval 60)
  (set-email-account!
   "tstenhaug@mailbox.me"
   '((user-mail-address . "tstenhaug@mailbox.org")
     (mu4e-sent-folder  . "/mbox/Sent")
     (mu4e-drafts-folder  . "/mbox/Drafts")
     (mu4e-trash-folder  . "/mbox/Trash")
     (mu4e-refile-folder  . "/mbox/Archive/2022")
     (smtpmail-smtp-user . "tstenhaug@mailbox.org")
     (smtpmail-smtp-server . "smtp.mailbox.org")
     (smtpmail-smtp-service . 587)
     (smtpmail-stream-type . starttls))
   t))

;; ** ol-* (org link)
;; ** org-mode

(use-package! ol-man
  :after ol)

;; This is the default setting -- Doom sets it to 0. Might like that, so I'm
;; keeping this for posterity.
;; (setq org-tags-column -77)

;; unmap! doesn't work like I expect.

;; https://github.com/hlissner/doom-emacs/issues/814

(after! org
  (setq org-agenda-custom-commands
        '(("l" agenda*)
          ("d" "Today-todos" tags-todo "today")))
  (setq org-attach-id-dir "org-attach/")
  (when IS-LINUX
    ;; ;; (push '("\\.pdf\\'" . "evince %s") org-file-apps)
    (push '("\\.pdf\\'" . emacs) org-file-apps)
    )
  (setq org-ditaa-jar-path "~/.emacs.d/.local/straight/repos/org-mode/contrib/scripts/ditaa.jar")
  (setq org-format-latex-options
        (plist-put org-format-latex-options :scale 1.2))
  (setq org-hide-emphasis-markers t)
  (setq org-id-link-to-org-use-id t)
  (setq org-list-allow-alphabetical t)
  (setq org-log-into-drawer t)
  (setq org-pretty-entities t)
  (setq org-preview-latex-default-process 'dvisvgm)
  (setq org-startup-folded t)
  (setq org-use-sub-superscripts t))

(defun ke-org-init-keybinds-h ()
  (map! :map org-mode-map
        :localleader
        "p" nil
        "t" nil
        "T" nil)
  (map! :map org-mode-map
        :localleader
        "T" #'org-babel-tangle
        (:prefix ("p" . "priority/preview")
         "D" #'ke/org-delete-preview-latex-image-directory
         "b" #'ke/org-latex-preview-buffer
         "e" #'org-toggle-pretty-entities
         "f" #'org-latex-preview
         "p" #'org-priority
         "s" #'ke/org-latex-preview-subtree)
        (:prefix ("t" . "todo/toggle")
         "b" #'ke/org-toggle-confirm-babel-evaluate
         "s" #'ke/org-toggle-export-initial-scope
         "t" #'org-todo)))

(add-hook 'org-mode-hook #'ke-org-init-keybinds-h t)

(defun ke/org-toggle-export-initial-scope ()
  "Toggle initial export scope betweeen `buffer' and `subtree'."
  (interactive)
  (cond ((eq 'buffer org-export-initial-scope)
         (setq org-export-initial-scope 'subtree)
         (message "subtree"))
        (t
         (setq org-export-initial-scope 'buffer)
         (message "buffer"))))

(defun ke/org-delete-preview-latex-image-directory ()
  "Delete the directory containing temporary images for preview."
  (interactive)
  (let ((directory (expand-file-name org-preview-latex-image-directory)))
    (when (yes-or-no-p (format "Sure you want to delete %s"
                               directory))
      (delete-directory directory t)
      (message "Deleted %s" directory))))

(defun ke/org-latex-preview-subtree ()
  "Toggle LaTeX preview for elements in this subtree."
  (interactive)
  (org-latex-preview '(4)))

(defun ke/org-latex-preview-buffer ()
  "Toggle LaTeX preview for elements in whole buffer."
  (interactive)
  (org-toggle-latex-fragment '(16)))

(defun ke/org-toggle-confirm-babel-evaluate ()
  "Toggle the value of `org-confirm-babel-evaluate'."
  (interactive)
  (if (setq org-confirm-babel-evaluate (not org-confirm-babel-evaluate))
      (message "org-confirm-babel-evaluate is now on")
    (message "org-confirm-babel-evaluate is now off")))

;; ** org-agende

;; (after! org-agenda
;;   (map! :leader
;;         (:prefix ("a" . "Org Agenda")
;;          "a" #'org-agenda
;;          "l" #'org-agenda-list
;;          "t" #'org-todo-list)))

;; ** org-attach

(after! org-attach
  (setq org-attach-auto-tag "attach")
  (setq org-attach-id-dir "org-attach/"))

;; ** org-download
;;
;; Using Doom +dragndrop module causes org-download-screenshot to insert
;; "[[attach:...]]" links instead of "[[file:...]]" links, which is not what I
;; want.  Look back at this later.

;; (use-package! org-download
;;   :config
;;   (setq org-download-screenshot-method "xclip -selection clipboard -t image/png -o > %s")
;;   (setq org-download-method 'attach)
;;   (setq org-download-link-format-function #'ke-org-download-link-format))

;; (defun ke-org-download-link-format (filename)
;;   (format org-download-link-format
;;           (org-link-escape
;;            (funcall org-download-abbreviate-filename-function filename))))



;; ** org-journal

(after! org-journal
  (setq org-journal-date-format "%A, %F")
  (setq org-journal-file-type 'weekly))

;; ** org-roam
;;
(after! org-roam
  (setq org-roam-directory "~/df/roam"))

;; ** ox-latex

(after! ox-latex
  (setq org-latex-listings 'minted)
  (setq org-latex-packages-alist
        '(("" "kesci" t)
          ("" "keunicodechars" t)
          ;; ("" "unicode-math" t ("xelatex"))
          ("" "libertine" t)
          ("" "svg" t)
          ("" "tikz" t)
          ("scaled=0.89" "inconsolata" t) ; for verbatim/listings etc
                                        ; (tt-family)
          ("" "minted" t)))
  (setq org-latex-pdf-process '("latexmk -g -pdf -pdflatex=\"%latex\" --shell-escape -outdir=%o %f")))

;; ** pdf-tools

(map! :map pdf-view-mode-map
      :after pdf-tools
      :localleader
      (:prefix ("a" . "annotation")
       "l" #'pdf-annot-list-annotations))

(map! :map pdf-annot-list-mode-map
      :after pdf-tools
      :nv "q" #'tablist-quit)

;; ** projectile

(after! projectile
  (projectile-register-project-type 'npm '("package.json")
                                    :project-file "package.json"
                                    :compile "pnpm build"
                                    :test "pnpm test"
                                    :run "pnpm start"
                                    :test-suffix ".spec.ts"))

;; ** pdfgrep
;;
(use-package! pdfgrep)

;; ** ranger

;; won't be using ranger it seems like, but keeping this snippet in case I
;; change my mind.

(after! ranger
  (map! :map ranger-mode-map
        :i "C-w" nil)
  (map! :map ranger-mode-map
        :i "C-w k" #'evil-window-up
        :i "C-W j" #'evil-window-down
        :i "C-w l" #'evil-window-right
        :i "C-w h" #'evil-window-left))

;; ** smartparens

(use-package! smartparens-latex
  :config
  (sp-with-modes 'org-mode
    (sp-local-pair "\\[" "\\]"
                   :unless '(sp-latex-point-after-backslash))))

;; ** term

(after! term
  (map! :map term-raw-map
        :i "C-w" nil)
  (map! :map term-raw-map
        :i "C-w k" #'evil-window-up
        :i "C-W j" #'evil-window-down
        :i "C-w l" #'evil-window-right
        :i "C-w h" #'evil-window-left))

;; ** tramp

(after! tramp
  ;; tentative configuration to work around undesirable behaviour when
  ;; tramp-host runs zsh.
  (add-to-list 'tramp-connection-properties
               (list (regexp-quote "/sshx:tarsonis:")
                     "remote-shell" "/bin/sh"))
  ;; facilitate using Emacs for working with dotfiles repo in YADM
  (add-to-list 'tramp-methods
               '("yadm"
                 (tramp-login-program "yadm")
                 (tramp-login-args (("enter")))
                 (tramp-login-env (("SHELL") ("/bin/bash")))
                 (tramp-remote-shell "/bin/bash")
                 (tramp-remote-shell-args ("-c")))))
;; ** treemacs

(after! treemacs
  (add-to-list 'treemacs-pre-file-insert-predicates
               #'treemacs-is-file-git-ignored?)
  (setq doom-themes-treemacs-theme "doom-atom"))

;; ** vterm

(after! vterm
  (map! :map vterm-mode-map
        :i "C-w" nil)
  (map! :map vterm-mode-map
        :i "C-w k" #'evil-window-up
        :i "C-W j" #'evil-window-down
        :i "C-w l" #'evil-window-right
        :i "C-w h" #'evil-window-left
        :i "<tab>" #'vterm--self-insert))

(after! vterm-mode
  (set-company-backend! 'vterm-mode nil))
;; ** with-editor
;;
;; Some localleader-ish bindings for with-editor.

(after! with-editor
  (map! :map with-editor-mode-map
        :localleader
        "," #'with-editor-finish
        "k" #'with-editor-cancel))

;; ** yasnippet

(after! yasnippet
  ;; (setq +snippets-dir (expand-file-name "~/emacs/snippets/"))
  ;; (add-to-list 'yas-snippet-dirs +snippets-dir)
  (map! :leader
        (:prefix ("y" . "yas")
         "e" #'+snippets/edit
         "f" #'+snippets/find
         "n" #'+snippets/new
         "p" #'+snippets/find-private)))

;; custom functionality

(defun ke/iso-date ()
  "Return an ISO-8601-formatted date-string."
  (format-time-string "%Y-%m-%d"))

(defun ke/iso-date-time ()
  "Return an ISO-8601-formatted date-time-string."
  (format-time-string "%Y-%m-%d %H:%M" (current-time)))

(defun ke/insert-iso-date ()
  "Insert into current buffer current date as YYYY-MM-DD in buffer,"
  (interactive)
  (insert (ke/iso-date)))

(defun ke/insert-iso-date-time ()
  "Insert into buffer the current date and time as YYYY-MM-DD HH:MM."
  (interactive)
  (insert (ke/iso-date-time)))

(defun ke/insert-ruler ()
  "Insert an 80 character long ruler"
  (interactive)
  (beginning-of-line)
  (dotimes (i 9)
    (insert (format "%d         " i)))
  (forward-line)
  (beginning-of-line)
  (dotimes (_ 8)
    (insert "0123456789"))
  (insert "0"))

(defun ke/insert-time ()
  "Insert into buffer the current time as HH:MM."
  (interactive)
  (insert (format-time-string "%H:%M" (current-time))))

(defun ke/yadm ()
  "Open magit-status inside a YADM session."
  (interactive)
  (magit-status "/yadm::"))

(map! :leader
      :prefix "i"
      :desc "ISO-date" "d" #'ke/insert-iso-date
      :desc "Time" "t" #'ke/insert-time)


(setq org-ditaa-jar-path "~/.emacs.d/.local/straight/repos/org-mode/contrib/scripts/ditaa.jar")
;; (set-popup-rule! "\\*notmuch-hello\\*" :ignore t)

(define-key! evil-insert-state-map
  "C-w" evil-window-map)

;; windows
;;
(when (and (eq system-type 'gnu/linux)
           (string-match
            "Linux.*icrosoft.*Linux"
            (shell-command-to-string "uname -a")))
  (setq
   browse-url-generic-program  "/mnt/c/Windows/System32/cmd.exe"
   browse-url-generic-args     '("/c" "start")
   browse-url-browser-function #'browse-url-generic))

;; Remove underlining from links
(custom-set-faces! '(link :underline nil))

;; fancy splash
(setq fancy-splash-image
      (expand-file-name (concat
                         doom-private-dir "banners/doom-logo.png")))


;; Opt out of line numbers for some modes

(remove-hook! '(text-mode-hook)
              #'display-line-numbers-mode)

