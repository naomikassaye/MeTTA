(: Tree Type)
(: Null Tree)
(: Node (-> Number Tree Tree Tree))

(: List Type)
(: Nil List)
(: Cons (-> Number List List))

(: append (-> List List List))
(= (append Nil $L) $L)
(= (append (Cons $x $xs) $L) 
   (Cons $x (append $xs $L)))

(: inorder (-> Tree List))
(= (inorder Null) Nil)
(= (inorder (Node $val $L $R))
   (append (inorder $L) (Cons $val (inorder $R))))

(: insert (-> Number Tree Tree))
(= (insert $new Null) 
   (Node $new Null Null))
   
(= (insert $new (Node $current $left $right))
   (if (< $new $current)
       (Node $current (insert $new $left) $right)
       (Node $current $left (insert $new $right))
   )
)

! (insert 5 (Node 10 Null Null))
! (inorder (insert 8 
              (insert 15 
                  (insert 5 
                      (insert 10 Null)))))
! (inorder (insert 10 (insert 10 Null)))

      ;   10
      ;  /  \
      ; 5    15
      ;     /  \
      ;   12    20
