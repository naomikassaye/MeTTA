(parent abebe aster)
(parent aster lomiyat)
(parent abebe kebede)
(parent almaz aster)
(parent almaz kebede)

(= (grandparent $x $y)
   (match &self 
      (, (parent $x $z) (parent $z $y)) 
      True)
)

(= (sibling $x $y)
   (match &self 
      (, (parent $p $x) (parent $p $y))
      (if (== $x $y) (empty) True))
)

(= (ancestor $x $y)
   (match &self (parent $x $y) True)
)

(= (ancestor $x $y)
   (match &self 
      (, (parent $x $z) (ancestor $z $y)) 
      True)
)
;;Testcases

!(grandparent abebe lomiyat)
!(sibling aster kebede)      
!(sibling aster aster)       

!(ancestor abebe lomiyat)   
!(ancestor almaz kebede)     