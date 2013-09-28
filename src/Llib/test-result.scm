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

(module btest-test-result
   (import btest-test)
   (export
      (class test-result
	 test::test
	 exception
	 result)
      (generic test-result-success? tr::test-result)
      (generic test-result-failure? tr::test-result)
      (generic test-result-expected tr::test-result)))


;;;; test-result protocol and implementation

(define-generic (test-result-success? tr::test-result)
   (or (and (eq? (-> tr result) #unspecified)
	    (eq? (-> tr exception) #unspecified))
       (equal? (-> tr result) (test-expected (-> tr test)))
       (and (procedure? (test-expected (-> tr test)))
	    ((test-expected (-> tr test)) (-> tr result)))))

(define-generic (test-result-failure? tr::test-result)
   (not (test-result-success? tr)))

(define-generic (test-result-expected tr::test-result)
   (if (procedure? (test-expected (-> tr test)))
       ((test-expected (-> tr test)) 'result)
       (test-expected (-> tr test))))


