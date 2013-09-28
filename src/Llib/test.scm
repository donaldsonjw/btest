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

(module btest-test
   (export
      (abstract-class test)
      (generic test-execute test::test)
      (generic test-run test::test)
      (generic test-expected test::test)
      (generic test-description test::test)))

;;;; test protocol

;; simply execute the test returning the result
(define-generic (test-execute test::test))

;; run the test returning an instance of test result
(define-generic (test-run test::test))

;; return the expected value of test
(define-generic (test-expected test::test))

;; return the test description
(define-generic (test-description test::test))

