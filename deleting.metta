(= (delete Null key) Null)

(= (delete (Node value left right) key)
   (Node value (delete left key) right)
   (< key value))

(= (delete (Node value left right) key)
   (Node value left (delete right key))
   (> key value))

(= (delete (Node value left right) value)
   (delete-node (Node value left right)))

(= (delete-node (Node value Null)) Null)

(= (delete-node (Node value Null right)) right)

(= (delete-node (Node value left Null)) left)

(= (delete-node (Node value left right))
   (Node (find-min right) left (delete right (find-min right))))

(= (find-min (Node value Null right)) value)
(= (find-min (Node value left right)) (find-min left))
