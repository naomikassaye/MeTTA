(= (cons $x $y) ($x $y))

(= (add () $y) $y)
(= (add ($h $t) $y) 
   (cons $h (add $t $y)))

(= (reverse ()) ())
(= (reverse ($h $t)) 
   (add (reverse $t) ($h)))

(= (palindrome $list)
   (== $list (reverse $list)))

! (palindrome (e y e))
! (palindrome (n a o m i))