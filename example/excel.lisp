(eval-when (:compile-toplevel :load-toplevel :execute)
  (asdf:oos 'asdf:load-op :cl-win32ole)
  (use-package :cl-win32ole))

(defun excel-example1 ()
  (let ((ex (create-object "Excel.Application")))
    (with-slots (visible workbooks) ex
      (setf visible t)
      (let ((book (ole workbooks :add)))
        (let ((sheets (slot-value book 'worksheets)))
          (print (slot-value sheets 'count))
          (let ((sheet (ole sheets :item 1)))
            (print sheet)
            (setf (slot-value (ole sheet :range "A1:C3") 'value)
                  `(("Noth" "South" "Quis")
                    (5.2 10 300)
                    (0 ,(dt:make-date 1973 4 26)
                       ,(dt:make-date-time 2009 3 25 21 25 34 123))))
            (let ((range (ole sheet :range "A1:C3")))
              (print (slot-value range 'value)))))
        (setf (slot-value book 'saved) t)))
    (ole ex :quit)))

(excel-example1)