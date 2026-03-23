

--1--

SELECT lud."ОТЧЕСТВО" , lud."ФАМИЛИЯ", ses."УЧГОД" FROM "Н_ЛЮДИ" lud
RIGHT JOIN "Н_СЕССИЯ" ses ON lud."ИД" = ses."ЧЛВК_ИД"
WHERE lud."ФАМИЛИЯ" = 'Афанасьев' AND ses."ИД" = 14369;

-----

--2--

SELECT lud."ОТЧЕСТВО", ob."ЧЛВК_ИД", uc."НАЧАЛО"  FROM "Н_ЛЮДИ" lud
INNER JOIN "Н_ОБУЧЕНИЯ" ob on lud."ИД" = ob."ЧЛВК_ИД"
INNER JOIN "Н_УЧЕНИКИ"  uc on ob."ЧЛВК_ИД" = uc."ЧЛВК_ИД"
WHERE lud."ИМЯ" = 'Ярослав'
AND ob."НЗК" = '999080'
AND uc."ИД" < 1;

-----

--3--

SELECT COUNT(*) as отчеств_количество FROM "Н_ЛЮДИ"
GROUP BY "ОТЧЕСТВО";

-----

--4--

SELECT "ПЛАН_ИД" FROM "Н_ГРУППЫ_ПЛАНОВ"
WHERE "ПЛАН_ИД" IN (SELECT "ИД" FROM "Н_ПЛАНЫ"
    WHERE "ФО_ИД" = (
        SELECT "ИД" FROM "Н_ФОРМЫ_ОБУЧЕНИЯ"
        WHERE "НАИМЕНОВАНИЕ" = 'Очная')
)
GROUP BY "ПЛАН_ИД"
HAVING count("ГРУППА") < 2;

-----

--5--

SELECT uch."ГРУППА", avg(date_part('year', age(lud."ДАТА_РОЖДЕНИЯ"))) as avarageage FROM "Н_ЛЮДИ" lud
JOIN "Н_УЧЕНИКИ" uch ON uch."ЧЛВК_ИД" = lud."ИД"
GROUP BY uch."ГРУППА"
HAVING avg(date_part('year', age(lud."ДАТА_РОЖДЕНИЯ"))) < (
    SELECT MIN(date_part('year', age(lud2."ДАТА_РОЖДЕНИЯ")))
    FROM "Н_ЛЮДИ" lud2
    JOIN "Н_УЧЕНИКИ" uch2 ON uch2."ЧЛВК_ИД" = lud2."ИД"
    WHERE uch2."ГРУППА" = '1101'
    );

-----

--6--

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




--7--

SELECT COUNT(DISTINCT uch."ЧЛВК_ИД") AS three FROM "Н_УЧЕНИКИ" uch
JOIN "Н_ОБУЧЕНИЯ" ob ON ob."ЧЛВК_ИД" = uch."ЧЛВК_ИД"
JOIN "Н_ЛЮДИ" lud ON lud."ИД" = ob."ЧЛВК_ИД"
JOIN "Н_ВЕДОМОСТИ" ved ON ved."ЧЛВК_ИД" = lud."ИД"
WHERE uch."ГРУППА" = '3100'
AND ved."ОЦЕНКА" = '3';




