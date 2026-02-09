(= (count ()) 0)
(= (count ($x $y)) (+1(count $rest)))

(= (countall ())0)
(= (countall ($a $b)) (+(countall $a) (countall $b)))

(=(countall $x) 1)
