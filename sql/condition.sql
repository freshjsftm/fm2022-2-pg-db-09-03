SELECT *
FROM "phones"
WHERE "description" IS NULL;
SELECT *
FROM "users";
/*
 CASE 
 WHEN condition1 THEN action1
 WHEN condition2 THEN action2
 ELSE action3
 END
 */
/*
 CASE expression
 WHEN variant1 THEN action1
 WHEN variant2 THEN action2
 WHEN variant3 THEN action3
 END
 */
SELECT "email",
  (
    CASE
      WHEN "isMale" THEN 'male'
      ELSE 'female'
    END
  ) AS "gender"
FROM "users";
SELECT "birthday",
  (
    CASE
      extract(
        "month"
        from "birthday"
      ) --3
      WHEN 1 THEN 'winter'
      WHEN 2 THEN 'winter'
      WHEN 3 THEN 'spring'
      WHEN 4 THEN 'spring'
      WHEN 5 THEN 'spring'
      WHEN 6 THEN 'summer'
      WHEN 7 THEN 'summer'
      WHEN 8 THEN 'summer'
      WHEN 9 THEN 'fall'
      WHEN 10 THEN 'fall'
      WHEN 11 THEN 'fall'
      WHEN 12 THEN 'winter'
    END
  ) AS "season"
FROM "users";
-- вивести "age" і "adult" adult/not adult  (35)
SELECT extract(
    "years"
    FROM age("birthday")
  ),
(
    CASE
      WHEN extract(
        "years"
        FROM age("birthday")
      ) > 35 THEN 'adult'
      ELSE 'not adult'
    END
  ) AS "isAdult"
FROM "users";


SELECT extract ("year" from age("birthday") ) AS "age",
  (
    CASE
      WHEN extract ("year" from age("birthday") ) >= 35 THEN 'adult'
      ELSE 'not adult'
    END
  )
FROM "users";


-- вивести APPLE, якщо бренд відповідний, інакше - OTHER (brand, manufacturer)

--вивести ціну і цінову категорію (low, medium, high) де low <6000, high>16000

-- вивести модель, бренд, ціну і колонку, де повідомляється що ціна вище або нижче середньої (above, below)

SELECT "model", "brand", "price", (
  CASE
    WHEN "price" > (SELECT avg("price") FROM "phones") THEN 'above'
    ELSE 'below'
  END
) AS "above_below"
FROM "phones";

-- порахувати кількість телефонів з ціною вище 10000
SELECT sum(
  CASE
    WHEN "price" > 10000 THEN 1
    ELSE 0
  END
)
FROM "phones";


SELECT COALESCE(NULL,'not description');

SELECT "model",COALESCE("description", 'not description')
FROM "phones";
