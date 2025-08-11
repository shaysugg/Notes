## Basic
* To get list of tables `\dt`
* Change type of a column 
```
ALTER TABLE cars  
ALTER COLUMN year TYPE VARCHAR(4);
```
* Set a default value for a **columns of all rows**
```
UPDATE users set device = 'unknown'
```
* Delete a column
```
ALTER TABLE cars  
DROP COLUMN color;
```
* Number of rows
```
SELECT COUNT(*) FROM customers;
```
* W can specify a column name inside the parentheses to get count of rows that have non-NULL column.


## HOW to add id to a existing table
1) Add id column
```sql
ALTER TABLE users ADD COLUMN id SERIAL;
```
2) update ids with unique values
```sql
UPDATE users SET id = <unique_value>;
```
3) make the id primary key
```sql
ALTER TABLE users ALTER COLUMN id SET NOT NULL;
ALTER TABLE users ADD PRIMARY KEY (id);
```

## Exists
Return all customers that is represented in the `orders` table:
```sql
SELECT customers.customer_name  
FROM customers  
WHERE EXISTS (  
  SELECT order_id  
  FROM orders  
  WHERE customer_id = customers.customer_id  
);
```
- Returns boolean (TRUE/FALSE)
- Stops searching once a match is found
- More efficient than IN for large datasets
- Typically faster than JOIN for existence checks

7. Performance Tip: EXISTS is often more performant than IN for checking existence, especially with large datasets.
## Union
for merging two queries that have compatible types
```sql
CREATE TABLE employees_north (
    employee_id INT,
    name VARCHAR(100),
    city VARCHAR(100)
);

CREATE TABLE employees_south (
    employee_id INT,
    name VARCHAR(100),
    city VARCHAR(100)
);

SELECT employee_id, name, city FROM employees_north
UNION
SELECT employee_id, name, city FROM employees_south;
```

## JOIN 
```SQL
SELECT messages.id, messages.content, messages.room_id, messages.sender_id, messages.create_date, users.name from messages
INNER JOIN users ON messages.sender_id = users.id
WHERE messages.id = "28602429-588d-49af-b6f2-123216aa3eb8";
```

## INSERT or UPDATE
If on certain conditions we want to update instead of insert we use a query like this.
The ones that we excluding will be updated.
```SQL
INSERT OR REPLACE INTO room_state (id, user_id, room_id, last_seen) VALUES ($1, $2, $3, $4)
ON CONFLICT(room_id, user_id)
DO UPDATE SET timestamp = ECLUDE.timestamp;
```
If we want to consider the row unique id as the condition of conflict then we can use:
```sql
INSERT OR REPLACE INTO table_name (column1, column2) 
VALUES (value1, value2);
```