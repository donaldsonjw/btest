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

(module btest-suite-result
   (import btest-test
	   btest-suite
           btest-test-result)
   (export
      (class suite-result
	 suite::suite
	 test-results
	 subsuite-results)
      (successful-count s::suite-result)
      (test-count s::suite-result)
      (suite-result-successful? res::suite-result)))


(define-inline (fold f s lst)
   (if (pair? lst)
       (fold f (f (car lst) s) (cdr lst))
       s)) 

(define (successful-count s::suite-result)
   (let ((succ-count (fold (lambda (v s) (+ (if (test-result-success? v) 1 0) s))
                        0 (-> s test-results))))
      (+ succ-count
         (fold + 0 (map successful-count (-> s subsuite-results))))))

(define (test-count s::suite-result)
   (let ((c (length (-> s test-results))))
      (+ c (fold + 0 (map test-count (-> s subsuite-results))))))


(define (suite-result-successful? res::suite-result)
   (= (successful-count res) (test-count res)))













