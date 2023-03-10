--отримати id усіх юзерів , які робили замовлення
SELECT "id" FROM "users"
INTERSECT
SELECT "userId" FROM "orders";

--отримати id усіх юзерів , які НЕ робили замовлення
SELECT "id" FROM "users"
EXCEPT
SELECT "userId" from "orders";

--отримати усі замовлення юзера з id=33
SELECT "u"."id", "u"."email", "o"."id" AS "orederId" 
FROM "users" AS "u"
  JOIN "orders" AS "o" ON "u"."id"="o"."userId"
  WHERE "u"."id"=23;
  
--отримати усі id і час замовлення з Sony  
SELECT "o"."id", "o"."createdAt", "p"."brand", "p"."model"
FROM "orders" AS "o"
  JOIN "phones_to_orders" AS "pto" ON "o"."id"="pto"."orderId"
  JOIN "phones" AS "p" ON "pto"."phoneId"="p"."id"
WHERE "p"."brand"='Sony';

--кількість сонь в одному замовленні
SELECT "o"."id", count("p"."model") AS "amount", "p"."brand"
FROM "orders" AS "o"
  JOIN "phones_to_orders" AS "pto" ON "o"."id"="pto"."orderId"
  JOIN "phones" AS "p" ON "pto"."phoneId"="p"."id"
WHERE "p"."brand"='Sony'
GROUP BY "o"."id", "p"."brand"
ORDER BY "amount" DESC;

--кількість проданих екземплярів по кожній моделі
SELECT sum("pto"."quantity"), "p"."model"
FROM "phones" AS "p"
  JOIN "phones_to_orders" AS "pto" ON "p"."id"="pto"."phoneId"
GROUP BY "p"."model";

--кількість проданих екземплярів по кожній бренду
SELECT sum("pto"."quantity"), "p"."brand"
FROM "phones" AS "p"
  JOIN "phones_to_orders" AS "pto" ON "p"."id"="pto"."phoneId"
GROUP BY "p"."brand";


SELECT "p"."brand", "p"."model"
FROM "phones" AS "p"
  LEFT OUTER JOIN "phones_to_orders" AS "pto" ON "p"."id"="pto"."phoneId"
WHERE "pto"."phoneId" IS NULL
GROUP BY "p"."brand", "p"."model";

