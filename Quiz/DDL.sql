CREATE TABLE "employees" (
  "id" SERIAL,
  "emp_name" TEXT,
  "manager_id" INTEGER
);

CREATE TABLE "employee_phones" (
  "emp_id" INTEGER,
  "phone_number" TEXT
);

CREATE TABLE "customers" (
  "id" SERIAL,
  "first_name" VARCHAR,
  "last_name" VARCHAR,
  "phone_number" VARCHAR
);

CREATE TABLE "customer_emails" (
  "customer_id" INTEGER,
  "email_address" VARCHAR
);

CREATE TABLE "rooms" (
  "id" SERIAL,
  "floor" SMALLINT,
  "room_no" SMALLINT,
  "area_sqft" SMALLINT
);

CREATE TABLE "reservations" (
  "id" SERIAL,
  "customer_id" INTEGER,
  "room_id" INTEGER,
  "check_in" DATE,
  "check_out" DATE
);

ALTER TABLE "students" ALTER COLUMN "email_address" SET DATA TYPE VARCHAR;

ALTER TABLE "courses" ALTER COLUMN "rating" SET DATA TYPE REAL;


ALTER TABLE "registrations" ALTER COLUMN "student_id" SET DATA TYPE INTEGER;

ALTER TABLE "registrations" ALTER COLUMN "course_id" SET DATA TYPE INTEGER;

