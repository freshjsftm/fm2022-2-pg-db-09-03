
-- перша нормальна форма
CREATE TABLE t1(
  p1 VARCHAR(16),
  p2 int,
  PRIMARY KEY(p1, p2)
);

--друга нормальна форма
CREATE TABLE "specials"(
  "id" serial PRIMARY KEY,
  "name"  VARCHAR(16)
);
CREATE TABLE "workers"(
  "id" serial PRIMARY KEY,
  "name"  VARCHAR(16),
  "departament"  VARCHAR(16),
  "specialId" REFERENCES "specials"."id"
  -- "special"  VARCHAR(16),
  -- "isCar" boolean
);

-- INSERT INTO "workers" ("name","special",  "isCar")
-- VALUES ('Tom','HR', false), ('Rob','HR', false), ('Fred','programmer', false), ('Tom','driver', true);
INSERT INTO "workers" ("name","specialId")
VALUES ('Tom',1), ('Rob',3), ('Fred',2), ('Tom',3);



CREATE TABLE "students"("id" serial PRIMARY KEY);
CREATE TABLE "predmets"("id" serial PRIMARY KEY);
CREATE TABLE "teachers"("id" serial PRIMARY KEY, "predmetID" REFERENCES );

CREATE TABLE "students_to_teachers" ("studentId", "teacherId",  PRIMARY KEY ("studentId", "teacherId"));
CREATE TABLE "students_to_predmets" ("studentId", "predmetID",  PRIMARY KEY ("studentId", "predmetID"));
