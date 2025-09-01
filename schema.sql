-- Create database
CREATE DATABASE IF NOT EXISTS event_management;
USE event_management;

-- Users table
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Events table
CREATE TABLE IF NOT EXISTS events (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  description TEXT,
  date DATE NOT NULL,
  location VARCHAR(100) NOT NULL,
  user_id INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  event_type VARCHAR(50) NOT NULL, -- Wedding, Birthday, Anniversary, Corporate, Social
  venue_type VARCHAR(50) NOT NULL, -- Hotel, Gardens, Banquet Halls
  veg_non_veg ENUM('Veg', 'Non-Veg', 'Both') NOT NULL,
  stay_accommodation BOOLEAN NOT NULL DEFAULT FALSE,
  area_size INT NOT NULL, -- in square feet
  capacity INT NOT NULL, -- number of people
  num_food_items INT NOT NULL,
  price_per_plate INT NOT NULL, -- in currency units
  image_url VARCHAR(255), -- Path to uploaded image (e.g., /uploads/image.jpg)
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

-- Event bookings table
CREATE TABLE IF NOT EXISTS event_bookings (
  id INT AUTO_INCREMENT PRIMARY KEY,
  event_id INT NOT NULL,
  user_id INT NOT NULL,
  event_date DATE NOT NULL, -- Date of the event booking
  booked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  UNIQUE KEY unique_booking (event_id, user_id)
);

-- Sample data
INSERT INTO users (name, email, password) VALUES
('Admin', 'admin@example.com', '$2b$10$Q1Xz1d7k5e2h2j5g8f4k9e0x3v7n9m2p5r8t1y4u7i0o3q6w9e2'); -- Password: admin123

INSERT INTO events (title, description, date, location, user_id, event_type, venue_type, veg_non_veg, stay_accommodation, area_size, capacity, num_food_items, price_per_plate, image_url) VALUES
('Grand Wedding', 'A luxurious wedding event', '2025-06-15', 'Delhi', 1, 'Wedding', 'Hotel', 'Both', TRUE, 5000, 300, 15, 1200, '/uploads/wedding.jpg'),
('Birthday Bash', 'A fun birthday celebration', '2025-07-20', 'Mumbai', 1, 'Birthday', 'Gardens', 'Veg', FALSE, 3000, 150, 10, 800, '/uploads/birthday.jpg'),
('Corporate Summit', 'Annual corporate conference', '2025-05-10', 'Bangalore', 1, 'Corporate', 'Banquet Halls', 'Non-Veg', TRUE, 4000, 200, 12, 1500, NULL),
('Anniversary Celebration', 'A romantic anniversary event', '2025-08-01', 'Chennai', 1, 'Anniversary', 'Hotel', 'Both', TRUE, 3500, 100, 8, 1000, NULL),
('Social Gathering', 'Community social event', '2025-09-15', 'Pune', 1, 'Social', 'Gardens', 'Veg', FALSE, 2000, 120, 5, 600, NULL),
('Mysore Royal Wedding', 'A grand wedding in Mysore', '2025-10-10', 'Mysore', 1, 'Wedding', 'Banquet Halls', 'Non-Veg', TRUE, 6000, 450, 20, 2000, NULL),
('Mysore Tech Conference', 'A tech conference in Mysore', '2025-11-05', 'Mysore', 1, 'Corporate', 'Hotel', 'Both', TRUE, 4500, 250, 14, 1800, NULL),
('Bangalore Social Fest', 'A festive social gathering', '2025-12-01', 'Bangalore', 1, 'Social', 'Banquet Halls', 'Veg', FALSE, 2800, 180, 7, 700, NULL),
('Delhi Kids Birthday', 'A kids birthday party in Delhi', '2025-06-20', 'Delhi', 1, 'Birthday', 'Hotel', 'Veg', FALSE, 3200, 130, 9, 900, NULL);