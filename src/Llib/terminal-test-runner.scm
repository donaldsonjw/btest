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

(module btest-terminal-test-runner
   (import btest-test
	   btest-suite
           btest-test-result
	   btest-suite-result
	   btest-test-runner)
   (export
      (class terminal-test-runner::test-runner
	 suite)))


;;;; terminal-test-runner implementation of test-runner protocol

(define (display-test-results results #!optional (show-success? #f))
   (define (successful-count r)
      (let loop ((lst r)
		 (c 0))
	 (if (pair? lst)
	     (loop (cdr lst)
		(if (test-result-success? (car lst))
		    (+ c 1)
		    c))
	     c)))		 
   (for-each (lambda (r::test-result)
		(cond ((test-result-success? r)
		       (when show-success?
			  (print (test-description (-> r test)) "... ok.")))
		      (else
		       (display* (test-description (-> r test)) "...")
		       (print "error.")
		       (print " ==> provided: [" (-> r result)
			      "]\n     expected: [" (test-result-expected r)
			      "]"
			      (if (not (eq? (-> r exception)
					  #unspecified))
				  (format "~%     threw: [~a]~%"
				     (with-error-to-string
					(lambda ()
					   (error-notify (-> r exception)))))
				  "\n")))))
      results)
   (let* ((succ-count (successful-count results))
	 (count (length results))
	 (fail-count (- count succ-count)))
      (printf "~%Tests: ~a Succeeded: ~a Failed: ~a~%" count succ-count
	 fail-count)))
     
   
(define (display-suite-results results #!optional (show-success? #f))
   (for-each (lambda (s::suite-result)
		(print (-> s suite description) "\n")
		(display-test-results (-> s test-results) show-success?)
		(display-suite-results (-> s subsuite-results) show-success?))
      results))

(define-method (test-runner-execute tr::terminal-test-runner
		  show-success?::bool)
   (let* ((res::suite-result (suite-run (-> tr suite))))
      (display-suite-results (list res) show-success?)))
      
