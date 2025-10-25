# Airbnb Database Seed Script

## 📘 Overview
This directory contains the SQL script used to **populate** the Airbnb database with sample data.  
The data reflects realistic use cases, including multiple users (hosts and guests), properties, bookings, payments, reviews, and messages.

---

## 📄 Files
- **seed.sql** → Contains `INSERT` statements to populate all entities.

---

## 🧱 Tables Populated
| Table | Description |
|--------|--------------|
| **User** | Hosts and guests with roles and contact info. |
| **Property** | Listings created by hosts. |
| **Booking** | Reservations made by guests. |
| **Payment** | Transactions linked to bookings. |
| **Review** | Feedback and ratings on properties. |
| **Message** | Communication between users. |

---

## 🧪 How to Run

Make sure your schema (`schema.sql`) is already created in your database.

### **MySQL Command**
```bash
mysql -u your_username -p airbnb_db < seed.sql
