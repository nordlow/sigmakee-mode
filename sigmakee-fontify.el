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

(defconst sigmakee-font-lock-prefix "\\b")
(defconst sigmakee-font-lock-keywords
  (let ()
    (list 

     ;; (list
     ;;  "^[^;]*\\(;.*\\)$" '(1 sigmakee-comment-face nil))

     (list 
      ;; (concat "^\s*[^;][^\n\r]*[\s\n\r(]\\b\\(and\\|or\\|not\\|exists\\|forall\\)\\b"
      (concat "\\b\\(and\\|or\\|not\\|exists\\|forall\\)\\b"
	      )
      '(1 'font-lock-builtin-face nil)
      )
     
     ;; KEYWORD
     (list 
      (concat sigmakee-font-lock-prefix "\\b\\("
              (mapconcat 'identity (list "instance"
                                         "subclass"
                                         "subrelation"
                                         "subProposition"
                                         "disjoint"
                                         "disjointRelation"
                                         "partition"
                                         "subAttribute"
                                         "valence"
                                         "domain"
                                         "domainSubclass"
                                         "range"
                                         "rangeSubclass"
                                         "format"
                                         "termFormat"
                                         "equal"
                                         "documentation")
                         "\\|")
              "\\)\\b" )
      '(1 font-lock-keyword-face nil) )

     ;; LOGICAL OPERATOR
     (list 
      ;; (concat "^\s*[^;][^\n\r]*[\s\n\r(]\\(=>\\|<=>\\)"
      (concat "\\(=>\\|<=>\\)")
      '(1 sigmakee-logical-operator-face nil)
      )

     ;; CONSTANTS
     (list 
      (concat sigmakee-font-lock-prefix "\\b\\([[:upper:]][[:lower:]]+Language\\)\\b" )
      '(1 font-lock-constant-face nil) )

     ;; VARIABLE
     (list 
      (concat "\\(\\?[_[:upper:][:lower:][:digit:]-]+\\)\\b"
	      )
      '(1 'font-lock-variable-ref-face nil)
      )

     ;; VARIABLE-LIST
     (list 
      (concat "\\(@[_[:upper:][:lower:][:digit:]-]+\\)\\b"
	      )
      '(1 'font-lock-variable-name-face nil)   ;TODO use `sigmakee-variable-list-face'
      )

     ;; FUNCTION
     (list 
      (concat
       sigmakee-font-lock-prefix "\\([[:upper:]][[:lower:]-][[:lower:][:upper:][:digit:]-]*Fn\\)\\b" )
      '(1 'font-lock-function-name-face nil) )

     ;; TYPE
     (list 
      (concat
       sigmakee-font-lock-prefix "\\([[:upper:]][[:lower:]-][[:lower:][:upper:][:digit:]-]*\\)\\b" )
      '(1 font-lock-type-face nil) )

     ;; NUMBER
     (list 
      (concat
       sigmakee-font-lock-prefix "\\([[:digit:]]+\\)\\b" )
      '(1 'font-lock-number-face nil) )

     ;; FUNCTION CALL
     (list 
      (concat
       sigmakee-font-lock-prefix "\\([[:lower:]][[:lower:][:upper:][:digit:]_-]+\\)\\b" )
      '(1 'font-lock-function-call-face nil) )

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
