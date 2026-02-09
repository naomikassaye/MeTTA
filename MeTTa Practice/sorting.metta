
(= (cons $x $y) ($x $y))

(= (insert $a ()) ($a))

(= (insert $a ($b $c))
   (if (< $a $b)
       (cons $a ($b $c))         
       (cons $b (insert $a $c))  
   )
)

(= (sort ()) ())

(= (sort ($x $r))
   (insert $x (sort $r)))


