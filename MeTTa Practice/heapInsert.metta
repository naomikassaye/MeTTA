
(node r 50)
(node a 30)
(node b 40)
(node c 10)
(node d 20)


(parent r a)
(parent r b)
(parent a c)
(parent a d)

(node e 45)
(parent b e)

(= (heapify-up ?child ?parent)
   (and
     (parent ?parent ?child)
     (> (value ?child) (value ?parent))
     (swap ?child ?parent)))
