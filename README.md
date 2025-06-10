
# 🏋‍♂ Gym Membership System

A MySQL-based Gym Membership System designed to manage member data, trainers, subscriptions, attendance, and payments.

---

## 📂 Project Overview

This project simulates a gym's database system with features like:

- Member and Trainer registration
- Subscription tracking
- Payment processing
- Attendance monitoring
- Trainer assignments

---

## 🧱 Database Schema

The system includes the following main tables:

- *Members*: Stores personal details of gym members.
- *Trainers*: Details of trainers hired by the gym.
- *MembershipTypes*: Defines different membership packages.
- *Subscriptions*: Tracks which member has what membership and for how long.
- *Payments*: Records payment transactions.
- *Attendance*: Logs member attendance by date.
- *TrainerAssignments*: Links members with assigned trainers.

---

## 🛠 Technologies Used

- MySQL 8.x
- SQL (DDL, DML, Joins, Views, Procedures, Triggers)
- Excel (for initial data population)
- Python (for automation and file creation)

---

## 🚀 How to Use

1. *Create the database* and import the tables using provided SQL queries.
2. *Insert data* into the tables using the .sql or .xlsx files provided.
3. Use the *50+ sample queries* (basic + advanced) to explore and analyze the data.

---


📑 Features Covered in SQL

✅ Basic SELECT, WHERE, ORDER BY, LIKE, BETWEEN

✅ JOINs (INNER, LEFT)

✅ Aggregate functions (COUNT, SUM, AVG)

✅ GROUP BY & HAVING

✅ Views

✅ Stored Procedures

✅ Triggers

✅ Transactions

✅ Indexes

✅ Events

✅ User-Defined Functions

✅ Subqueries & Nested SELECTs



---

📄 Files Included

- GYM_System_datas.sql: Sample data (100 rows)
- GYM_System_Queries.sql: 50  Full SQL guide with basic and advanced topics
- GYM_System.sql:data base and table creation


---

👨‍💻 Author

kameshwaran

--GitHub: https://github.com/KAMESHWARANSASI

--Email:kameshwaransasi@gmail.com


## 📘 Example SQL Queries

```sql
-- Get all members
SELECT * FROM Members;

-- Join Members and Payments
SELECT m.FirstName, m.LastName, p.Amount
FROM Members m
JOIN Payments p ON m.MemberID = p.MemberID;

-- Create Stored Procedure
DELIMITER //
CREATE PROCEDURE GetMemberInfo(IN mem_id INT)
BEGIN
    SELECT * FROM Members WHERE MemberID = mem_id;
END //
DELIMITER ;


---




