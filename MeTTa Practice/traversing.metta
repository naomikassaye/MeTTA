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
(= (inorder (Node $value $left $right))
   (append (inorder $left) (Cons $value (inorder $right))))

(: preorder (-> Tree List))
(= (preorder Null) Nil)
(= (preorder (Node $value $left $right))
   (Cons $value (append (preorder $left) (preorder $right))))

(: postorder (-> Tree List))
(= (postorder Null) Nil)
(= (postorder (Node $value $left $right))
   (append (postorder $left) (append (postorder $right) (Cons $value Nil))))

! (inorder (Node 1 
                 (Node 2 (Node 4 Null Null) (Node 5 Null Null)) 
                 (Node 3 Null Null)))

! (preorder (Node 1 
                  (Node 2 (Node 4 Null Null) (Node 5 Null Null)) 
                  (Node 3 Null Null)))

! (postorder (Node 1 
                   (Node 2 (Node 4 Null Null) (Node 5 Null Null)) 
                   (Node 3 Null Null)))