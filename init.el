(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/plugins/")
(add-to-list 'load-path "~/.emacs.d/bruceravel-gnuplot-mode-eec13f0/")
(add-to-list 'load-path "~/.emacs.d/completion-ui/")
(add-to-list 'load-path "~/.emacs.d/emacs-jabber-0.8.0/")
(add-to-list 'load-path "~/.emacs.d/elpa/frame-bufs/")
(add-to-list 'load-path "~/.emacs.d/plugins/matlab-emacs")

;;;;;;;;;;;;;;;;;;;;;;;
;; Platform specific ;;
;;;;;;;;;;;;;;;;;;;;;;;

;; Linux

;; (setq x-select-enable-clipboard t)
;; (setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
;; Frame size
;; (setq default-frame-alist
;;       '((top . 0) (left . 500)
;;         (width . 90) (height . 73)
;;         (font . "menlo-12")
;;         )
;; 			)

;; Mac osx

;; Frame size
(setq default-frame-alist
      '((top . 0) (left . 500)
        (width . 90) (height . 73)
        (font . "Menlo-12")
        )
			)

;; MacOSX stuff
(setenv "PATH" (concat (getenv "PATH") ":/usr/texbin/:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/X11/bin:."))
(setq exec-path (append exec-path '("/usr/texbin/:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/X11/bin:.")))

(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)

(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell
				 (replace-regexp-in-string "[[:space:]\n]*$" ""
																	 (shell-command-to-string "$SHELL -l -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))
(when (equal system-type 'darwin) (set-exec-path-from-shell-PATH))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Fundamental mode related (every mode) ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)


(tool-bar-mode -1)

(defun yank-and-indent ()
	"Yank and then indent the newly formed region according to mode."
	(interactive)
	(yank)
	(call-interactively 'indent-region))

(global-set-key "\C-y" 'yank-and-indent)

(defun kill-and-join-forward (&optional arg)
	"If at end of line, join with following; otherwise kill line.
    Deletes whitespace at join."
	(interactive "P")
	(if (and (eolp) (not (bolp)))
			(delete-indentation t)
		(kill-line arg)))

(global-set-key (kbd "C-k") 'kill-and-join-forward)

;; quiet, please! No dinging!
(setq visible-bell nil)
(setq ring-bell-function nil)

(set-language-environment "UTF-8")


;; Forcing horizontal split
(setq split-height-threshold 0)
(setq split-width-threshold nil)

;; Too much questioning ...
(fset 'yes-or-no-p 'y-or-n-p)

(set-default 'tab-width 2)							;Too much tab kill the tab

;; Key binding
(global-set-key "\M-/" 'hippie-expand)
(global-set-key (kbd "M-`") 'other-frame)
(global-set-key (kbd "M-s" ) 'save-buffer)
(global-set-key (kbd "M-[" ) 'backward-paragraph)
(global-set-key (kbd "M-]" ) 'forward-paragraph)
;; (global-set-key (kbd "M-v") 'yank)
;; (global-set-key (kbd "M-c") 'kill-ring-save)
;; (global-set-key (kbd "M-o") 'find-file)
(global-set-key (kbd "M-h") 'windmove-left)          ; move to left windnow
(global-set-key (kbd "M-l") 'windmove-right)        ; move to right window
(global-set-key (kbd "M-k") 'windmove-up)              ; move to upper window
(global-set-key (kbd "M-j") 'windmove-down)          ; move to downer window
(global-set-key (kbd "C-c C-SPC") 'compile )
(global-set-key (kbd "M-m") 'recompile )
(global-set-key (kbd "C-c C-e") 'eshell )
(add-hook 'c-mode-common-hook (lambda() (local-set-key (kbd "C-c o") 'ff-find-other-file)))
(global-set-key (kbd "C-n") 'next-line)
(global-set-key (kbd "C-p") 'previous-line )
(global-set-key (kbd "M-r") 'query-replace )
(global-set-key (kbd "M-0") 'delete-window)
(global-set-key (kbd "M-1") 'delete-other-windows-vertically)
(global-set-key (kbd "M-2") 'split-window-vertically)
(global-set-key (kbd "M-3") 'split-window-horizontally)

(defun kill-and-close ()
  (interactive)
  ;;; Place your code below this line, but inside the bracket.
	(kill-buffer)
	(delete-window)
  )

(defun dedicate ()
	(interactive)
	(set-window-dedicated-p (selected-window) t))

(defun kill_interp ()
	(interactive)
	(interrupt-process "*interpretation*" nil))

(global-set-key (kbd "C-q") 'kill_interp )


(defadvice isearch-search (after isearch-no-fail activate)
  (unless isearch-success
    (ad-disable-advice 'isearch-search 'after 'isearch-no-fail)
    (ad-activate 'isearch-search)
    (isearch-repeat (if isearch-forward 'forward))
    (ad-enable-advice 'isearch-search 'after 'isearch-no-fail)
    (ad-activate 'isearch-search)))


;; MacOSX stuff

(setenv "PATH" (concat (getenv "PATH") ":/usr/texbin/:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/X11/bin:."))
(setq exec-path (append exec-path '("/usr/texbin/:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/X11/bin:.")))

;; (setq mac-command-modifier 'meta)
;; (setq mac-option-modifier nil)

(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell
      (replace-regexp-in-string "[[:space:]\n]*$" ""
        (shell-command-to-string "$SHELL -l -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))
(when (equal system-type 'darwin) (set-exec-path-from-shell-PATH))

;; ;;; This was installed by package-install.el.
;; ;;; Move this code earlier if you want to reference
;; ;;; packages in your .emacs.
(require 'package)
(add-to-list 'package-archives
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)

;;;;;;;;;;;;;;;;;;
;;  my modes    ;;
;;;;;;;;;;;;;;;;;;

;; Ido mode
(ido-mode t)
(setq ido-enable-flex-matching t				;; fuzzy matching is a must have
			ido-everywhere t
			ido-use-virtual-buffers t)
(define-key ido-common-completion-map (kbd "TAB") 'ido-next-match)
(define-key ido-common-completion-map (kbd "C-TAB") 'ido-prev-match)
(setq ido-default-buffer-method 'selected-window)

;; iFlipBuffer
(require 'iflipb)

(global-set-key (kbd "<C-tab>") 'iflipb-next-buffer)
(global-set-key
 (if (featurep 'xemacs) (kbd "<C-iso-left-tab>") (kbd "<C-S-iso-lefttab>"))
 'iflipb-previous-buffer)
(set-default 'iflipb-ignore-buffers nil)


;; winner-mode is the window configuration history
(winner-mode 1)
(global-set-key (kbd "M-C-/") 'winner-undo)

;; Smex
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(define-key ido-common-completion-map (kbd "TAB") 'ido-next-match)


;; yasnippet
(add-to-list 'load-path
	     "~/.emacs.d/plugins/yasnippet-0.6.1c/")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet-0.6.1c/snippets/")
(global-set-key (kbd "C-c C-y") 'yas/expand)




;; Complete with tab !!
;; (require 'smart-tab)
;; (global-smart-tab-mode 1)
;; (setq smart-tab-using-hippie-expand t)
;; (setq smart-tab-disabled-major-modes '(org-mode term-mode eshell-mode debugger-mode matlab-shell-mode shell-mode))

;; An other minor mode for auto-completion...
(require 'auto-complete-config)
;;(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
;;(ac-config-default)
(setq-default ac-sources '( ac-source-words-in-buffer ac-source-filename))
;; (setq-default ac-sources '(ac-source-abbrev ac-source-words-in-same-mode-buffers ac-source-words-in-buffer  ac-source-symbols ))
;; (ac-set-trigger-key nil)
;; (setq ac-auto-start t)

(global-auto-complete-mode t)
(defun auto-complete-mode-maybe ()
  "No maybe for you. Only AC!"
  (unless (minibufferp (current-buffer))
    (auto-complete-mode 1)))



;; Pager
;; (require 'pager)
;; (global-set-key "\C-v"     'pager-page-down)
;; (global-set-key "\M-v"      'pager-page-up)

(require 'frame-bufs)
(frame-bufs-mode t)

;; gtags easier life functon
(defun gtags-create-or-update ()
  "create or update the gnu global tag file"
  (interactive)
  (if (not (= 0 (call-process "global" nil nil nil " -p"))) ; tagfile doesn't exist?
    (let ((olddir default-directory)
          (topdir (read-directory-name
                    "gtags: top of source tree:" default-directory)))
      (cd topdir)
      (async-shell-command "gtags && echo 'created tagfile'")
      (cd olddir)) ; restore
    ;;  tagfile already exists; update it
    (start-process "tag_update" "*gtag-file-update*" "global" "-uq")))
;;    (async-shell-command "global -uq && echo 'updated tagfile'")))

(add-hook 'gtags-mode-hook
  (lambda()
    (local-set-key (kbd "M-.") 'gtags-find-tag)   ; find a tag, also M-.
    (local-set-key (kbd "M-,") 'gtags-find-rtag)))  ; reverse tag
(add-hook 'gtags-select-mode-hook
  (lambda()
    (local-set-key (kbd "RET") 'gtags-select-tag)
		)
	)
;; (setq c-mode-common-hook
;;   (lambda ()
;;     (require 'gtags)
;;     (gtags-mode t)
;;     )
;; 	)
(add-hook 'c-mode-common-hook
      (lambda ()
				(require 'gtags)
				(gtags-mode t)
				(add-hook 'after-save-hook
									(lambda ()
										(gtags-create-or-update)) nil t)))

;; (add-hook 'c-mode-common-hook
;;       (lambda()
;;         (add-hook 'local-write-file-hooks
;;               '(lambda()
;; 								 (save-buffer)
;;                    (gtags-create-or-update)))))

;; C-M-, find all usages of symbol.
;; (global-set-key [(control meta ,)] 'gtags-find-symbol)


;; Flymake... nerver worked
(require 'flymake)
(add-to-list 'flymake-master-file-dirs "../src/")

(setq savehist-additional-variables    ;; also save...
  '(search-ring regexp-search-ring)    ;; ... my search entries
  savehist-file "~/.emacs.d/savehist") ;; keep my home clean
(savehist-mode t)                      ;; do customization before activate



(require 'misc)
(global-set-key (kbd "M-f") 'forward-word)
(global-set-key (kbd "M-b") 'backward-word)


;; Display
 ;;(setq special-display-buffer-names '("*compilation*"))
 ;; (setq special-display-function
 ;;       (lambda (buffer &optional args)
 ;;         (split-window)
 ;;         (switch-to-buffer buffer)
 ;;         (get-buffer-window buffer 0)))



;; To the web !
(defun prelude-google ()
  "Googles a query or region if any."
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (if mark-active
        (buffer-substring (region-beginning) (region-end))
      (read-string "Google: ")))))
(global-set-key (kbd "C-x g") 'prelude-google)




;; sending mail -- replace USERNAME with your gmail username
;; also, make sure the gnutls command line utils are installed
;; package 'gnutls-bin' in Debian/Ubuntu

(require 'smtpmail)
;; alternatively, for emacs-24 you can use:
(setq message-send-mail-function 'smtpmail-send-it
    smtpmail-stream-type 'starttls
    smtpmail-default-smtp-server "smtp.inria.fr"
    smtpmail-smtp-server "smtp.inria.fr"
		smtpmail-auth-credentials '(("smtp.inria.fr" 25 "proudot" "ifu#eu$a"))
    smtpmail-smtp-service 25)


;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)


;; CMake
;; Provides syntax highlighting and indentation for CMakeLists.txt and *.cmake source files.
(setq load-path (cons (expand-file-name ".emacs.d/cmake-mode.el") load-path))
(require 'cmake-mode)
(setq auto-mode-alist
			(append '(("CMakeLists\\.txt\\'" . cmake-mode)
								("\\.cmake\\'" . cmake-mode))
							auto-mode-alist))

(set-cursor-color "green")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(blink-cursor-mode t)
 '(comint-input-ignoredups t)
 '(comint-prompt-read-only t)
 '(default-justification (quote full))
 '(doc-view-continuous nil)
 '(eshell-scroll-to-bottom-on-output (quote all))
 '(framepop-enable-keybinding "<f2>")
 '(fringe-mode 5 nil (fringe))
 '(hippie-expand-try-functions-list (quote (try-expand-dabbrev try-expand-dabbrev-all-buffers try-complete-file-name-partially try-complete-file-name try-expand-all-abbrevs try-expand-list try-expand-line try-expand-dabbrev-from-kill)))
 '(ibuffer-saved-filter-groups nil)
 '(ibuffer-saved-filters (quote (("flimtrack" ((filename . "flimtrack"))) ("org_files" ((name . "org"))) ("gnus" ((or (mode . message-mode) (mode . mail-mode) (mode . gnus-group-mode) (mode . gnus-summary-mode) (mode . gnus-article-mode)))) ("programming" ((or (mode . emacs-lisp-mode) (mode . cperl-mode) (mode . c-mode) (mode . java-mode) (mode . idl-mode) (mode . lisp-mode)))))))
 '(icicle-buffers-ido-like-flag t)
 '(inhibit-startup-screen t)
 '(jabber-alert-presence-hooks nil)
 '(jabber-chat-buffer-show-avatar nil)
 '(jabber-roster-line-format "%c %-25n %u %-8s  %S")
 '(matlab-mode-install-path (quote ("~/code/heterogenous_track/common/" "~/code/heterogenous_track/data_analysis/" "/usr/local/MATLAB/R2012a/")))
 '(midnight-mode t nil (midnight))
 '(org-agenda-files (quote ("~/Dropbox/org_files/biblio.org" "~/Dropbox/org_files/these.org" "~/Dropbox/org_files/notes.org")))
 '(org-blank-before-new-entry (quote ((heading . t) (plain-list-item . auto))))
 '(org-export-latex-classes (quote (("article" "\\documentclass[11pt]{article}" ("\\section{%s}" . "\\section*{%s}") ("\\subsection{%s}" . "\\subsection*{%s}") ("\\subsubsection{%s}" . "\\subsubsection*{%s}") ("\\paragraph{%s}" . "\\paragraph*{%s}") ("\\subparagraph{%s}" . "\\subparagraph*{%s}")) ("report" "\\documentclass[11pt]{report}" ("\\part{%s}" . "\\part*{%s}") ("\\chapter{%s}" . "\\chapter*{%s}") ("\\section{%s}" . "\\section*{%s}") ("\\subsection{%s}" . "\\subsection*{%s}") ("\\subsubsection{%s}" . "\\subsubsection*{%s}")) ("book" "\\documentclass[11pt]{book}" ("\\part{%s}" . "\\part*{%s}") ("\\chapter{%s}" . "\\chapter*{%s}") ("\\section{%s}" . "\\section*{%s}") ("\\subsection{%s}" . "\\subsection*{%s}") ("\\subsubsection{%s}" . "\\subsubsection*{%s}")) ("beamer" "\\documentclass{beamer}" org-beamer-sectioning) ("letter" "\\documentclass[12pt]{lettre}"))))
 '(send-mail-function (quote mailclient-send-it))
 '(show-paren-mode t)
 '(tags-revert-without-query t)
 '(transient-mark-mode t))

;; Org Mode

;; (define-key viper-vi-global-user-map (kbd "C-c /") 'org-sparse-tree)
;; (setq org-blank-before-new-entry t) ERROR
(add-hook 'org-mode-hook
					(lambda ()
						(local-set-key (kbd "C-c C-h") 'my-screenshot)
						(define-key org-mode-map [(control tab)] nil)
						)
					)

(defun my-screenshot ()
	"Take a screenshot into a unique-named file in the current buffer file
directory and insert a link to this file."
  (interactive)
	(setq filename
				(concat
				 (make-temp-name
					(concat (buffer-file-name (buffer-base-buffer))
									"_"
									(format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
  (call-process "screencapture" nil nil nil "-s" filename)
  (insert (concat "[[" filename "]]"))
	;; (org-display-inline-images)
	)

(setq org-attach-store-link-p 'attached)
(setq org-highlight-latex-fragments-and-specials t)
(global-set-key (kbd "C-c l") 'org-store-link)
(setq org-file-apps
			'(
				("\\.tiff\\'" . default)
				("\\.tif\\'" . default)
				("\\.png\\'" . default)
				("\\.pdf\\'" . default)
				(auto-mode . default)
				)
			)

(setq org-refile-targets '((nil :maxlevel . 2)
																				; all top-level headlines in the
																				; current buffer are used (first) as a
																				; refile target
                           (org-agenda-files :maxlevel . 2)))

(setq org-src-fontify-natively t)
(require 'org-crypt)

(setq org-list-demote-modify-bullet
       '(("+" . "-") ("-" . "*") ("*" . "+")))
(setq org-M-RET-may-split-line t)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
	 (latex . t)
	 (gnuplot . t)
	 (C . t)
	 (sh . t)
	 (plantuml . t)
	 (python . t)
	 )
 )

(setq org-plantuml-jar-path
      (expand-file-name "~/logiciel/plantuml.jar"))

(setq org-confirm-babel-evaluate nil)

;; end Org mode

;; IflipBuffer
(global-set-key (kbd "<C-tab>") 'iflipb-next-buffer)
(global-set-key
 (if (featurep 'xemacs) (kbd "<C-iso-left-tab>") (kbd "<C-S-iso-lefttab>"))
 'iflipb-previous-buffer)

;; Gtalk in emacs
;; (sometime usefull but chat is not always updated)
(require 'jabber)
(setq tls-program '("openssl s_client -connect %h:%p -no_ssl2 -no_ticket")) ; a hack
(setq jabber-account-list
			'(("philippe.roudot@gmail.com"
				 (:network-server . "talk.google.com")
				 (:connection-type . ssl))))


;; (setq org-default-notes-file (concat org-directory "~/notes.org"))

;; eshell
(require 'eshell)
(require 'em-smart)
(setq eshell-where-to-jump 'begin)
(setq eshell-review-quick-commands nil)
(setq eshell-smart-space-goes-to-end t)


;; (defun shell-compile ()
;;   (interactive)
;;   (shell-command (concat "python " (buffer-file-name))))

;; (add-hook 'python-mode-hook
;;           (lambda () (local-set-key (kbd "C-c C-c") 'shell-compile)))
;;(put 'viper-exit-minibuffer 'disabled nil)

(defun ccc ()
	"Compile and exec the standalone C program in current buffer."
	(interactive)
	(let ((x (shell-quote-argument (buffer-file-name))))
		(shell-command (concat "gcc -I../include -o " x ".exe " x " && " x ".exe"))))





`
(defun compile-tags ()
  "compile etags for the current project"
  (interactive)
  (cd "..")
  (compile "find . -name \"*.[chCH]pp\" -print | etags -"))

;; Matlab
(load-library "matlab-load")
 (autoload 'matlab-mode "matlab" "Matlab Editing Mode" t)
 (add-to-list
  'auto-mode-alist
  '("\\.m$" . matlab-mode))
 (setq matlab-indent-function t)
(setq matlab-shell-command "matlab_r2012a")
(setq matlab-shell-command-switches '("-nosplash" "-nodesktop"))
(defun my-matlab-mode-hook ()
  (setq fill-column 150))
(add-hook 'matlab-mode-hook 'my-matlab-mode-hook)
(normal-erase-is-backspace-mode 1)
(setq comint-scroll-show-maximum-output t)
(setq comint-move-point-for-output t)


;; Aspell

;; It works!  It works!  After two hours of slogging, it works!
(setq ispell-program-name "aspell")
(setq ispell-list-command "list")
(setq ispell-extra-args '("--sug-mode=ultra"))
;; (if (file-exists-p "/usr/local/bin/hunspell")
;;     (progn
;;       (setq ispell-program-name "hunspell")
;;       (eval-after-load "ispell"
;;        '(progn (defun ispell-get-coding-system () 'utf-8)))))
(defun count-words (start end)
    "Print number of words in the region."
    (interactive "r")
    (save-excursion
      (save-restriction
        (narrow-to-region start end)
        (goto-char (point-min))
        (count-matches "\\sw+"))))

;; Gnuplot
(autoload 'gnuplot-mode "gnuplot" "gnuplot major mode" t)
(autoload 'gnuplot-make-buffer "gnuplot" "open a buffer in gnuplot-mode" t)

(setq auto-mode-alist (append '(("\\.gp$" . gnuplot-mode))
			           auto-mode-alist))

;; (add-to-list 'default-frame-alist '(font . "monospace-9"))
;(put 'narrow-to-region 'disabled nil)
(put 'set-goal-column 'disabled nil)

(global-set-key (kbd "M-z") 'fastnav-sprint-forward)


;; Version control

(defun my-vc-dir-hide-some (states)
  "Hide files whose state is in STATES."
  (interactive
   (list
    (progn
      (unless vc-ewoc
        (error "Not in a vc-dir buffer"))
      (mapcar 'intern
              (completing-read-multiple
               "Hide files that are in state(s): "
               (let (possible-states)
                 (ewoc-map (lambda (item)
                             (let ((state (vc-dir-fileinfo->state item)))
                               (when state
                                 (pushnew state possible-states))
                               nil))
                           vc-ewoc)
                 (mapcar 'symbol-name possible-states))
               nil t)))))
  (let ((inhibit-read-only t))
    (ewoc-filter vc-ewoc
                 (lambda (file)
                   (not (memq (vc-dir-fileinfo->state file) states))))))
(eval-after-load "vc-dir"
  '(define-key vc-dir-mode-map "H" 'my-vc-dir-hide-some))

 (setq ring-bell-function 'ignore)


(setq outline-minor-mode-prefix "\C-c\C-o")


(put 'downcase-region 'disabled nil)



;; Vim emulation
;; (setq viper-mode t)
;; (require 'viper)
;; (require 'vimpulse)
;; (define-key viper-vi-global-user-map "]" 'end-of-defun)
;; (define-key viper-vi-global-user-map "[" 'beginning-of-defun)
;; ;; (define-key viper-vi-global-user-map "q" 'indent-region)
;; (define-key viper-vi-global-user-map "`" 'next-error)
;; (define-key viper-vi-global-user-map "Â§" 'viper-change-state-to-vi)
;; (define-key viper-vi-global-user-map "1" 'delete-other-windows-vertically)
;; (define-key viper-vi-global-user-map "2" 'split-window-vertically)
;; (define-key viper-vi-global-user-map "3" 'split-window-horizontally)
;; (define-key viper-vi-global-user-map "0" 'delete-window)
;; (define-key viper-vi-global-user-map (kbd "C-e") 'move-end-of-line)
;; (define-key viper-vi-global-user-map (kbd "SPC") 'recompile)
;; (define-key viper-insert-global-user-map "Â§" 'viper-change-state-to-vi)
;; (define-key viper-insert-global-user-map (kbd "C-n") 'next-line)
;; (define-key viper-insert-global-user-map (kbd "C-p") 'previous-line)
;; (vimpulse-map "k" 'previous-line)
;; (vimpulse-map "j" 'next-line)
;; (setq-default viper-auto-indent t							)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

