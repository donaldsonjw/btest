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
      (abstract-class test-result
         test::test)
      (class test-success::test-result)
      (class test-failure::test-result
         reason)
      
      (generic test-result-success? tr::test-result)
      (generic test-result-failure? tr::test-result)))


;;;; test-result protocol and implementation

(define-generic (test-result-success? tr::test-result))

(define-method (test-result-success? tr::test-success)
   #t)

(define-method (test-result-success? tr::test-failure)
   #f)
   
(define-generic (test-result-failure? tr::test-result))

(define-method (test-result-failure? tr::test-success)
   #f)

(define-method (test-result-failure? tr::test-failure)
   #t)


