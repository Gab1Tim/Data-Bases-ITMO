---5---
EXPLAIN ANALYZE
SELECT uch."ГРУППА", avg(date_part('year', age(lud."ДАТА_РОЖДЕНИЯ"))) as avarageage FROM "Н_ЛЮДИ" lud
JOIN "Н_УЧЕНИКИ" uch ON uch."ЧЛВК_ИД" = lud."ИД"
GROUP BY uch."ГРУППА"
HAVING avg(date_part('year', age(lud."ДАТА_РОЖДЕНИЯ"))) < (
    SELECT MIN(date_part('year', age(lud2."ДАТА_РОЖДЕНИЯ")))
    FROM "Н_ЛЮДИ" lud2
             JOIN "Н_УЧЕНИКИ" uch2 ON uch2."ЧЛВК_ИД" = lud2."ИД"
    WHERE uch2."ГРУППА" = '1101'
);

----5.2----

EXPLAIN ANALYZE
SELECT uch."ГРУППА", avg(date_part('year', age(lud."ДАТА_РОЖДЕНИЯ"))) as avarageage FROM "Н_ЛЮДИ" lud
JOIN "Н_УЧЕНИКИ" uch ON uch."ЧЛВК_ИД" = lud."ИД"
GROUP BY uch."ГРУППА"
HAVING avg(date_part('year', age(lud."ДАТА_РОЖДЕНИЯ"))) < (
    SELECT date_part('year', age(MAX(lud2."ДАТА_РОЖДЕНИЯ")))
    FROM "Н_ЛЮДИ" lud2
             JOIN "Н_УЧЕНИКИ" uch2 ON uch2."ЧЛВК_ИД" = lud2."ИД"
    WHERE uch2."ГРУППА" = '1101'
);
-------


---6---
EXPLAIN ANALYZE
SELECT lud."ФАМИЛИЯ", lud."ИМЯ", lud."ОТЧЕСТВО", uch."ГРУППА", uch."П_ПРКОК_ИД", uch."ПРИМЕЧАНИЕ", uch."НАЧАЛО" FROM "Н_ЛЮДИ" lud
JOIN "Н_УЧЕНИКИ" uch ON lud."ИД" = uch."ЧЛВК_ИД"
JOIN "Н_ПЛАНЫ" pl ON uch."ПЛАН_ИД" = pl."ПЛАН_ИД"
JOIN "Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ" napsal ON pl."НАПС_ИД" = napsal."НАПС_ИД"
JOIN "Н_НАПР_СПЕЦ" naps ON  napsal."НС_ИД" = naps."ИД"
JOIN "Н_ФОРМЫ_ОБУЧЕНИЯ" fo ON pl."ФО_ИД" = fo."ИД"
WHERE uch."НАЧАЛО" = DATE '2012-09-01'
  AND pl."КУРС" = 1
  AND pl."ФО_ИД" IN (SELECT fo1."ИД" FROM "Н_ФОРМЫ_ОБУЧЕНИЯ" fo1
                     WHERE fo."НАИМЕНОВАНИЕ" = 'Очная')
  AND pl."НАПС_ИД" IN (SELECT naps2."ИД" FROM "Н_НАПР_СПЕЦ" naps2
                       WHERE naps2."КОД_НАПРСПЕЦ" = '230101');

----6.2----
EXPLAIN ANALYZE
SELECT lud."ФАМИЛИЯ", lud."ИМЯ", lud."ОТЧЕСТВО", uch."ГРУППА", uch."П_ПРКОК_ИД", uch."ПРИМЕЧАНИЕ", uch."НАЧАЛО" FROM "Н_ЛЮДИ" lud
         JOIN "Н_УЧЕНИКИ" uch ON lud."ИД" = uch."ЧЛВК_ИД"
         JOIN "Н_ПЛАНЫ" pl ON uch."ПЛАН_ИД" = pl."ПЛАН_ИД"
         JOIN "Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ" napsal ON pl."НАПС_ИД" = napsal."НАПС_ИД"
         JOIN "Н_НАПР_СПЕЦ" naps ON  napsal."НС_ИД" = naps."ИД"
         JOIN "Н_ФОРМЫ_ОБУЧЕНИЯ" fo ON pl."ФО_ИД" = fo."ИД"
WHERE uch."НАЧАЛО" = DATE '2012-09-01'
AND pl."КУРС" = 1
AND fo."НАИМЕНОВАНИЕ" = 'Очная'
AND naps."КОД_НАПРСПЕЦ" = '230101';

----7----
EXPLAIN ANALYZE
SELECT COUNT(DISTINCT uch."ЧЛВК_ИД") AS three FROM "Н_УЧЕНИКИ" uch
JOIN "Н_ОБУЧЕНИЯ" ob ON ob."ЧЛВК_ИД" = uch."ЧЛВК_ИД"
JOIN "Н_ЛЮДИ" lud ON lud."ИД" = ob."ЧЛВК_ИД"
 JOIN "Н_ВЕДОМОСТИ" ved ON ved."ЧЛВК_ИД" = lud."ИД"
WHERE uch."ГРУППА" = '3100'
  AND ved."ОЦЕНКА" = '3';


----7.2---
EXPLAIN ANALYZE
SELECT COUNT(DISTINCT uch."ЧЛВК_ИД") AS three
FROM "Н_УЧЕНИКИ" uch
WHERE uch."ГРУППА" = '3100'
  AND uch."ЧЛВК_ИД" IN (
    SELECT ved."ЧЛВК_ИД"
    FROM "Н_ВЕДОМОСТИ" ved
    WHERE ved."ОЦЕНКА" = '3'
);







