(: Tree Type)
(: Null Tree)
(: Node (-> Number Tree Tree Tree))

(: List Type)
(: Nil List)
(: Cons (-> Number List List))

(: delete (-> Tree Number Tree))
(= (delete Null $key) Null)

(= (delete (Node $val $L $R) $key)
   (if (< $key $val)
       (Node $val (delete $L $key) $R)
       (if (> $key $val)
           (Node $val $L (delete $R $key))
           (delete-node (Node $val $L $R)))))

(: delete-node (-> Tree Tree))
(= (delete-node (Node $val $L $R))
   (if (== $L Null)
       $R 
       (if (== $R Null)
           $L 
           (let $min (find-min $R)
                (Node $min $L (delete $R $min))))))

(: find-min (-> Tree Number))

(= (find-min (Node $val $L $R))
   (if (== $L Null)
       $val
       (find-min $L)))

(: inorder (-> Tree List))
(: append (-> List List List))

(= (append Nil $L) $L)
(= (append (Cons $x $xs) $L) (Cons $x (append $xs $L)))

(= (inorder Null) Nil)
(= (inorder (Node $val $L $R))
   (append (inorder $L) (Cons $val (inorder $R))))

! (inorder (delete (Node 10 
                        (Node 5 Null Null) 
                        (Node 15 
                              (Node 12 Null Null) 
                              (Node 20 Null Null))) 
                   15))