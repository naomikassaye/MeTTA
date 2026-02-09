
(node r 50)
(node a 30)
(node b 45)
(node c 10)
(node d 20)

(parent r a)
(parent r b)
(parent a c)
(parent a d)


(= (value ?n)
   (match &self (node ?n ?v) ?v))

(= (swap ?x ?y)
   (and
     (node ?x ?vx)
     (node ?y ?vy)
     (remove (node ?x ?vx))
     (remove (node ?y ?vy))
     (node ?x ?vy)
     (node ?y ?vx)))

(= (heapify-down ?p ?c)
   (and
     (parent ?p ?c)
     (> (value ?c) (value ?p))
     (swap ?p ?c)))

(remove (node r 50))

(remove (node d 20))
(node r 20)

(heapify-down r b)
(heapify-down r a)
