# Airbnb Database Normalization

## Objective
The goal of normalization is to organize the Airbnb database schema to eliminate data redundancy and ensure data integrity.  
This process applies the principles of **First Normal Form (1NF)**, **Second Normal Form (2NF)**, and **Third Normal Form (3NF)**.

---

## Step 1: First Normal Form (1NF)

**Rule:**  
- Each table cell should hold a single value (atomicity).  
- Each record should be unique and identifiable by a **primary key**.

**Application to Airbnb Database:**
- Every table (`User`, `Property`, `Booking`, `Payment`, `Review`, `Message`) has a **primary key** (`user_id`, `property_id`, etc.).
- All attributes hold atomic values:
  - Example: `email` stores one email address per user.
  - `role` stores a single value from an ENUM.
- No repeating groups or arrays exist.

✅ **Result:** The database satisfies **1NF**.

---

## Step 2: Second Normal Form (2NF)

**Rule:**  
- The table must be in 1NF.  
- All non-key attributes must depend on the **whole primary key**, not just part of it.  
- This rule mainly applies to tables with **composite primary keys**.

**Application:**
- None of the tables use composite primary keys.  
- Each non-key attribute in every table depends fully on its table’s primary key:
  - In **Property**, attributes like `name`, `description`, and `pricepernight` depend entirely on `property_id`.
  - In **Booking**, attributes like `start_date`, `end_date`, and `status` depend on `booking_id`.

✅ **Result:** The database satisfies **2NF**.

---

## Step 3: Third Normal Form (3NF)

**Rule:**  
- The table must be in 2NF.  
- All attributes must depend **only on the primary key**, not on any other non-key attribute (no transitive dependencies).

**Application:**

| Table | Potential Transitive Dependencies | Action Taken |
|--------|-----------------------------------|---------------|
| **User** | None — all attributes depend only on `user_id`. | No change. |
| **Property** | `host_id` depends on `User`, but correctly defined as a **foreign key**, not a transitive dependency. | No change. |
| **Booking** | `property_id` and `user_id` are foreign keys, not transitive dependencies. | No change. |
| **Payment** | All attributes depend on `booking_id`; no derived or redundant attributes. | No change. |
| **Review** | All attributes depend directly on `review_id`; foreign keys link correctly. | No change. |
| **Message** | Each message depends solely on `message_id`. | No change. |

✅ **Result:** The schema satisfies **3NF**.

---

## Final Normalized Schema (3NF)

### **User**
| Attribute | Type | Notes |
|------------|------|-------|
| user_id | UUID | Primary Key |
| first_name | VARCHAR | NOT NULL |
| last_name | VARCHAR | NOT NULL |
| email | VARCHAR | UNIQUE, NOT NULL |
| password_hash | VARCHAR | NOT NULL |
| phone_number | VARCHAR | NULL |
| role | ENUM('guest', 'host', 'admin') | NOT NULL |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

---

### **Property**
| Attribute | Type | Notes |
|------------|------|-------|
| property_id | UUID | Primary Key |
| host_id | UUID | Foreign Key → User(user_id) |
| name | VARCHAR | NOT NULL |
| description | TEXT | NOT NULL |
| location | VARCHAR | NOT NULL |
| pricepernight | DECIMAL | NOT NULL |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | ON UPDATE CURRENT_TIMESTAMP |

---

### **Booking**
| Attribute | Type | Notes |
|------------|------|-------|
| booking_id | UUID | Primary Key |
| property_id | UUID | Foreign Key → Property(property_id) |
| user_id | UUID | Foreign Key → User(user_id) |
| start_date | DATE | NOT NULL |
| end_date | DATE | NOT NULL |
| total_price | DECIMAL | NOT NULL |
| status | ENUM('pending', 'confirmed', 'canceled') | NOT NULL |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

---

### **Payment**
| Attribute | Type | Notes |
|------------|------|-------|
| payment_id | UUID | Primary Key |
| booking_id | UUID | Foreign Key → Booking(booking_id) |
| amount | DECIMAL | NOT NULL |
| payment_date | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| payment_method | ENUM('credit_card', 'paypal', 'stripe') | NOT NULL |

---

### **Review**
| Attribute | Type | Notes |
|------------|------|-------|
| review_id | UUID | Primary Key |
| property_id | UUID | Foreign Key → Property(property_id) |
| user_id | UUID | Foreign Key → User(user_id) |
| rating | INTEGER | CHECK 1–5, NOT NULL |
| comment | TEXT | NOT NULL |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

---

### **Message**
| Attribute | Type | Notes |
|------------|------|-------|
| message_id | UUID | Primary Key |
| sender_id | UUID | Foreign Key → User(user_id) |
| recipient_id | UUID | Foreign Key → User(user_id) |
| message_body | TEXT | NOT NULL |
| sent_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

---

## ✅ **Conclusion**
After reviewing the Airbnb database schema:
- The design follows all normalization principles up to **Third Normal Form (3NF)**.
- There are **no redundant or transitive dependencies**.
- The schema ensures **data integrity, scalability, and consistency** across all entities.

---

**Deliverable:**  
- File: `normalization.md`  
- Location: Root of the repository (`alx-airbnb-database/`)
