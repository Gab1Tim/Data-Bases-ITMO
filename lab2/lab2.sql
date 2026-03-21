

--1--

SELECT lud."ОТЧЕСТВО" , lud."ФАМИЛИЯ", ses."УЧГОД" FROM "Н_ЛЮДИ" lud

RIGHT JOIN "Н_СЕССИЯ" ses ON lud."ИД" = ses."ЧЛВК_ИД"

WHERE lud."ФАМИЛИЯ" = 'Афанасьев' AND ses."ИД" = 14369

--2--

SELECT  FROM "Н_ЛЮДИ" lud

INNER JOIN



