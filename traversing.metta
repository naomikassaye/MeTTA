(: Tree Type)
(: Null Tree)
(: Node (-> Number Tree Tree Tree))

(: inorder (-> Tree List))
(= (inorder Null) Null)
(= (inorder (Node $value $left $right))
   (append (inorder $left) (Cons $value (inorder $right)))
)

(: preorder (-> Tree List))
(= (preorder Null) Null)
(= (preorder (Node $value $left $right))
   (Cons $value (append (preorder $left) (preorder $right)))
)

(: postorder (-> Tree List))
(= (postorder Null) Null)
(= (postorder (Node $value $left $right))
   (append (postorder $left) (append (postorder $right) (Cons $value Null)))
)

