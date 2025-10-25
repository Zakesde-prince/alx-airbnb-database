# Airbnb Database ER Diagram Requirements

## Objective
Design and document an **Entity-Relationship (ER) diagram** for the Airbnb database system.  
The ER diagram must clearly define all **entities**, **attributes**, and **relationships** according to the database specification.

---

## Entities and Attributes

### 1. User
- **Primary Key:** `user_id` (UUID, Indexed)
- **Attributes:**
  - `first_name`: VARCHAR, NOT NULL  
  - `last_name`: VARCHAR, NOT NULL  
  - `email`: VARCHAR, UNIQUE, NOT NULL  
  - `password_hash`: VARCHAR, NOT NULL  
  - `phone_number`: VARCHAR, NULL  
  - `role`: ENUM('guest', 'host', 'admin'), NOT NULL  
  - `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP  

---

### 2. Property
- **Primary Key:** `property_id` (UUID, Indexed)
- **Foreign Key:** `host_id` → User(`user_id`)
- **Attributes:**
  - `name`: VARCHAR, NOT NULL  
  - `description`: TEXT, NOT NULL  
  - `location`: VARCHAR, NOT NULL  
  - `pricepernight`: DECIMAL, NOT NULL  
  - `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP  
  - `updated_at`: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP  

---

### 3. Booking
- **Primary Key:** `booking_id` (UUID, Indexed)
- **Foreign Keys:**  
  - `property_id` → Property(`property_id`)  
  - `user_id` → User(`user_id`)
- **Attributes:**
  - `start_date`: DATE, NOT NULL  
  - `end_date`: DATE, NOT NULL  
  - `total_price`: DECIMAL, NOT NULL  
  - `status`: ENUM('pending', 'confirmed', 'canceled'), NOT NULL  
  - `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP  

---

### 4. Payment
- **Primary Key:** `payment_id` (UUID, Indexed)
- **Foreign Key:** `booking_id` → Booking(`booking_id`)
- **Attributes:**
  - `amount`: DECIMAL, NOT NULL  
  - `payment_date`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP  
  - `payment_method`: ENUM('credit_card', 'paypal', 'stripe'), NOT NULL  

---

### 5. Review
- **Primary Key:** `review_id` (UUID, Indexed)
- **Foreign Keys:**  
  - `property_id` → Property(`property_id`)  
  - `user_id` → User(`user_id`)
- **Attributes:**
  - `rating`: INTEGER (CHECK: 1 ≤ rating ≤ 5), NOT NULL  
  - `comment`: TEXT, NOT NULL  
  - `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP  

---

### 6. Message
- **Primary Key:** `message_id` (UUID, Indexed)
- **Foreign Keys:**  
  - `sender_id` → User(`user_id`)  
  - `recipient_id` → User(`user_id`)
- **Attributes:**
  - `message_body`: TEXT, NOT NULL  
  - `sent_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP  

---

## Relationships

| Relationship | Type | Description |
|---------------|------|-------------|
| **User – Property** | 1 : M | A host (User) can own multiple properties. |
| **User – Booking** | 1 : M | A guest (User) can make multiple bookings. |
| **Property – Booking** | 1 : M | A property can have many bookings. |
| **Booking – Payment** | 1 : 1 | Each booking has exactly one payment. |
| **User – Review** | 1 : M | A user can post multiple reviews. |
| **Property – Review** | 1 : M | A property can have multiple reviews. |
| **User – Message** | M : M | Users can send and receive messages. |

---

## Indexing and Constraints

- **Primary Keys:** Automatically indexed.  
- **Additional Indexes:**  
  - `email` in the User table.  
  - `property_id` in Property and Booking.  
  - `booking_id` in Booking and Payment.  

- **Constraints:**
  - **User:** email must be unique; required fields cannot be NULL.  
  - **Property:** valid host_id reference.  
  - **Booking:** valid property_id and user_id references.  
  - **Payment:** valid booking_id reference.  
  - **Review:** rating between 1 and 5; valid property_id and user_id references.  
  - **Message:** valid sender_id and recipient_id references.  

---

## ER Diagram Instructions

1. Use **Draw.io (https://app.diagrams.net)** or another diagramming tool.
2. Create entities (rectangles) for each table listed above.
3. List attributes inside each entity box:
   - Primary keys marked as **PK**
   - Foreign keys marked as **FK**
4. Use **crow’s foot notation** to indicate relationships:
   - **1 → ∞** for one-to-many  
   - **1 ↔ 1** for one-to-one  
   - **∞ ↔ ∞** for many-to-many
5. Clearly label each relationship (e.g., *hosts*, *books*, *reviews*, *pays for*, *sends message*).
6. Export the diagram as `airbnb_erd.png` and store it in this directory (`ERD/`).

---

## Deliverables

- `requirements.md` (this file)
- `airbnb_erd.png` – visual ER diagram

---

### ✅ End of File
