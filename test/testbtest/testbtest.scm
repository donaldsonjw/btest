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

(module testbtest
   (library btest))


(define-test "car of (1 2 3) should be 1"
   (car '(1 2 3))
   :result 1)

(define-test test-it
   (list 1 2 3)
   :result (lambda (x) (number? x)))

(define-test another-test
   3)


(define-test-suite my-suite
   (let ((lst1 '(1 2 3)))

      (test "throws error exception"
	 (assert-exception-thrown  (error "a" "b" "c")
	    &error))
      
      (test "car of (1 2 3) = 1" 
         (assert= (car lst1) 1)
         (assert= (car lst1) 1))
      
      (test "car of (1 2 3) != 2"
	 (assert-false (= (car lst1) 2)))
      ))


(let ((tr (instantiate::terminal-test-runner (suite my-suite))))
   (test-runner-execute tr #t))

