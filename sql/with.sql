-- отримати усі замовлення вартість яких більша за середню вартість
-- 1 вартість кожного замовлення
SELECT sum("p"."price"*"pto"."quantity") AS "Summa check", "pto"."orderId" AS "Number of order"
FROM "phones_to_orders" AS "pto" 
  JOIN "phones" AS "p" ON "p"."id"="pto"."phoneId"
GROUP BY "Number of order";

-- 2 середню вартість замовлення
SELECT avg("sch"."Summa_check")
FROM (
  SELECT sum("p"."price"*"pto"."quantity") AS "Summa_check", "pto"."orderId" AS "Number_of_order"
  FROM "phones_to_orders" AS "pto" 
    JOIN "phones" AS "p" ON "p"."id"="pto"."phoneId"
  GROUP BY "Number_of_order"
  ORDER BY "Summa_check" DESC
) AS "sch";
--
-- 3 отримати усі замовлення вартість яких більша за середню вартість
SELECT "sch".*
FROM (
  SELECT sum("p"."price"*"pto"."quantity") AS "Summa_check", "pto"."orderId" AS "Number_of_order"
  FROM "phones_to_orders" AS "pto" 
    JOIN "phones" AS "p" ON "p"."id"="pto"."phoneId"
  GROUP BY "Number_of_order"
  ORDER BY "Summa_check" ASC
) AS "sch"
WHERE "sch"."Summa_check" > (SELECT avg("sch"."Summa_check")
FROM (
  SELECT sum("p"."price"*"pto"."quantity") AS "Summa_check", "pto"."orderId" AS "Number_of_order"
  FROM "phones_to_orders" AS "pto" 
    JOIN "phones" AS "p" ON "p"."id"="pto"."phoneId"
  GROUP BY "Number_of_order"
  ORDER BY "Summa_check" ASC
) AS "sch");


WITH "summa_check" AS (
  SELECT sum("p"."price"*"pto"."quantity") AS "Summa_check", "pto"."orderId" AS "Number_of_order"
  FROM "phones_to_orders" AS "pto" 
    JOIN "phones" AS "p" ON "p"."id"="pto"."phoneId"
  GROUP BY "Number_of_order"
  ORDER BY "Summa_check" ASC
) 
SELECT "sch".*
FROM "summa_check" AS "sch"
WHERE "sch"."Summa_check" > (SELECT avg("sch"."Summa_check") FROM "summa_check" AS "sch");

--дістати пошти юзерів, у якіх кількість замовлень вище середньої кількості замовлень
WITH "Amount" AS
(SELECT concat("u"."firstName",' ', "u"."lastName") AS"fullName","u"."email", count("o"."id") AS "amount"
FROM "users" AS "u"
JOIN "orders" AS "o" ON "o"."userId"="u"."id"
GROUP BY "u"."email", "fullName"
ORDER BY "amount" DESC)
SELECT "amq".*
FROM "Amount" AS "amq"
WHERE "amq"."amount" > (SELECT avg("amq"."amount") FROM "Amount" AS "amq");


WITH "c_ord" AS (
  SELECT count("o"."userId") AS "count_orders", "u"."email"
  FROM "users" AS "u"
    JOIN "orders" AS "o" ON "o"."userId"="u"."id"
  GROUP BY "u"."email"
  ORDER BY "count_orders" DESC
) 
SELECT "c_ord".*
FROM "c_ord"
WHERE "c_ord"."count_orders" > (SELECT avg("c_ord"."count_orders") FROM "c_ord");

