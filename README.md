# btest Readme


## Description

btest is a simple testing library implementing the testing interface used by the pthread library provided with Bigloo.

tests are defined with the `define-test` macro. It takes a test id, a test expression, and an expected result prefixed by the `:result` keyword. The result can be either a simple value (compared with equal? to the test expressions value) or a procedure of one argument returning a boolean indicating whether the test was successful or not. Additionally, if the the symbol `'result` is passed to the procedure it returns the expected value for the test expression. This value is used in communicating the results of the test. Here are a few simple examples.

  
`(define-test test-car
	(car '(1 2 3))
	:result 1)`

`(define-test test-empty-list
	(list)
	:result (lambda (v)
               (if (eq? v 'result)
				   "an empty list"
				   (null? v))))`


Tests are run with a test runner. The only available test runner at this time is the `terminal-test-runner`. An example of its use follows.


`(let ((tr (instantiate::terminal-test-runner)))
	(test-runner-execute tr #t))`


The second argument to `test-runner-execute` is a flag to indicate whether the results of successful tests are shown.


