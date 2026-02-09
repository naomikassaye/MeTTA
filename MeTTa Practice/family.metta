;practice for pattern matching
(parent abebe aster)
(parent aster lomiyat)
(parent abebe kebede)
(parent almaz aster)
(parent almaz kebede)

(= (grandparent $x $y)
   (match &self (parent $x $z)
      (match &self (parent $z $y)
          True
      )
   )
)

(= (sibling $x $y)
   (match &self (parent $p $x)
      (match &self (parent $p $y)
          (if (== $x $y)
              (empty)
              True
          )
      )
   )
)

! (grandparent abebe lomiyat)
! (sibling aster kebede)
! (sibling aster aster)