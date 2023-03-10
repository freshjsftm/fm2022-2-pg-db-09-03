CREATE TABLE a(s VARCHAR(3), q int);
CREATE TABLE b(w VARCHAR(3));
INSERT INTO "a" VALUES ('qwe',2),('aaa',2),('zxc',2);
INSERT INTO "b" VALUES ('qwe'),('bbb'),('zxc'),('sss');

SELECT * FROM a
  JOIN b ON a.s=b.w;


--декартовий добуток
SELECT * FROM a,b;
--об'єднання
SELECT w FROM b
UNION
SELECT s FROM a;
--перетин
SELECT w FROM b
INTERSECT
SELECT s FROM a;
--віднімання
SELECT w FROM b
EXCEPT
SELECT s FROM a;
SELECT s FROM a
EXCEPT
SELECT w FROM b;

