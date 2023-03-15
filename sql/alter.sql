--alter
--create custom type
CREATE TYPE task_status AS ENUM('done','pending','procesing','reject');
CREATE TABLE "users_tasks"(
  "id" bigserial PRIMARY KEY,
  "body" text NOT NULL,
  "userId" int REFERENCES "users"("id"),
  "status" task_status NOT NULL,
  "deadline" TIMESTAMP NOT NULL CHECK("deadline">=current_timestamp) DEFAULT current_timestamp
);
INSERT INTO "users_tasks" ("body", "userId", "status")
VALUES ('test1', 5, 'procesing'),('test2', 45, 'done'), ('test3', 15, 'pending');
--add column
ALTER TABLE "users_tasks"
ADD COLUMN "createdAt" TIMESTAMP NOT NULL DEFAULT current_timestamp;
ALTER TABLE "users_tasks"
ADD COLUMN "mark" int;
--del colmn
ALTER TABLE "users_tasks"
DROP COLUMN "mark";
--add constr
ALTER TABLE "users_tasks"
ADD CONSTRAINT "check_body_empty" CHECK ("body"!='');
--del constr
ALTER TABLE "users_tasks"
DROP CONSTRAINT "users_tasks_deadline_check";
--del NOT NULL
ALTER TABLE "users_tasks"
ALTER COLUMN "createdAt" DROP NOT NULL;
--add NOT NULL
ALTER TABLE "users_tasks"
ALTER COLUMN "createdAt" SET NOT NULL;
--change default
ALTER TABLE "users_tasks"
ALTER COLUMN "status" SET DEFAULT 'pending';
ALTER TABLE "users_tasks"
ALTER COLUMN "status" DROP DEFAULT;
--change type
ALTER TABLE "users_tasks"
ALTER COLUMN "body" TYPE varchar(1024);
--change name column
ALTER TABLE "users_tasks"
RENAME COLUMN "body" TO "bodyTask";
--change name table
ALTER TABLE "users_tasks"
RENAME TO "tasks";
SELECT * FROM "tasks";
