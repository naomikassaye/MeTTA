
(stock pasta 67 100)
(stock soap 50 60)


(= (total $item)
   (match &self (stock $item $p $q) (* $p $q)))

(= (available $item)
   (match &self (stock $item $p $q) (> $q 0)))

! (total pasta)    
! (available soap)    