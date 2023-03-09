--порахувати кількість телефонів, які були продані
SELECT sum("quantity")
FROM "phones_to_orders";
--порахувати кількість телефонів, які є на складі
SELECT sum("quantity")
FROM "phones";
--порахувати сереню ціну
SELECT avg(price) as "Average price"
FROM "phones";
--порахувати середню ціну кожного бренда
SELECT avg(price) as "Average price", "brand"
FROM "phones"
GROUP BY "brand";
--порахувати кількість моделей кожного бренда
SELECT count("model"), "brand"
FROM "phones"
GROUP BY "brand";
--порахувати середню ціну на Sony
SELECT avg("price"), "brand"
FROM "phones"
WHERE "brand"='Sony'
GROUP BY "brand";
--порахувати кількість замовлень кожного користувача
SELECT count(*), "userId"
FROM "orders"
GROUP BY "userId";
--порахувати загальну вартість усіх телефонів в діапазоні цін від 10000 до 20000 
SELECT sum("price"*"quantity") as "Summ price of phone"
FROM "phones"
WHERE "price" BETWEEN 10000 AND 20000;


SELECT "id", "height","firstName", "birthday"
FROM "users"
ORDER BY "height" DESC, "firstName" ASC, "birthday" DESC;


--якої моделі телефонів залишилося менше усього на складі(id,model,brand)
SELECT "id","model","brand", "quantity"
FROM "phones"
ORDER BY "quantity" ASC
LIMIT 1;

--відсортувати юзерів за віком, а потім за ім'ям та прізвищем(id,age,firstName,lastName)
SELECT *
FROM (
  SELECT "id", extract("year" FROM age("birthday")) as "age", "firstName", "lastName"
  FROM "users"
  ) AS "AGE_USER"
WHERE "AGE_USER"."age"IN (22,33,44,55,66,77)
ORDER BY "age", "firstName", "lastName";


--порахувати кількість людей кожного віку (age, count)
SELECT count(*) as "count", extract("year" FROM age("birthday")) as "age"
FROM "users"
GROUP BY "age"
ORDER BY "count" ASC, "age";


SELECT *
FROM (
  SELECT count("id") AS "count", extract("years" FROM age("birthday")) AS "age"
  FROM "users"
  GROUP BY "age"
) AS "BLABLA"
WHERE "BLABLA"."age" BETWEEN 20 AND 30
ORDER BY "BLABLA"."count" DESC;



--порахувати кількість людей кожного віку (age, count) і вивести тільки той вік, де кількість = 4
SELECT count(*) as "count", extract("year" FROM age("birthday")) as "age"
FROM "users"
GROUP BY "age"
HAVING count(*)=3
ORDER BY "age";


/*
LIKE - з урахуванням регистру
ILIKE - без урахування регистру

SIMILAR TO

REG_EXP

*/

SELECT "id", "firstName"
FROM "users"
WHERE "firstName" ILIKE '_o%e';


--знайдiть юзерів з ініціалами MN
SELECT "id", "firstName", "lastName"
FROM "users"
WHERE "firstName" ILIKE 'a%' AND "lastName" ILIKE 's%';


SELECT "id", "firstName", "lastName"
FROM "users"
WHERE "firstName" SIMILAR TO '(A|B)%';