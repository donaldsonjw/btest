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
      (generic suite-run suite::suite)))


;;;; suite protocol

;; add test to suite
(define-generic (suite-add-test! suite::suite test::test)
   (set! (-> suite tests) (cons test (-> suite tests))))

;; add a subsuite 
(define-generic (suite-add-subsuite! suite::suite subsuite::suite)
   (set! (-> suite subsuites) (cons subsuite (-> suite subsuites))))


(define-generic (suite-run suite::suite)
   (let ((test-results (map (lambda (t) (test-run t)) (-> suite tests)))
	 (suite-results (map (lambda (s) (suite-run s)) (-> suite subsuites))))
      (instantiate::suite-result (suite suite)
				 (test-results test-results)
				 (subsuite-results suite-results)))) 

