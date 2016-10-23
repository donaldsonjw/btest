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

(module btest-suite
   (import btest-test
	   btest-suite-result)
   (export
      (class suite
	 description
	 tests
	 subsuites)
      (generic suite-add-test! suite::suite test::test)
      (generic suite-add-subsuite! suite::suite subsuite::suite)
      (generic suite-run suite::suite
	 test-result-handler::procedure
	 suite-result-handler::procedure)))


;;;; suite protocol

;; add test to suite
(define-generic (suite-add-test! suite::suite test::test)
   (set! (-> suite tests) (cons test (-> suite tests))))

;; add a subsuite 
(define-generic (suite-add-subsuite! suite::suite subsuite::suite)
   (set! (-> suite subsuites) (cons subsuite (-> suite subsuites))))


(define-generic (suite-run suite::suite
		   test-result-handler::procedure
		   suite-result-handler::procedure)
   (let ((test-results (map (lambda (t)
			       (let ((res (test-run t)))
				     (test-result-handler res)
				     res))
			  (reverse (-> suite tests))))
	 (suite-results (map (lambda (s)
				(let ((res (suite-run s
					      test-result-handler
					      suite-result-handler)))
				   #;(suite-result-handler res)
				   res))
				(reverse (-> suite subsuites)))))
      (let ((res (instantiate::suite-result (suite suite)
					    (test-results test-results)
					    (subsuite-results suite-results))))
	 (suite-result-handler res)
	 res)))

