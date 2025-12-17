(: Tree Type)
(: Null Tree)
(: Node (-> Number Tree Tree Tree))

(: insert (-> Number Tree Tree))

(= (insert $new Null) 
   (Node $new Null Null))


(= (insert $new (Node $current $left $right))
   (if (< $new $current)
 
       (Node $current (insert $new $left) $right)
      
       (Node $current $left (insert $new $right))
   )
)
