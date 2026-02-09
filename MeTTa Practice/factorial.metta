(= (fact 0) 1)

(= (fact $n)
   (if (> $n 0)                
       (* $n (fact (- $n 1)))  
       (empty)                  
   )
)

! (fact 5)   
