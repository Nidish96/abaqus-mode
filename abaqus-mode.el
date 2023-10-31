;; abaqus.el
;; $Id: abaqus.el,v 1.5 2002/07/03 12:13:43 jorgen Exp $
;;
;; Author:   Jorgen S Bergstrom <jorgen@polymerFEM.com>
;; URL:      http://www.polymerFEM.com
;;
;; Modified by: James Lockley <safricanjames@yahoo.co.uk>
;;              Martin Lüthi
;; Modified by: Nidish Narayanaa Balaji <nidbid@gmail.com> (on 2020/08/14)
;;
;; Installation:
;;    add the following lines to your .emacs file:
;;
;;       ; abaqus
;;       (add-hook 'abaqus-mode-hook 'turn-on-font-lock)
;;       (autoload 'abaqus-mode "abaqus" "Enter abaqus mode." t)
;;
;;    copy this file the emacs site-lisp directory:
;;
;;       cp abaqus.el [path to emacs site-lisp directory]
(require 'outline)

(defvar abaqus-mode-hook nil)
(defvar abaqus-load-hook nil)

;; (setq outline-regexp "\b.*[A-Z]")

(add-hook 'abaqus-mode-hook 'outline-minor-mode)

(defvar abaqus-ruler "**..:....1....:....2....:....3....:....4....:....5....:....6....:....7....:....8"
  "*The ruler `abaqus-insert-ruler' inserts."
)

(defun abaqus-insert-ruler ()
  "Insert a ruler with comments."
  (interactive)
  (end-of-line)  
  (insert abaqus-ruler)
)

(defconst abaqus-font-lock-keywords
  (list
   '("^[*][*].*$" . font-lock-comment-face)
   '("^#.*$" . font-lock-comment-face)
   '("^\*[a-zA-Z].*[^a-zA-Z]" . font-lock-keyword-face)
   '("^[ \t]+$" . highlight)
  )
)

(defvar abaqus-comment-prefix "** "
  "*The comment `abaqus-insert-comment' inserts."
)

(defun abaqus-comment-region (beg end &optional arg)
  "Like `comment-region' but uses triple star (`***') comment starter."
  (interactive "r\nP")
  (beginning-of-line)
  (let ((comment-start abaqus-comment-prefix))
    (comment-region beg end arg)))


(defun abaqus-uncomment-region (beg end &optional arg)
  (interactive "r\nP")
  (beginning-of-line)
  (abaqus-comment-region (point) (mark) '(4)) (mark)
)


(defvar abaqus-mode-map ()
  "Keymap used in `abaqus-mode' buffers.")
(if abaqus-mode-map
    nil
  (setq abaqus-mode-map (make-sparse-keymap))
  (define-key abaqus-mode-map "\C-c \C-x c"     'abaqus-comment-region)
  (define-key abaqus-mode-map "\C-c \C-x u"     'abaqus-uncomment-region)
  (define-key abaqus-mode-map (kbd "TAB")       'outline-toggle-children)
)

(defun abaqus-mode ()
  "Major mode for editing ABAQUS files."
  (interactive)
  (setq mode-name "abaqus")
  (setq major-mode 'abaqus-mode
	mode-name              "Abaqus"
	font-lock-defaults     '(abaqus-font-lock-keywords)
	require-final-newline  t
	)
  (make-local-variable 'font-lock-defaults)
  (setq font-lock-defaults '(abaqus-font-lock-keywords))
  (run-hooks 'abaqus-mode-hook)
  (use-local-map abaqus-mode-map)
  (font-lock-flush)
  (font-lock-ensure))

(provide 'abaqus-mode)
(run-hooks 'abaqus-load-hook)
