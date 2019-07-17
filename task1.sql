/*
 Таблица Firms:
ID    Name
1     Sony
2     Panasonic
3     Samsung

Таблица Phones:
phone_id  FirmID  Phone
1         1       332-55-56
2         1       332-50-01
3         2       256-49-12

Написать SQL-запросы:
a. Вернуть название фирмы и ее телефон. В результате должны быть представлены
   все фирмы по одному разу. Если у фирмы нет телефона, нужно вернуть пробел или
   прочерк. Если у фирмы несколько телефонов, нужно вернуть любой из них.
 */

SELECT firms.name, MAX(phones.phone) phone FROM firms LEFT JOIN phones ON firms.id = phones.firmid GROUP BY firms.name;

/*
 b. Вернуть все фирмы, не имеющие телефонов.
 */
SELECT firms.name FROM firms LEFT JOIN phones ON firms.id = phones.firmid GROUP BY firms.name HAVING COUNT(phones.id) = 0;

/*
 c. Вернуть все фирмы, имеющие не менее 2-х телефонов.
 */
SELECT firms.name FROM firms LEFT JOIN phones ON firms.id = phones.firmid GROUP BY firms.name HAVING COUNT(phones.id) >= 2;

/*
d. Вернуть все фирмы, имеющие менее 2-х телефонов.
 */
SELECT firms.name FROM firms LEFT JOIN phones ON firms.id = phones.firmid GROUP BY firms.name HAVING COUNT(phones.id) < 2;

/*
e. Вернуть фирму, имеющую максимальное кол-во телефонов.
 */
SELECT firms.name FROM firms LEFT JOIN phones ON firms.id = phones.firmid GROUP BY firms.name ORDER BY COUNT(phones.id) LIMIT 1;
