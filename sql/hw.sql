--отримати пошту користувачів, які купляли айфони
  SELECT "u"."email", count(*), "p"."brand"
  FROM "users" "u"
  JOIN "orders" "o" ON "o"."userId"="u"."id"
  JOIN "phones_to_orders" "pto" ON "pto"."orderId"="o"."id"
  JOIN "phones" "p" ON "p"."id"="pto"."phoneId"
  WHERE "p"."brand" = 'Iphone'
  GROUP BY "u"."email", "p"."brand";

--отримати користувачів, які зробили більше 3 замовлень
    SELECT concat("u"."firstName",' ', "u"."lastName") AS"fullName", count("o"."id") AS "amount"
    FROM "users" "u"
    JOIN "orders" "o" ON "o"."userId"="u"."id"
     GROUP BY "fullName"
     HAVING count("o"."userId")>3
     ORDER BY "amount" DESC, "fullName";


     SELECT "users"."firstName", "users"."lastName",count("orders"."id") AS "quantity orders"
FROM "users"
JOIN "orders" ON "users"."id"="orders"."userId"
GROUP BY "users"."firstName", "users"."lastName"
HAVING count("orders"."id")>3
ORDER BY "quantity orders" DESC, "users"."firstName";

SELECT count("userId"), "userId"
FROM "orders"
GROUP BY "userId"
HAVING count("userId")>3;

--отримати усі замовлення з телефоном з id=13 і пошту юзерів
SELECT "phones"."brand" , "phones"."model","phones"."id","users"."email"
FROM "phones"
JOIN "phones_to_orders" ON "phones"."id"="phones_to_orders"."phoneId"
JOIN "orders" ON "phones_to_orders"."orderId"="orders"."id"
JOIN "users" ON "orders"."userId"="users"."id"
WHERE "phones"."id"=13
GROUP BY "phones"."brand" , "phones"."model","phones"."id","users"."email";
--отримати модель найпопулярнішого телефону(продана найбільшу кількість)
SELECT sum("phones_to_orders"."quantity") AS "quantity", "phones"."model"
FROM "phones" 
JOIN "phones_to_orders" ON "phones"."id"="phones_to_orders"."phoneId"
GROUP BY "phones"."model"
ORDER BY "quantity" DESC
LIMIT 1;
--отримати сумму чеку кожного замовлення
SELECT sum("p"."price"*"pto"."quantity") AS "Average check", "pto"."orderId" AS "Number of order"
--FROM "orders" "o"
FROM "phones_to_orders" "pto" --ON "pto"."orderId"="o"."id"
JOIN "phones" "p" ON "p"."id"="pto"."phoneId"
GROUP BY "Number of order"
ORDER BY  "Average check" ;


SELECT sum("list"."price"),"list"."order_id"
FROM
(
  SELECT ("phones"."price")*("phones_to_orders"."quantity") as "price","phones_to_orders"."orderId" as "order_id"
  FROM "phones"
  JOIN "phones_to_orders" ON "phones"."id"="phones_to_orders"."phoneId"
) AS "list"
GROUP BY "list"."order_id"
ORDER BY sum("list"."price");

SELECT sum("phones_to_orders"."quantity"*"phones"."price"), "phones_to_orders"."orderId"
FROM "phones_to_orders"
JOIN "phones" ON "phones"."id"= "phones_to_orders"."phoneId"
GROUP BY "phones_to_orders"."orderId"
ORDER BY sum("phones_to_orders"."quantity"*"phones"."price")