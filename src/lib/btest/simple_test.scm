;;;; Copyright(c) 2013 Joseph Donaldson(donaldsonjw@yahoo.com) 
;;;; This file is part of btest.
;;;;
;;;;     btest is free software: you can redistribute it and/or modify
;;;;     it under the terms of the GNU Lesser General Public License as
;;;;     published by the Free Software Foundation, either version 3 of the
;;;;     License, or (at your option) any later version.
;;;;
;;;;     btest is distributed in the hope that it will be useful, but
;;;;     WITHOUT ANY WARRANTY; without even the implied warranty of
;;;;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;;;     Lesser General Public License for more details.
;;;;
;;;;     You should have received a copy of the GNU Lesser General Public
;;;;     License along with btest.  If not, see
;;;;     <http://www.gnu.org/licenses/>.

(module btest-simple-test
   (import btest-test
	   btest-test-result)
   (export
      (class &assertion-failure::&exception
         reason)
      (class simple-test::test
	 description
	 expression)
      (raise-assertion-failure #!key reason)))


(define (raise-assertion-failure #!key reason)
   (raise (instantiate::&assertion-failure (reason reason))))

;;;; simple-test implementation of test protocol

(define-method (test-execute test::simple-test)
   ((-> test expression)))
      

(define-method (test-run test::simple-test)
   (with-handler (lambda (e)
                    (if (isa? e &assertion-failure)
                        (let ((failure::&assertion-failure e))
                           (instantiate::test-failure
                              (test test)
                              (reason (-> failure reason))))
                        (instantiate::test-failure
                           (test test)
                           (reason (format "unexpected exception: ~a" e)))))
                 (test-execute test)
                 (instantiate::test-success (test test))))

(define-method (test-description test::simple-test)
   (-> test description))


	 