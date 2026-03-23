SELECT sp.id, AVG(ch.age), COUNT(ch.id) AS yas, (SELECT MAX(ast.size) FROM asteroid ast WHERE ast.place_id = sp.place_id)
AS buyuk FROM spaceship sp
JOIN observation ob ON  sp.id = ob.operator_id
JOIN characters ch ON  ob.operator_id = ch.id
JOIN shape sh ON ob.shape_id = sh.id


WHERE sh.color = 'white'
AND sh.round = true

GROUP BY sp.id
limit 1;
