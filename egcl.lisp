(defpackage egcl
  (:use :cl)
  (:export :multiplication :division :factor-unit-fractions))
(in-package :egcl)

(defun naturalp (n)
  "Predicate to verify if it's a natural number"
  (and (integerp n) (> n 0)))


(defun double (n p)
  (loop for i = 1 then (* i 2)
	for n2 = n then (* n i)
	until (funcall p (list i n2))
	collect (list i n2)))

(defun arithmetic-reducer (p qu ru)
  (lambda (acc curr)
    (let ((q (first acc))
	  (r (second acc))
	  (l (third acc)))
      (let ((pv (funcall p acc curr)))
	(let ((nl (cons (cons pv curr) l)))
	  (if pv
	      (list (funcall qu q curr) (funcall ru r curr) nl)
	      (list q r nl)))))))

(defun multiplication (m n)
  "Multiplication computes m x n, and returns iterations"
  (when (and (naturalp m) (naturalp n))
    (let ((doubles-list (double n (lambda (l) (> (first l) m)))))
      (let ((res (reduce
		  (arithmetic-reducer
		   (lambda (acc curr) (let ((q (first acc)) (m (first curr))) (>= q m)))
		   (lambda (q curr) (let ((m (first curr))) (- q m)))
		   (lambda (r curr) (let ((v (second curr))) (+ r v))))
		  (reverse doubles-list)
		  :initial-value (list m 0 nil))))
	(values (second res) (third res))))))

(defun division (n d)
  "Integer division of naturals n and d"
  (when (and (naturalp n) (naturalp d))
    (let ((doubles-list (double d (lambda (l) (> (second l) n)))))
      (let ((res
	     (reduce
	      (arithmetic-reducer
	       (lambda (acc curr) (let ((r (second acc)) (v (second curr))) (>= r v)))
	       (lambda (q curr) (let ((m (first curr))) (+ q m)))
	       (lambda (r curr) (let ((v (second curr))) (- r v))))
	      (reverse doubles-list)
	      :initial-value (list 0 n nil))))
	(values (list (first res) (second res)) (third res))))))

(defun factor-unit-fractions (r &optional (k 0))
  "Factor rational r: 0 < r < 1 into unitary fractions"
  (when (and (> r 0) (<= r 1) (rationalp r))
    (let ((nk (ceiling 1 r))
          (kp (+ k 1)))
      (let ((rk (- r (/ 1 nk))))
	(multiple-value-bind (nl itl) (factor-unit-fractions rk kp)
	  (values (cons (/ 1 nk) nl) (cons (list kp rk nk (/ 1 nk)) itl)))))))
