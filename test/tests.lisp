(in-package #:trivial-backtrace-test)

(deftestsuite generates-backtrace (trivial-backtrace-test)
  ())

(defmacro with-error-output ((condition-variable) &body body)
  `(handler-case
       (let ((x 1))
	 (let ((y (- x (expt 1024 0))))
	   (declare (optimize (safety 3)))
	   (/ 2 y)))
     (error (,condition-variable)
       (setf output (progn ,@body)))))

(addtest (generates-backtrace)
  test-1
  (let ((output nil))

    (with-error-output (c)
      (print-backtrace c :output nil))

    (ensure (stringp output))
    (ensure (plusp (length output)))))


(addtest (backtrace-string)
  test-2
  (let ((output nil))

    (with-error-output (c)
      (backtrace-string c))

    (ensure (stringp output))))
