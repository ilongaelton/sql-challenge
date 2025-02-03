-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/CChZll
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "Employees" (
    "employees_id" INT   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" CHAR   NOT NULL,
    "salary" DECIMAL   NOT NULL,
    "hired_date" DATE   NOT NULL,
    "department_number" INT   NOT NULL,
    "manager_id" INT   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "employees_id"
     )
);

CREATE TABLE "Department" (
    "department_id" INT   NOT NULL,
    "department_name" int   NOT NULL,
    "department_number" int   NOT NULL,
    CONSTRAINT "pk_Department" PRIMARY KEY (
        "department_id"
     )
);

CREATE TABLE "Depatment_manager" (
    "manager_id" int   NOT NULL,
    "department_number" int   NOT NULL
);

ALTER TABLE "Department" ADD CONSTRAINT "fk_Department_department_id_department_name" FOREIGN KEY("department_id", "department_name")
REFERENCES "Employees" ("employees_id", "department_number");

ALTER TABLE "Depatment_manager" ADD CONSTRAINT "fk_Depatment_manager_manager_id" FOREIGN KEY("manager_id")
REFERENCES "Employees" ("employees_id");

