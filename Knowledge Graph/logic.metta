
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


(instance Python Programming_Language)
(instance SQL Database_Tool)
(instance React Web_Framework)

(subclass Programming_Language Study_Topic)
(subclass Database_Tool Study_Topic)
(subclass Web_Framework Study_Topic)

(propclass Study_Topic difficulty Beginner)


!(getprop Python difficulty)