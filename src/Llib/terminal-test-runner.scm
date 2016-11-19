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
	   btest-test-runner
	   btest-btest)
   (export
      (class terminal-test-runner::test-runner
	 (suite (default (test-root-suite))))))


;;;; terminal-test-runner implementation of test-runner protocol

(define (display-test-result result #!optional (show-success? #f))
  (let ((r::test-result result))
     (if (test-result-success? r)
         (when show-success?
            (print (test-description (-> r test)) "... ok."))
         (let ((failure::test-failure r))
            (display* (test-description (-> r test)) "...")
            (print "error.")
            (print " ==> " (-> failure reason))) 
         )))

         
(define (display-suite-result result #!optional (show-success? #f))
   (let ((s::suite-result result))
      (let* ((succ-count (successful-count s))
	     (count (test-count s))
             (fail-count (- count succ-count)))
         (printf "~%~a~% Tests: ~a Succeeded: ~a Failed: ~a~%"
            (-> s suite description) count succ-count fail-count))))


(define-method (test-runner-execute tr::terminal-test-runner
		  show-success?::bool)
   (suite-result-successful? (suite-run (-> tr suite)
                                (lambda (tr) (display-test-result tr show-success?))
                                (lambda (sr) (display-suite-result sr show-success?)))))
      


