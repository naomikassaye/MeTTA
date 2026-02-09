(= (cons $x $y) ($x $y))

(= (add () $y) $y)
(= (add ($h $t) $y) 
   (cons $h (add $t $y)))

(= (reverse ()) ())
(= (reverse ($h $t)) 
   (add (reverse $t) ($h)))

! (reverse (1 2 3 4))