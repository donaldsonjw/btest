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

(module btest-btest
   (import btest-test
	   btest-suite)
   (export
      (test-root-suite)
      (test-add! #!key (suite::suite (test-root-suite))  test)
      (suite-add! #!key (suite::suite (test-root-suite)) subsuite)))


;;;; testing infrastructure extended and modified from the recette for Bigloo's
;;;; pthread library

;; the root suite for holding tests. It is used if no suite is specified
;; explicitly
(define +root-suite+ (instantiate::suite (description "root suite")
					 (tests '())
					 (subsuites '())))

;; exported function returning the root suite
(define (test-root-suite)
   +root-suite+)


;;;; convenience function for adding tests and suites

(define (test-add! #!key (suite::suite (test-root-suite)) test)
   (suite-add-test! suite test))

(define (suite-add! #!key (suite::suite (test-root-suite)) subsuite)
   (suite-add-subsuite! suite subsuite))

