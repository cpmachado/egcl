(defpackage egcl
  (:use :cl)
  (:export :factor-to-egyptian))

(in-package :egcl)

(defun factor-to-egyptian (r &optional (i 0))
  "Factors r in Q: 0 < r < 1 into egyptian fractions"
  (if (or (<= r 0) (>= r 1) (not (rationalp r)))
      (values '() '() '())
    (let ((s (/ 1 (ceiling (/ 1 r)))))
      (multiple-value-bind
       (ls li lr) (factor-to-egyptian (- r s) (+ i 1))
       (Values (cons s ls) (cons i li) (cons r lr))))))
