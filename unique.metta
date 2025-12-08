
(= (member $x ($x $z)) True)
(= (member $x ($y $z)) (member $x $z))
(= (member $x ()) False)

(= (cons $x $y) ($x $y))

(= (unique ()) ())

(= (unique ($x $z))
   (let $tail (unique $z)
        (if (member $x $tail)
            $tail             
            (cons $x $tail)  
        )
   )
)
