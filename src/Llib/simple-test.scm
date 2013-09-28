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
      (class simple-test::test
	 description
	 expression
	 expected)))


;;;; simple-test implementation of test protocol
(define-method (test-expected test::simple-test)
   (-> test expected))

(define-method (test-execute test::simple-test)
   ((-> test expression)))
      

(define-method (test-run test::simple-test)
   (with-handler (lambda (e)
		    (instantiate::test-result
		       (test test)
		       (result #unspecified)
		       (exception e)))
		 (instantiate::test-result  (test test)
					    (result (test-execute test))
					    (exception #unspecified)
					    )))

(define-method (test-description test::simple-test)
   (-> test description))


	 