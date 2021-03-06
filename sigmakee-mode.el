(let ((dir "/var/lib/myfrdcsa/codebases/minor/sigmakee-mode"))
  (if (file-exists-p dir)
      (setq load-path
            (cons dir load-path))))

(add-to-list 'auto-mode-alist '("\\.kif\\'" . sigmakee-mode))

(require 'sigmakee-terms)
(require 'sigmakee-fontify)
(if (featurep 'freekbs2)
    (require 'sigmakee-freekbs2))

(define-derived-mode sigmakee-mode
  emacs-lisp-mode "SigmaKEE"
  "Major mode for Sigma Knowledge Engineering Environment.
\\{sigmakee-mode-map}"
  (define-key sigmakee-mode-map (kbd "TAB") 'sigmakee-mode-complete-or-tab)
  (define-key sigmakee-mode-map "\C-csl" 'sigmakee-mode-load-assertion-into-stack)
  (define-key sigmakee-mode-map "\C-csL" 'sigmakee-mode-print-assertion-from-stack)

  ;; (suppress-keymap sigmakee-mode-map)

  (make-local-variable 'font-lock-defaults)
  (setq font-lock-defaults '(sigmakee-font-lock-keywords nil nil))
  (re-font-lock)
  )

(defun sigmakee-mode-complete-or-tab (&optional arg)
  ""
  (interactive "P")
  (unwind-protect
      (condition-case nil
          (sigmakee-mode-complete))
    (indent-for-tab-command arg)))

(defun sigmakee-mode-complete (&optional predicate)
  "Perform completion on SigmaKEE symbol preceding point.
Compare that symbol against the known SigmaKEE symbols.

When called from a program, optional arg PREDICATE is a predicate
determining which symbols are considered, e.g. `commandp'.
If PREDICATE is nil, the context determines which symbols are
considered.  If the symbol starts just after an open-parenthesis, only
symbols with function definitions are considered.  Otherwise, all
this-command-keyssymbols with function definitions, values or properties are
considered."
  (interactive)
  (let* ((end (point))
	 (beg (with-syntax-table emacs-lisp-mode-syntax-table
	        (save-excursion
	          (backward-sexp 1)
	          (while (or
		          (= (char-syntax (following-char)) ?\')
		          (char-equal (following-char) ?\$)
		          (char-equal (following-char) ?\#))
		    (forward-char 1))
	          (point))))
	 (pattern (buffer-substring-no-properties beg end))
	 ;; (sigmakee-output
	 ;;  (sigmakee-query
	 ;;   (concat "(constant-complete " "\"" pattern "\")\n")))
	 ;; (completions
	 ;;  (cm-convert-string-to-alist-of-strings
	 ;;   (progn
	 ;;    (string-match "(\\([^\)]*\\))" ; get this from Cyc and format it into an alist
	 ;;     cm-cyc-output)
	 ;;    (match-string 1 cm-cyc-output))))
	 (completions
	  sigmakee-mode-all-terms)
	 (completion (try-completion pattern completions)))
    (cond ((eq completion t))
          ((null completion)
           (error "Can't find completion for \"%s\"" pattern)
           )
          ((not (string= pattern completion))
           (delete-region beg end)
           (insert completion))
          (t
           ;; (message "Making completion list...")
           ;; (let ((list (all-completions pattern completions)))
           ;;  (setq list (sort list 'string<))
           ;;  (with-output-to-temp-buffer "*Completions*"
           ;;   (display-completion-list list)))
           ;; (message "Making completion list...%s" "done")
           (let*
               ((expansion (completing-read "Term: "
		                            (all-completions pattern completions) nil nil pattern))
                (regex (concat pattern "\\(.+\\)")))

             (string-match regex expansion)
             (insert (match-string 1 expansion)))))))

(provide 'sigmakee-mode)
