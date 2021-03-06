# btest Readme


## Description

btest is a simple testing library implementing two interfaces. The first duplicates the testing interface used by the pthread library provided with Bigloo. The second is slightly more complicated but provides more flexibility by allowing the definition of mulitple test suites. We describe both below.

In the interface duplicating the pthread testing interface, tests are defined with the `define-test` macro. It takes a test id, a test expression, and an expected result prefixed by the `:result` keyword. The result can be either a simple value (compared with equal? to the test expressions value) or a procedure of one argument returning a boolean indicating whether the test was successful or not. Additionally, if the the symbol `'result` is passed to the procedure it returns the expected value for the test expression. This value is used in communicating the results of the test. Here are a few simple examples.

  
`(define-test test-car
	(car '(1 2 3))
	:result 1)`

`(define-test test-empty-list
	(list)
	:result (lambda (v)
               (if (eq? v 'result)
				   "an empty list"
				   (null? v))))`


The second interface has two primary macros, `define-test-suite` and `test`. `define-test-suite` has the form `(define-test-suite id . body)` where `id` is a symbol naming the test suite and `body` is a, possibly empty, list of test expressions. The `test` macro introduces a test. It has the form `(test description exp)` where `description` is usually a short string describing the test and `exp` is an assertion containing expression. Currently there are 7 assertion macros:

`assert-eq?`
`assert-eqv?`
`assert-equal?`
`assert=`
`assert-true`
`assert-false`
`assert-exception-thrown`
`assert-predicate`

The first four take an expression and an expected value and compare the expression result with `eq?`, `eqv?`, `equal?`, or `=` , respectively. `assert-true` and `assert-false` take a single expression and check if it is true or false. `assert-exception-thrown` takes an expression and the symbol of the exception class. The assertion is true if the exception is thrown, otherwise false. The final assertion macro is `assert-predicate` it takes a binary predicate, an expression, and an expected value. If the predicate returns true when given the evaluated value of expression and the expected value the assertion is true, otherwise false. `assert-predicate` is useful for testing arbitrary properties. A simple example of `define-test-suite` and `test` follow:

`(define-test-suite my-suite
   (let ((lst1 '(1 2 3)))

      (test "throws error exception"
	 (assert-exception-thrown  (raise 5);(error "a" "b" "c")
	    &error))
      
      (test "car of (1 2 3) = 1"
	 (assert= (car lst1) 1))
      
      (test "car of (1 2 3) != 2"
	 (assert-false (= (car lst1) 2)))
      ))

`



For both interfaces, tests are run with a test runner. The only available test runner at this time is the `terminal-test-runner`. For the first interface, the following will run all of the tests.


`(let ((tr (instantiate::terminal-test-runner)))
	(test-runner-execute tr #t))`

For the second interface, you must provide the test suite when instantiating `terminal-test-runner`.

`(let ((tr (instantiate::terminal-test-runner (suite my-suite)))
	(test-runner-execute tr #t))`

The second argument to `test-runner-execute` is a flag to indicate whether the results of successful tests are shown.

Here is example console output.

    [jwd]$ ./recette/testbtest 
    throws error exception... ok.
    car of (1 2 3) = 1... ok.
    car of (1 2 3) != 2... ok.
    
    my-suite
     Tests: 3 Succeeded: 3 Failed: 0



