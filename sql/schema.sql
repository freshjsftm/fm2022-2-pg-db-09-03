CREATE SCHEMA "workers";
CREATE TABLE "workers"."users"(
  "id" serial PRIMARY KEY,
  "email" varchar(512) NOT NULL CHECK("email"!=''),
  "login" varchar(32) NOT NULL CHECK("login"!=''),
  "password" varchar(64) NOT NULL CHECK("password"!='')
);

-- додайте обмеження унікальності для пошти
ALTER TABLE "workers"."users"
ADD CONSTRAINT "check_email_uniq" UNIQUE("email");
-- змініть назву "password" на "passwordHash"
ALTER TABLE "workers"."users"
RENAME COLUMN "password" TO "passwordHash";
-- змініть тип пароля на текст
ALTER TABLE "workers"."users"
ALTER COLUMN "passwordHash" TYPE text;

-- створіть таблицю "employees"("id", "salary", "position", "addDate", "userId")
CREATE TABLE "workers"."employees"(
  "id" serial PRIMARY KEY,
  "salary" numeric(10,2) NOT NULL CHECK("salary">0),
  "position" varchar(128) NOT NULL CHECK ("position"!=''),
  "addDate" DATE NOT NULL DEFAULT current_date,
  "userId" int REFERENCES "workers"."users"("id")
);
--вставити 2 юзери та 2 робітники
INSERT INTO "workers"."users"("email", "login", "passwordHash")
VALUES ('pitt@gmail.com', 'pitt', 'awdhf_d465-dfgWrebsd'),
('brad@gmail.com', 'brad', 'awdhf_d465-dfgW324sdfsdfrebsd')

INSERT INTO "workers"."employees"("salary", "position", "userId")
VALUES (123, 'hr', 1), (555,'pr',2);

INSERT INTO "workers"."users"("email", "login", "passwordHash")
VALUES ('fred@gmail.com', 'fred', 'sdfrtdss-dfgWrebsd');

-- виберіть усі логіни і зарплату, якщо зарплати не має поставте 0 
SELECT "workers"."users"."login", COALESCE("workers"."employees"."salary", 0)
FROM "workers"."users" 
LEFT OUTER  JOIN "workers"."employees" ON "workers"."users"."id"="workers"."employees"."userId";

-- обрати усіх не працівників
SELECT "workers"."users"."login"
FROM "workers"."users" 
WHERE "workers"."users"."id" NOT IN (SELECT "workers"."employees"."userId" FROM "workers"."employees" );


SELECT "workers"."users"."login"
FROM "workers"."users" 
LEFT OUTER  JOIN "workers"."employees" ON "workers"."users"."id"="workers"."employees"."userId"
WHERE "workers"."employees"."userId" IS NULL;





