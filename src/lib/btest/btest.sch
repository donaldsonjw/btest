;;;; Copyright(c) 2013, 2024 Joseph Donaldson(donaldsonjw@yahoo.com) 
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
;;;;     License along with collections.  If not, see
;;;;     <http://www.gnu.org/licenses/>.


(define-macro (define-test desc prgm . rest)
   (match-case rest
      ((:result ?result)
       `(test-add! :test (instantiate::simple-test
			    (description ',desc)
			    (expression (lambda () (assert-equal? ,prgm ,result))))))
      (()
       `(test-add! :test (instantiate::simple-test
			    (description ',desc)
			    (expression (lambda () ,prgm)))))
      (else
       (error "define-test" "Illegal rest argument" rest))))



   (define-macro (assert-predicate predicate exp val)
      `(let ((r ,exp)
             (v ,val)
             (pred ,predicate))
          (if (pred r v)
              #t
              (raise-assertion-failure reason: (format "provided: [~a] expected: [~a]" r v)))))

(define-macro (assert-eq? exp val)
  `(assert-predicate eq? ,exp ,val))

(define-macro (assert-eqv? exp val)
  `(assert-predicate eqv? ,exp ,val))

(define-macro (assert-equal? exp val)
  `(assert-predicate equal? ,exp ,val))

(define-macro (assert= exp val)
   `(assert-predicate = ,exp ,val))

(define-macro (assert-true exp)
   `(assert-predicate (lambda (v x) (if v #t)) ,exp #t))

(define-macro (assert-false exp)
   `(assert-predicate eq? ,exp #f))

(define-macro (assert-exception-thrown exp exception)
   `(with-handler (lambda (e)
                     (if (isa? e ,exception)
                         #t
                         (raise-assertion-failure reason: (format "threw unexpected exception: [~a]~%"
                                                             (with-error-to-string (lambda ()
                                                                                      (error-notify e)))))))
                  (let ((res ,exp))
                     (raise-assertion-failure reason: (format "failed to throw expected exception: [~a]" ,exception)))))
          
(define-macro (test desc . exps)
   `(test-add! :suite *current-test-suite* :test
       (instantiate::simple-test (description ,desc)
                                 (expression (lambda () (begin ,@exps ))))))

(define-expander define-test-suite
   (lambda (x e)
      (match-case x
         ((?- ?id)
          (e `(define ,id
                 (instantiate::suite (description ',id)
                                     (tests '())
                                     (subsuites '()))) e))
         
         ((?- ?id . ?exp)
          (e `(define ,id
                 (let ((*current-test-suite*
                          (instantiate::suite (description ',id)
                                              (tests '())
                                              (subsuites '()))))
                    ,@(e exp e) *current-test-suite*)) e))
         (else
	  (error "define-test-suite" "invalid form" x)))))
