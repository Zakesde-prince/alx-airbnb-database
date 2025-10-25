# Airbnb Database Schema (DDL)

## 📘 Overview
This directory contains SQL scripts that define the **Airbnb database schema**.  
The schema follows a **normalized design (3NF)** based on the Airbnb data model — ensuring data integrity, minimal redundancy, and efficient relationships between users, properties, bookings, payments, reviews, and messages.

---

## 📄 Files
- **schema.sql** → Contains all `CREATE TABLE` statements, primary keys, foreign keys, indexes, and constraints.

---

## 🧱 Entities Defined
### 1. User
Stores user account information for guests, hosts, and admins.

### 2. Property
Represents listings created by hosts.

### 3. Booking
Tracks reservations made by guests for specific properties.

### 4. Payment
Stores payment details associated with bookings.

### 5. Review
Contains reviews written by users about properties.

### 6. Message
Records private messages between users (sender and recipient).

---

## ⚙️ Constraints and Indexes
- **Primary Keys:** Each table has a unique UUID-based primary key.
- **Foreign Keys:** Maintain referential integrity between related entities.
- **Unique Constraints:** Applied on `User.email`.
- **Indexes:** Added for frequent query columns (`email`, `property_id`, `booking_id`, `host_id`).

---

## 🧩 Relationships
| Relationship | Type | Description |
|---------------|------|-------------|
| User → Property | 1 : M | A host owns multiple properties. |
| User → Booking | 1 : M | A guest can make multiple bookings. |
| Property → Booking | 1 : M | A property can be booked multiple times. |
| Booking → Payment | 1 : 1 | Each booking has one payment. |
| Property → Review | 1 : M | A property can have multiple reviews. |
| User → Review | 1 : M | A user can write multiple reviews. |
| User ↔ Message | M : M | Users can message each other. |

---

## 🧪 Usage
To create the database schema:

### **PostgreSQL**
```bash
psql -U your_username -d airbnb_db -f schema.sql
