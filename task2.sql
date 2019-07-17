/*
create table company (compid int identity(1,1) primary key, name nvarchar(100) not null)
create table goods (goodid int identity(1,1) primary key, name nvarchar(100) not null)
create table shipment (shipid int identity(1,1) primary key, compid int not null,
  goodid int not null, quantity float not null, shipdate datetime not null)

set identity_insert company on
insert company (compid, name) values (1, 'Intel')
insert company (compid, name) values (2, 'IBM')
insert company (compid, name) values (3, 'Compaq')
set identity_insert company off

set identity_insert goods on
insert goods (goodid, name) values (1, 'Pentium IIV')
insert goods (goodid, name) values (2, 'IBM server')
insert goods (goodid, name) values (3, 'Compaq Presario')
set identity_insert goods off

insert shipment (compid, goodid, quantity, shipdate) values (1, 1, 100, '11/04/2010')
insert shipment (compid, goodid, quantity, shipdate) values (1, 1, 200, '11/12/2010')
insert shipment (compid, goodid, quantity, shipdate) values (1, 2, 300, '12/02/2010')
insert shipment (compid, goodid, quantity, shipdate) values (1, 2, 400, '10/09/2010')
insert shipment (compid, goodid, quantity, shipdate) values (2, 1, 100, '10/29/2010')
insert shipment (compid, goodid, quantity, shipdate) values (2, 1, 200, '11/06/2010')
insert shipment (compid, goodid, quantity, shipdate) values (2, 2, 300, '12/29/2010')
insert shipment (compid, goodid, quantity, shipdate) values (2, 2, 700, '12/03/2010')

a. Вывести общий объем поставок каждого из продуктов для каждой фирмы с указанием
      даты последней поставки
 */

SELECT
    goods.name,
    company.name,
    SUM(shipment.quantity),
    MAX(shipment.shipdate)
FROM shipment
         INNER JOIN goods ON goods.goodid = shipment.goodid
         INNER JOIN company ON company.compid = shipment.compid
GROUP BY goods.name, company.name;

/*
 b. Аналогично предыдущему пункту, но за последние 40 дней. Если поставки
      какого-либо из товаров для компании в этот период отсутствовали, вывести в
      столбце объема 'No data'
 */


SELECT
    goods.name,
    company.name,
    CONVERT(COALESCE(SUM(shipment.quantity), 'No data'), char) sum_quantity,
    MAX(shipment.shipdate) last_shipdate
FROM shipment
         RIGHT JOIN goods ON goods.goodid = shipment.goodid
         RIGHT JOIN company ON company.compid = shipment.compid
WHERE
    goods.name IS NOT NULL AND
    company.name IS NOT NULL AND
    shipment.shipdate > (CURRENT_TIMESTAMP - interval '40' day)
GROUP BY goods.name,
         company.name;
