(define (member? e lst)
  (cond
    [(empty? lst) #f]
    [(equal? (first lst) e) #t]
    [(member? e (rest lst))]
    [else #f]
  )
)

(define (set? lst)
  (cond
    [(empty? lst) #t]
    [(member? (first lst) (rest lst)) #f]
    [(set? (rest lst))]
    )
)

(define (union lst1 lst2)
  (cond
    [(empty? lst1) lst2]
    [(empty? lst2) lst1]
    [(not (member? (first lst1) lst2)) (union (rest lst1) (cons (first lst1) lst2))]
    [(member? (first lst1) lst2) (union (rest lst1) lst2)]
    )
)

(define (intersect lst1 lst2)
  (if (empty? lst1)
      '()
      (if (member? (first lst1) lst2)
          (cons (first lst1) (intersect (rest lst1) lst2))
          (intersect (rest lst1) lst2))
    )
)

(define (difference lst1 lst2)
  (if (empty? lst2)
      lst1
      (if (empty? lst1)
          '()
          (if (not (member? (first lst1) lst2))
              (cons (first lst1) (difference (rest lst1) lst2))
              (difference (rest lst1) lst2))
          )
    )
)

(define-namespace-anchor anc)
(define ns (namespace-anchor->namespace anc))
(let loop ()
  (define line (read-line (current-input-port) 'any))
  (if (eof-object? line)
    (display "")
    (begin (print (eval (read (open-input-string line)) ns)) (newline) (loop))))