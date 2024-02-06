(defpackage egcl/tests/main
  (:use :cl
        :egcl
        :rove))
(in-package :egcl/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :egcl)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))

(deftest test-multiplication
  (testing "should return 13 x 16 = 208"
    (multiple-value-bind
	  (m it) (multiplication 13 16)
      (ok (= 208 m))
      (ok (equal it '((t 1 16) (nil 2 32) (t 4 64) (t 8 128)))))))

(deftest test-division
  (testing "should return 587 / 94 = 6 + 23 / 94"
    (multiple-value-bind
	  (qr it) (division 587 94)
      (let ((q (first qr)) (r (second qr)))
	(ok (= 6 q))
	(ok (= 23 r))
	(ok (equal it '((nil 1 94) (t 2 188) (t 4 376))))))))
