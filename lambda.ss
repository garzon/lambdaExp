#lang scheme

; common algorithms
(define reduce (lambda(f init list)
  (if
   (null? list)
   init
   (reduce f (f init (car list)) (cdr list))
  )
))

(define op-wrapper
  (lambda(operator)
    (lambda(init . list)
      (reduce
       (lambda(init next) (operator init next))
       init list))))

; basic definition of natural number 0
(define zero
  (lambda(f)
    (lambda(x) x)))

; basic definition of the successor of a number
(define succ
  (lambda(num)
    (lambda(f)
      (lambda(x) (f ((num f) x))))))

; basic definition of the operators of a number
(define _add
  (lambda(a b)
    (lambda(f)
      (lambda(x) ((a f) ((b f) x))))))

(define _mul
  (lambda(a b)
    (lambda(f) (a (b f)))))

(define pow (lambda(a b) (b a)))

; wrap the operators
(define mul (op-wrapper _mul))
(define add (op-wrapper _add))    

; useful tools, just for input and output only
(define num->text
  (lambda(num)
    (if (= num 0) 
      zero
      (succ (num->text (- num 1))))))

(define text->num
  (lambda(text)
    (define inc
      (lambda(num) (+ num 1)))
    ((text inc) 0)))

; tests
(text->num 
 (pow
  (num->text 2) 
  (num->text 10))) ; => 2^10 = 1024

(text->num 
 (mul
  (num->text 3) 
  (num->text 5)
  (num->text 2))) ; => 2*3*5 = 30

(text->num 
 (add
  (num->text 7) 
  (num->text 4)
  (num->text 8))) ; => 7+4+8 = 19

(text->num 
 (pow
  (mul
   (add
    (num->text 1) 
    (succ zero)
    (num->text 3))
   (succ zero)
   (num->text 2))
  (num->text 2))) ; => ((1+1+3)*(0+1)*2)^2 = 100