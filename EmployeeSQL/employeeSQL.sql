CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,          -- Automatically generates a unique ID for each department
    department_name VARCHAR(255) NOT NULL,     -- Department's name (e.g., Sales, HR)
    location VARCHAR(255)                     -- Location of the department
);

CREATE TABLE employees (
    employee_number SERIAL PRIMARY KEY,        -- Unique employee number
    first_name VARCHAR(100) NOT NULL,          -- Employee's first name
    last_name VARCHAR(100) NOT NULL,           -- Employee's last name
    sex CHAR(1) CHECK (sex IN ('M', 'F')),     -- Employee's sex ('M' or 'F')
    hire_date DATE NOT NULL,                   -- Employee's hire date
    salary DECIMAL(10, 2),                     -- Employee's salary
    department_id INT,                         -- Foreign key to departments table
    manager_id INT,                            -- Foreign key to employee's manager (self-referencing)
    CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE SET NULL,
    CONSTRAINT fk_manager FOREIGN KEY (manager_id) REFERENCES employees(employee_number) ON DELETE SET NULL
);

CREATE TABLE salaries (
    employee_number INT,                      -- Employee number, referencing the employees table
    salary DECIMAL(10, 2),                     -- Salary amount
    from_date DATE NOT NULL,                   -- Date the salary started
    to_date DATE,                              -- Date the salary ended (NULL means current salary)
    PRIMARY KEY (employee_number, from_date),  -- Composite key: employee_number + from_date
    CONSTRAINT fk_employee FOREIGN KEY (employee_number) REFERENCES employees(employee_number)
);

CREATE TABLE titles (
    employee_number INT,                      -- Employee number, referencing the employees table
    title VARCHAR(255) NOT NULL,               -- Job title (e.g., Manager, Developer)
    from_date DATE NOT NULL,                   -- Date the title started
    to_date DATE,                              -- Date the title ended (NULL means current title)
    PRIMARY KEY (employee_number, from_date),  -- Composite key: employee_number + from_date
    CONSTRAINT fk_employee FOREIGN KEY (employee_number) REFERENCES employees(employee_number)
);

CREATE TABLE employee_department (
    employee_number INT,                      -- Employee number, referencing the employees table
    department_id INT,                         -- Department ID, referencing the departments table
    from_date DATE NOT NULL,                   -- Date the employee started in this department
    to_date DATE,                              -- Date the employee left this department (NULL means current department)
    PRIMARY KEY (employee_number, department_id, from_date),  -- Composite key
    CONSTRAINT fk_employee FOREIGN KEY (employee_number) REFERENCES employees(employee_number),
    CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

SELECT employee_number, last_name, first_name, sex, salary
FROM employees;

SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

SELECT e.employee_number, e.last_name, e.first_name, e.department_id, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

SELECT e.employee_number, e.last_name, e.first_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name IN ('Sales', 'Development');

SELECT last_name, COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;
