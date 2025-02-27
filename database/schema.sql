-- Drop existing tables if they exist
DROP TABLE IF EXISTS MaterialEntries;
DROP TABLE IF EXISTS MoyEntries;
DROP TABLE IF EXISTS Events;
DROP TABLE IF EXISTS Users;

-- Create Users table
CREATE TABLE Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create Events table
CREATE TABLE Events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    date TIMESTAMP NOT NULL,
    location VARCHAR(255) NOT NULL,
    event_type VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create MaterialEntries table
CREATE TABLE MaterialEntries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT NOT NULL,
    contributor_name VARCHAR(255) NOT NULL,
    material_type VARCHAR(50) NOT NULL,
    weight DECIMAL(10, 3) NOT NULL,
    description TEXT,
    place VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (event_id) REFERENCES Events(id) ON DELETE CASCADE
);

-- Create index for MaterialEntries
CREATE INDEX idx_materialentries_event_id ON MaterialEntries(event_id);

-- Create MoyEntries table
CREATE TABLE MoyEntries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT NOT NULL,
    contributor_name VARCHAR(255) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    notes TEXT,
    place VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (event_id) REFERENCES Events(id) ON DELETE CASCADE
);

-- Create indexes for better performance
CREATE INDEX idx_users_username ON Users(username);
CREATE INDEX idx_events_date ON Events(date);
CREATE INDEX idx_moyentries_event_id ON MoyEntries(event_id);

INSERT INTO Events (name, date, location, event_type) VALUES
('Kumar Wedding', '2024-02-15 10:00:00', 'Sri Mahal, Madurai', 'Wedding'),
('Rajan Housewarming', '2024-03-01 09:00:00', '123 New Street, Coimbatore', 'Housewarming');

INSERT INTO MoyEntries (event_id, contributor_name, amount, notes, place) VALUES
(1, 'Ramesh Kumar', 5000.00, 'Best wishes for the wedding', 'Madurai'),
(1, 'Lakshmi Devi', 10000.00, 'Blessings for the couple', 'Chennai'),
(2, 'Murugan', 2500.00, 'Happy housewarming', 'Coimbatore');

INSERT INTO Users (username, password, name) VALUES
('admin', '$2a$10$XKR6QZYkXoXnwP3JaLzQe.1Ym1oNTY4LzX5JZxW1rh9Uh8YDUTHPS', 'Admin User'),
('vendor1', '$2a$10$mX5Y9zK3Q4X1Z1X8J7Q2q.1Ym1oNTY4LzX5JZxW1rh9Uh8YDUTHPS', 'Vendor One'),
('vendor2', '$2a$10$pL5R2qN3K4X1Z1X8J7Q2q.1Ym1oNTY4LzX5JZxW1rh9Uh8YDUTHPS', 'Vendor Two');
-- Insert sample events
INSERT INTO Events (name, date, location, event_type) VALUES
('Kumar Wedding', '2024-02-15 10:00:00', 'Sri Mahal, Madurai', 'Wedding'),
('Rajan Housewarming', '2024-03-01 09:00:00', '123 New Street, Coimbatore', 'Housewarming'),
('Priya Wedding Reception', '2024-03-20 18:30:00', 'Green Gardens, Chennai', 'Wedding'),
('Muthu 60th Birthday', '2024-04-05 11:00:00', 'Hotel Royal, Salem', 'Birthday');

-- Insert sample moy entries
INSERT INTO MoyEntries (event_id, contributor_name, amount, notes) VALUES
(1, 'Ramesh Kumar', 5000.00, 'Best wishes for the wedding'),
(1, 'Lakshmi Devi', 10000.00, 'Blessings for the couple'),
(1, 'Senthil Family', 7500.00, 'Congratulations'),
(2, 'Murugan', 2500.00, 'Happy housewarming'),
(2, 'Velu Family', 3000.00, 'Best wishes for new home'),
(3, 'Rajesh', 5000.00, 'Congratulations to the newlyweds'),
(3, 'Meena', 7000.00, 'Best wishes'),
(4, 'Kannan Family', 2000.00, 'Happy birthday'),
(4, 'Selvi', 3000.00, 'Many more happy returns');

-- Insert sample material entries
INSERT INTO MaterialEntries (event_id, contributor_name, material_type, weight, description, place) VALUES
(1, 'Ramesh Kumar', 'Gold', 15.250, 'Gold chain', 'Madurai'),
(1, 'Lakshmi Devi', 'Silver', 100.000, 'Silver plates set', 'Chennai'),
(2, 'Murugan', 'Gold', 5.750, 'Gold ring', 'Coimbatore'),
(3, 'Rajesh', 'Diamond', 2.100, 'Diamond pendant', 'Chennai'),
(4, 'Kannan Family', 'Silver', 250.000, 'Silver gift items', 'Salem');


-- Create FinanceEntries table
CREATE TABLE FinanceEntries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT NOT NULL,
    type ENUM('INCOME', 'EXPENSE') NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    description VARCHAR(255) NOT NULL,
    date TIMESTAMP NOT NULL,
    category VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (event_id) REFERENCES Events(id) ON DELETE CASCADE
);

-- Create index for better performance
CREATE INDEX idx_financeentries_event_id ON FinanceEntries(event_id);
CREATE INDEX idx_financeentries_type ON FinanceEntries(type);