#lang scheme
;A. The function foldr (“fold right”)
(define (foldright func seed lst)
  (if (null? lst)
      seed
      (func (car lst) (foldright func seed (cdr lst)))))

;B. a function paramreverse that takes a function F and a list of arguments AL and calls function F, passing the arguments to AL in reverse order
; function that reverses the list
(define (reverse lst)       
  (if(null? lst) 
     '()
     (append (reverse (cdr lst)) (list (car lst)))))
;main fucntion the calls the func with the parameters reversed.
(define (paramreverse func lst)
      (let ([revlst (reverse lst)])           
        (apply func revlst)))

;C. a function (highest L k) which takes a list of integers and an integer k > 0 as arguments and returns a new list containing the k highest numbers in the original list 
; Compare function that returns a lambda function to check if left is less than right
(define (compare)
  (lambda (left right) (if (> left right) left right)))

; max function that returns the max value of the list
(define (max lst) 
  (foldright (compare) 0 lst))

; add max function the accumulates the resultlist with k max values
(define (addmax lst resultlst k)
  (if (null? lst)
      '()
      (if (< (length resultlst) k)
          (addmax (remove (max lst) lst) (append resultlst (list (max lst))) k)          
          resultlst)))

; main highest function that returns k highest values of a list
(define (highest lst k)
  (let ([resultlst '()])
  (if (null? lst)
      '()
      (addmax lst resultlst k))))

;D. a function (mapfun FL L) that takes a list of functions FL and a list L and applies each element of FL to the corresponding element of L
(define (mapfun f l)
  (if (null? l) l
      (if (null? f) f
      (cons ((car f) (car l)) 
            (mapfun (cdr f) (cdr l))))))


;E. Write a function (filter pred L), where pred is a predicate and L is a list of atoms.
; Returns the function that checks for the predicate.
(define (checkpredicate pred)
  (lambda (x y) 
    (if (pred x) 
        (cons x y) 
        y)))

; main function that recursively checks the predicate.
(define (filter pred lst)
  (foldright (checkpredicate pred) '() lst))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(foldright + 2 '(1 2 3))
(paramreverse - '(3 2 1))
(filter odd? '(1 2 3 4))
(mapfun (list cadr car cdr) '((C D) (E F)))
(highest '(1 5 6 8 3 4) 4)
