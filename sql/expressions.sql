SELECT EXISTS (SELECT *
FROM "users"
WHERE "id"=5000);


-- SELECT *
-- FROM "users"
-- WHERE "id" NOT IN (1,2,3);

SELECT "email"
FROM "users"
WHERE "id" NOT IN (SELECT "userId" FROM "orders");


SELECT "email"
FROM "users"
WHERE "id"=ANY(SELECT "userId" FROM "orders");


-- телефони (модель, бренд) які не купляли

SELECT "model","brand"
FROM "phones"
WHERE "id"!=ALL(SELECT "phoneId" FROM "phones_to_orders");