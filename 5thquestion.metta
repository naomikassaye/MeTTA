(instance Fido Dog)      
(subclass Dog Mammal)    

(local Fido color Brown)
(propinstance Dog sound Bark)
(propclass Mammal blood Warm)


(= (getprop $obj $key)
   (match &self (local $obj $key $val) $val))

(= (getprop $obj $key)
   (match &self 
      (instance $obj $class)          
      (match &self 
         (propinstance $class $key $val)
         $val
      )
   ))


(= (getprop $obj $key)
   (match &self 
      (instance $obj $class)           
      (match &self 
          (subclass $class $parent)    
          (match &self 
              (propclass $parent $key $val) 
              $val
          )
      )
   ))

;testcases
! (getprop Fido color)  
! (getprop Fido sound)  
! (getprop Fido blood) 