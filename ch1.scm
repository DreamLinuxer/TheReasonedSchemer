(load "mkprelude.scm")

(run* (q)
      fail)
;; ()

(run* (q)
      (== #t q))
;; (#t)

(run* (q)
      fail
      (== #t q))
;; ()

(run* (q)
      succeed
      (== #t q))
;; (#t)

(run* (r)
      succeed
      (== 'corn r))
;; (corn)

(run* (r)
      fail
      (== 'corn r))
;; ()

(run* (q)
      succeed
      (== #f q))
;; (#f)

(run* (x)
      (let ((x #t))
	(== #f x)))
;; ()

(run* (q)
      (fresh (x)
	     (== #t x)
	     (== #t q)))
;; (#t)

(run* (q)
      (fresh (x)
	     (== x #t)
	     (== #t q)))
;; (#t)

(run* (q)
      (fresh (x)
	     (== x #t)
	     (== q #t)))
;; (#t)

(run* (x)
      succeed)
;; (_.0)

(run* (x)
      (let ((x #f))
	(fresh (x)
	       (== #t x))))
;; (_.0)

(run* (r)
      (fresh (x y)
	     (== (cons x (cons y '())) r)))
;; ((_.0 _.1))

(run* (s)
      (fresh (t u)
	     (== (cons t (cons u ())) s)))
;; ((_.0 _.1))

(run* (r)
      (fresh (x)
	     (let ((y x))
	       (fresh (x)
		      (== (cons y (cons x (cons y ()))) r)))))
;; ((_.0 _.1 _.0))

(run* (q)
      (== #f q)
      (== #t q))
;; ()

(run* (q)
      (== #f q)
      (== #f q))
;; (#f)

(run* (q)
      (let ((x q))
	(== #t x)))
;; (#t)

(run* (r)
      (fresh (x)
	     (== x r)))
;; (_.0)

(run* (q)
      (fresh (x)
	     (== #t x)
	     (== x q)))
;; (#t)

(run* (q)
      (fresh (x)
	     (== x q)
	     (== #t x)))
;; (#t)

(run* (q)
      (fresh (x)
	     (== (eq? x q) q)))
;; (#f)

(run* (q)
      (let ((x q))
	(fresh (q)
	       (== (eq? x q) x))))
;; (#f)

(cond
 (#f #t)
 (else #f))
;; #f

(run* (r)
      (cond
       (#f #t)
       (else fail)))
;; ()


(run* (r)
      (conde
       (fail succeed)
       (else fail)))
;; ()

(run* (r)
      (conde
       (fail fail)
       (else succeed)))
;; (_.0)

(run* (r)
      (conde
       (succeed succeed)
       (else fail)))
;; (_.0)

(run* (x)
      (conde
       ((== 'olive x) succeed)
       ((== 'oil x) succeed)
       (else fail)))
;; (olive oil)

(run 1 (x)
     (conde
      ((== 'olive x) succeed)
      ((== 'oil x) succeed)
      (else fail)))
;; (olive)

(run* (x)
      (conde
       ((== 'virgin x) fail)
       ((== 'olive x) succeed)
       (succeed succeed)
       ((== 'oil x) succeed)
       (else fail)))
;; (olive _.0 oil)

(run 2 (x)
     (conde
      ((== 'extra x) succeed)
      ((== 'virgin x) fail)
      ((== 'olive x) succeed)
      ((== 'oil x) succeed)
      (else fail)))
;; (extra olive)

(run* (r)
      (fresh (x y)
	     (== 'split x)
	     (== 'pea y)
	     (== (cons x (cons y '())) r)))
;; ((split pea))

(run* (r)
      (fresh
       (x y)
       (conde
	((== 'split x) (== 'pea y))
	((== 'navy x) (== 'bean y))
	(else fail))
       (== (cons x (cons y '())) r)))
;; ((split pea) (navy bean))

(run* (r)
      (fresh
       (x y)
       (conde
	((== 'split x) (== 'pea y))
	((== 'navy x) (== 'bean y))
	(else fail))
       (== (cons x (cons y (cons 'soup '()))) r)))
;; ((split pea soup) (navy bean soup))

(define teacupo
  (lambda (x)
    (conde
     ((== 'tea x) succeed)
     ((== 'cup x) succeed)
     (else fail))))

(run* (x)
      (teacupo x))
;; (tea cup)

(run* (r)
      (fresh
       (x y)
       (conde
	((teacupo x) (== #t y) succeed)
	((== #f x) (== #t y))
	(else fail))
       (== (cons x (cons y '())) r)))
;; ((tea #t) (cup #t) (#f #t))

(run* (r)
      (fresh
       (x y z)
       (conde
	((== y x)
	 (fresh (x) (== z x)))
	((fresh (x) (== y x))
	 (== z x))
	(else fail))
       (== (cons y (cons z '())) r)))
;; ((_.0 _.1) (_.0 _.1))

(run* (r)
      (fresh
       (x y z)
       (conde
	((== y x)
	 (fresh (x) (== z x)))
	((fresh (x) (== y x))
	 (== z x))
	(else fail))
       (== #f x)
       (== (cons y (cons z '())) r)))
;; ((#f _.0) (_.0 #f))

(run* (q)
      (let ((a (== #t q))
	    (b (== #f q)))
	b))
;; (#f)

(run* (q)
      (let ((a (== #t q))
	    (b (fresh (x)
		      (== x q)
		      (== #f x)))
	    (c (conde
		((== #t q) succeed)
		(else (== #f q)))))
	b))
;; (#f)
