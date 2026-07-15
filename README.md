# 📂 Dataset Description

The project uses a relational Pizza Hut sales dataset consisting of four interconnected tables. Together, these tables capture customer orders, pizza details, pricing information, and product categories.

The dataset represents a real-world transactional database where each order can contain multiple pizza items with different sizes and prices.

---

## Database Tables

| Table | Description |
|---------|------------|
| **orders** | Stores every customer order with its unique order ID, order date, and order time. |
| **order_details** | Contains individual items within each order, including pizza ID and quantity purchased. |
| **pizzas** | Stores pizza size and pricing information for every pizza variant. |
| **pizza_types** | Contains pizza names, ingredients, and product categories. |

---

## Table Relationships

The dataset follows a normalized relational database structure.

```text
                 +----------------+
                 |     Orders     |
                 |----------------|
                 | order_id (PK)  |
                 | order_date     |
                 | order_time     |
                 +-------+--------+
                         |
                         |
                         |
                 +-------▼--------+
                 | Order Details  |
                 |----------------|
                 | order_details_id|
                 | order_id (FK)  |
                 | pizza_id (FK)  |
                 | quantity       |
                 +-------+--------+
                         |
                         |
                         |
                 +-------▼--------+
                 |     Pizzas     |
                 |----------------|
                 | pizza_id (PK)  |
                 | pizza_type_id  |
                 | size           |
                 | price          |
                 +-------+--------+
                         |
                         |
                         |
                 +-------▼--------+
                 |  Pizza Types   |
                 |----------------|
                 | pizza_type_id  |
                 | name           |
                 | category       |
                 | ingredients    |
                 +----------------+
```

---

## Database Design

The database is designed using normalization principles to eliminate redundancy and improve data integrity.

- Each order is stored only once.
- Multiple pizzas can belong to a single order.
- Pizza prices are maintained separately from order records.
- Pizza names and categories are stored independently to avoid duplication.
- Relationships are established using Primary Keys and Foreign Keys.

This design makes the database scalable, efficient, and suitable for business analytics.

---

# 🛠️ Technologies Used

The project was developed using the following tools and technologies.

| Technology | Purpose |
|------------|----------|
| **MySQL** | Database Management System |
| **SQL** | Data Extraction & Business Analysis |
| **MySQL Workbench** | Query Execution |
| **Git** | Version Control |
| **GitHub** | Project Hosting |
| **Markdown** | Documentation |
| **Power BI / Dashboard** | Data Visualization *(Dashboard Preview)* |

---

# 💡 SQL Concepts Demonstrated

This project demonstrates a wide range of SQL concepts commonly used in real-world business analytics.

### Data Retrieval

- SELECT
- DISTINCT
- WHERE
- ORDER BY
- LIMIT

---

### Aggregate Functions

- COUNT()
- SUM()
- AVG()
- MAX()
- MIN()

---

### Joins

- INNER JOIN

---

### Grouping

- GROUP BY
- HAVING

---

### Common Table Expressions (CTEs)

The project uses CTEs to simplify complex analytical queries and improve readability.

---

### Window Functions

Advanced SQL analytics have been implemented using:

- RANK()
- SUM() OVER()

These functions were used to rank pizzas within each category and calculate cumulative revenue.

---

### Business Calculations

The project includes several business metrics such as:

- Total Revenue
- Revenue Contribution
- Average Orders Per Day
- Category-wise Revenue
- Hourly Order Distribution
- Daily Sales Trend
- Cumulative Revenue
- Top Performing Products

---

# 📊 Business Questions Solved

The analysis answers the following business questions using SQL:

1. Retrieve the total number of orders placed.
2. Calculate the total revenue generated.
3. Identify the highest-priced pizza.
4. Determine the most common pizza size ordered.
5. List the top five most ordered pizza types.
6. Calculate total quantity sold for each pizza category.
7. Analyze the distribution of orders by hour.
8. Determine category-wise pizza distribution.
9. Calculate average pizzas sold per day.
10. Identify the top three pizzas by revenue within each category.
11. Calculate percentage contribution of each pizza category.
12. Analyze cumulative revenue over time.
13. Identify the top three revenue-generating pizzas.
