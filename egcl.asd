(defsystem "egcl"
  :version "0.0.1"
  :author "Carlos Pinto Machado <cpmachado@protonmail.com>"
  :license "MIT"
  :depends-on ()
  :components ((:file "egcl"))
  :description "Mathematics like the egyptians did it"
  :in-order-to ((test-op (test-op "egcl/tests"))))

(defsystem "egcl/tests"
  :author "Carlos Pinto Machado <cpmachado@protonmail.com>"
  :license "MIT"
  :depends-on ("egcl"
               "rove")
  :components ((:file "egcl-tests"))
  :description "Test system for egcl"
  :perform (test-op (op c) (symbol-call :rove :run c)))
