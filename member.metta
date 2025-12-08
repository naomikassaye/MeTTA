(= (member $x ($x $y)) True)
(= (member $x ($z $y)) (member $x $y))
(= (member $x ()) False)

! (member soap (pasta soap bread))
! (member pizza (pasta soap bread))
