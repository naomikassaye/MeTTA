(= (search $key ($key $y)) "found")

(= (search $key ($head $y)) (search $key $y))

(= (search $key ()) "Not found")