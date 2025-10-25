-- ===========================================================
-- Airbnb Database Seed Script
-- Repository: alx-airbnb-database
-- Directory: database-script-0x02
-- File: seed.sql
-- ===========================================================

-- Disable foreign key checks for clean inserts
SET FOREIGN_KEY_CHECKS = 0;

-- Clear existing data (optional)
TRUNCATE TABLE Message;
TRUNCATE TABLE Review;
TRUNCATE TABLE Payment;
TRUNCATE TABLE Booking;
TRUNCATE TABLE Property;
TRUNCATE TABLE `User`;

-- ===========================================================
-- 1. Insert Users
-- ===========================================================
INSERT INTO `User` (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
(UUID(), 'Alice', 'Johnson', 'alice@example.com', 'hashed_pwd_1', '1234567890', 'host', NOW()),
(UUID(), 'Bob', 'Smith', 'bob@example.com', 'hashed_pwd_2', '0987654321', 'guest', NOW()),
(UUID(), 'Carol', 'Davis', 'carol@example.com', 'hashed_pwd_3', NULL, 'guest', NOW()),
(UUID(), 'David', 'Brown', 'david@example.com', 'hashed_pwd_4', '5555555555', 'host', NOW());

-- ===========================================================
-- 2. Insert Properties
-- ===========================================================
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at)
VALUES
(UUID(), (SELECT user_id FROM `User` WHERE email='alice@example.com'),
 'Seaside Villa', 'A beautiful villa with ocean view.', 'Cape Town, South Africa', 1500.00, NOW(), NOW()),
(UUID(), (SELECT user_id FROM `User` WHERE email='david@example.com'),
 'Mountain Cabin', 'Cozy cabin in the Drakensberg mountains.', 'KwaZulu-Natal, South Africa', 850.00, NOW(), NOW());

-- ===========================================================
-- 3. Insert Bookings
-- ===========================================================
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES
(UUID(),
 (SELECT property_id FROM Property WHERE name='Seaside Villa'),
 (SELECT user_id FROM `User` WHERE email='bob@example.com'),
 '2025-12-10', '2025-12-15', 7500.00, 'confirmed', NOW()),
(UUID(),
 (SELECT property_id FROM Property WHERE name='Mountain Cabin'),
 (SELECT user_id FROM `User` WHERE email='carol@example.com'),
 '2025-11-05', '2025-11-09', 3400.00, 'pending', NOW());

-- ===========================================================
-- 4. Insert Payments
-- ===========================================================
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method)
VALUES
(UUID(),
 (SELECT booking_id FROM Booking WHERE status='confirmed'),
 7500.00, NOW(), 'credit_card');

-- ===========================================================
-- 5. Insert Reviews
-- ===========================================================
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at)
VALUES
(UUID(),
 (SELECT property_id FROM Property WHERE name='Seaside Villa'),
 (SELECT user_id FROM `User` WHERE email='bob@example.com'),
 5, 'Amazing place! Would definitely visit again.', NOW()),
(UUID(),
 (SELECT property_id FROM Property WHERE name='Mountain Cabin'),
 (SELECT user_id FROM `User` WHERE email='carol@example.com'),
 4, 'Great stay, very peaceful.', NOW());

-- ===========================================================
-- 6. Insert Messages
-- ===========================================================
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES
(UUID(),
 (SELECT user_id FROM `User` WHERE email='bob@example.com'),
 (SELECT user_id FROM `User` WHERE email='alice@example.com'),
 'Hi Alice, is your villa available for Christmas?', NOW()),
(UUID(),
 (SELECT user_id FROM `User` WHERE email='alice@example.com'),
 (SELECT user_id FROM `User` WHERE email='bob@example.com'),
 'Hi Bob! Yes, it is available. Would you like to book?', NOW());

-- ===========================================================
-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;

-- ===========================================================
-- End of Seed Script
-- ===========================================================
