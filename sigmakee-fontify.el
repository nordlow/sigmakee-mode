;;; sigmakee-fontify.el --- a part of the simple SigmaKEE mode

(defgroup sigmakee-faces nil "faces used for SigmaKEE mode"  :group 'faces)

(defvar in-xemacs-p "" nil)

;;; GNU requires that the face vars be defined and point to themselves

(defvar sigmakee-main-keyword-face 'sigmakee-main-keyword-face
  "Face to use for SigmaKEE relations.")
(defface sigmakee-main-keyword-face
  '((((class color)) (:foreground "red" :bold t)))
  "Font Lock mode face used to highlight class refs."
  :group 'sigmakee-faces)

(defvar sigmakee-function-nri-and-class-face 'sigmakee-function-nri-and-class-face
  "Face to use for SigmaKEE keywords.")
(defface sigmakee-function-nri-and-class-face
    (if in-xemacs-p
	'((((class color)) (:foreground "red"))
	  (t (:foreground "gray" :bold t)))
      ;; in GNU, no bold, so just use color
      '((((class color))(:foreground "red"))))
  "Font Lock mode face used to highlight property names."
  :group 'sigmakee-faces)

(defvar sigmakee-normal-face 'sigmakee-normal-face "regular face")
(defface sigmakee-normal-face
 '((t (:foreground "grey")))
 "Font Lock mode face used to highlight property names."
 :group 'sigmakee-faces)

(defvar sigmakee-string-face 'sigmakee-string-face "string face")
(defface sigmakee-string-face
    '((t (:foreground "green4")))
  "Font Lock mode face used to highlight strings."
  :group 'sigmakee-faces)

(defvar sigmakee-logical-operator-face 'sigmakee-logical-operator-face
  "Face to use for SigmaKEE logical operators (and, or, not, exists, forall, =>, <=>)")
;; same as function name face
(defface sigmakee-logical-operator-face
 '((((class color)) (:foreground "blue")))
  "Font Lock mode face used to highlight class names in class definitions."
  :group 'sigmakee-faces)

(defvar sigmakee-main-relation-face 'sigmakee-main-relation-face
  "Face to use for SigmaKEE relations.")
(defface sigmakee-main-relation-face
  '((((class color)) (:foreground "black" :bold t)))
  "Font Lock mode face used to highlight class refs."
  :group 'sigmakee-faces)

(defvar sigmakee-relation-face 'sigmakee-relation-face
  "Face to use for SigmaKEE relations.")
(defface sigmakee-relation-face
  '((((class color)) (:foreground "darkgrey")))
  "Font Lock mode face used to highlight class refs."
  :group 'sigmakee-faces)

;; (defvar sigmakee-property-face 'sigmakee-property-face
;;   "Face to use for SigmaKEE property names in property definitions.")
;; (defface sigmakee-property-face
;;   (if in-xemacs-p
;;      '((((class color)) (:foreground "darkviolet" :bold t))
;;        (t (:italic t)))
;;     ;; in gnu, just magenta
;;     '((((class color)) (:foreground "darkviolet"))))
;;      "Font Lock mode face used to highlight property names."
;;      :group 'sigmakee-faces)

(defvar sigmakee-variable-face 'sigmakee-variable-face
  "Face to use for SigmaKEE property name references.")
(defface sigmakee-variable-face
  '((((class color)) (:foreground "darkviolet" ))
    (t (:italic t)))
  "Font Lock mode face used to highlight property refs."
  :group 'sigmakee-faces)

(defvar sigmakee-comment-face 'sigmakee-comment-face
  "Face to use for SigmaKEE comments.")
(defface sigmakee-comment-face
  '((((class color) ) (:foreground "red" :italic t))
    (t (:foreground "DimGray" :italic t)))
  "Font Lock mode face used to highlight comments."
  :group 'sigmakee-faces)

(defvar sigmakee-other-face 'sigmakee-other-face
  "Face to use for other keywords.")
(defface sigmakee-other-face
  '((((class color)) (:foreground "peru")))
  "Font Lock mode face used to highlight other SigmaKEE keyword."
  :group 'sigmakee-faces)

;; (defvar sigmakee-tag-face 'sigmakee-tag-face
;;   "Face to use for tags.")
;; (defface sigmakee-tag-face
;;     '((((class color)) (:foreground "violetred" ))
;;       (t (:foreground "black")))
;;   "Font Lock mode face used to highlight other untyped tags."
;;   :group 'sigmakee-faces)

;; (defvar sigmakee-substitution-face 'sigmakee-substitution-face "face to use for substitution strings")
;; (defface sigmakee-substitution-face
;;     '((((class color)) (:foreground "orangered"))
;;       (t (:foreground "lightgrey")))
;;   "Face to use for SigmaKEE substitutions"
;;   :group 'sigmakee-faces)


;;;================================================================
;;; these are the regexp matches for highlighting SigmaKEE

(defconst sigmakee-keyword-regexp
  (rx symbol-start (group (| "and" "or" "not" "exists" "forall")) symbol-end)
  "SigmaKEE keyword regexp.")

(defconst sigmakee-predicate-regexp
  (rx symbol-start (group lower (+ (in lower upper digit "-"))) symbol-end)
  "SigmaKEE predicate regexp.")

(defconst sigmakee-function-regexp
  (rx symbol-start (group upper (+ (in lower upper digit "-")) "Fn") symbol-end)
  "SigmaKEE function regexp.")

(defconst sigmakee-type-regexp
  (rx symbol-start (group upper (+ (in lower upper digit "-"))) symbol-end)
  "SigmaKEE type regexp.")

(defconst sigmakee-variable-regexp
  (rx (group "?") (group (+ (in "_" upper lower digit "-"))) symbol-end)
  "SigmaKEE variable regexp.")

(defconst sigmakee-variable-list-regexp
  (rx (group "@") (group (+ (in "_" upper lower digit "-"))) symbol-end)
  "SigmaKEE variable list regexp.")

(defconst sigmakee-number-regexp
  (rx symbol-start (group (+ digit)) symbol-end)
  "SigmaKEE number regexp.")

(defconst sigmakee-symbol-regexp
  (rx symbol-start (group (+ (in lower upper digit "-"))) symbol-end)
  "SigmaKEE symbol regexp.")

(defconst sigmakee-font-lock-keywords
  (let ()
    (list

     ;; (list
     ;;  "^[^;]*\\(;.*\\)$" '(1 sigmakee-comment-face nil))

     ;; KEYWORDS
     (list
      sigmakee-keyword-regexp
      '(1 'font-lock-keyword-face nil))

     ;; PREDICATE DEFINITION
     (list
      (rx bol "(" (group (| "instance"
                            "subclass"
                            "subrelation"
                            "documentation"
                            "domain"
                            "valence"
                            "relatedInternalConcept"))
          (+ space)
          (regexp sigmakee-predicate-regexp)
          )
      '(1 'font-lock-builtin-ref-face nil)
      '(2 'font-lock-builtin-face nil))

     ;; FUNCTION DEFINITION
     (list
      (rx bol "(" (group (| "instance"
                            "subrelation"
                            "documentation"
                            "domain"
                            "range"
                            "rangeSubclass"
                            "relatedInternalConcept"))
          (+ space)
          (regexp sigmakee-function-regexp)
          )
      '(1 'font-lock-builtin-ref-face nil)
      '(2 'font-lock-function-name-face nil))

     ;; TYPE DEFINITION
     (list
      (rx bol "(" (group (| "subclass"
                            "instance"
                            "subrelation"
                            "subProposition"
                            "subAttribute"
                            "exhaustiveAttribute"
                            "contraryAttribute"
                            "exhaustiveDecomposition"
                            "disjoint"
                            "disjointDecomposition"
                            "partition"
                            "documentation"
                            "lexicon"))
          (+ space)
          (regexp sigmakee-type-regexp)
          )
      '(1 'font-lock-builtin-ref-face nil)
      '(2 'font-lock-type-definition-face nil))

     ;; TYPE-TYPE DEFINITION
     (list
      (rx bol "(" (group (| "disjoint"))
          (+ space)
          (regexp sigmakee-type-regexp)
          (+ space)
          (regexp sigmakee-type-regexp)
          )
      '(1 'font-lock-builtin-ref-face nil)
      '(2 'font-lock-type-definition-face nil)
      '(3 'font-lock-type-definition-face nil))

     ;; FORMAT FUNCTION
     (list
      (rx bol "(" (group (| "format"
                            "termFormat"))
          (+ space)
          (regexp sigmakee-symbol-regexp)
          (+ space)
          (regexp sigmakee-function-regexp)
          )
      '(1 'font-lock-builtin-ref-face nil)
      '(2 'font-lock-type-definition-face nil)
      '(3 'font-lock-function-name-face nil))

     ;; FORMAT TYPE
     (list
      (rx bol "(" (group (| "format"
                            "termFormat"))
          (+ space)
          (regexp sigmakee-symbol-regexp)
          (+ space)
          (regexp sigmakee-type-regexp)
          )
      '(1 'font-lock-builtin-ref-face nil)
      '(2 'font-lock-type-definition-face nil)
      '(3 'font-lock-type-definition-face nil))

     ;; FORMAT PREDICATE
     (list
      (rx bol "(" (group (| "format"
                            "termFormat"))
          (+ space)
          (regexp sigmakee-symbol-regexp)
          (+ space)
          (regexp sigmakee-predicate-regexp)
          )
      '(1 'font-lock-builtin-ref-face nil)
      '(2 'font-lock-type-definition-face nil)
      '(3 'font-lock-builtin-face nil))

     ;; LOGICAL OPERATOR
     (list
      (rx (group (| "=>" "<=>")))
      '(1 sigmakee-logical-operator-face nil)
      )

     ;; VARIABLE
     (list
      sigmakee-variable-regexp
      '(1 'font-lock-private-variable-face nil)
      '(2 'font-lock-variable-ref-face nil)
      )

     ;; VARIABLE-LIST
     (list
      sigmakee-variable-list-regexp
      '(1 'font-lock-private-variable-face nil)
      '(2 'font-lock-variable-ref-face nil)
      )

     ;; NUMBER
     (list
      sigmakee-number-regexp
      '(1 'font-lock-number-face nil))

     ;; FUNCTION CALL
     (list
      sigmakee-function-regexp
      '(1 'font-lock-function-call-face nil))

     ;; PREDICATE CALL
     (list
      sigmakee-predicate-regexp
      '(1 'font-lock-builtin-ref-face nil))

     ;; TYPE
     (list
      sigmakee-type-regexp
      '(1 font-lock-type-face nil))

     ;; OTHER
     (list
      (concat "\\(\\&\\%[_[:upper:][:lower:][:digit:]-]+\\)\\b"
	      )
      '(1 sigmakee-other-face nil)
      )

     ;; black for the def parts of PROPERTY DEFINITION
     ;; and of TransitiveProperty UnambiguousProperty UniqueProperty
;;; END OF LIST ELTS
     ))

  "Additional expressions to highlight in SigmaKEE mode.")

(put 'sigmakee-mode 'font-lock-defaults '(sigmakee-font-lock-keywords nil nil))

(defun re-font-lock () (interactive) (font-lock-mode 0) (font-lock-mode 1))

(provide 'sigmakee-fontify)
