-- Drop existing tables if they exist
DROP TABLE IF EXISTS MoyEntries;
DROP TABLE IF EXISTS Events;
DROP TABLE IF EXISTS Users;

-- Create Users table
# Events API Documentation

## Overview
The Events API allows users to manage events by performing CRUD (Create, Read, Update, Delete) operations.

## Base URL
```
http://localhost:3000/api/events
```

---

## 1. Get All Events
**Request:**  
```http
GET /api/events
```

**Response:**  
```json
[
    {
        "id": 1,
        "name": "Kumar Wedding",
        "date": "2024-02-15T10:00:00.000Z",
        "location": "Sri Mahal, Madurai",
        "event_type": "Wedding",
        "created_at": "2023-12-20T10:00:00.000Z",
        "updated_at": "2023-12-20T10:00:00.000Z"
    }
]
```

---

## 2. Get Event by ID
**Request:**  
```http
GET /api/events/{id}
```

**Example:**  
```http
GET /api/events/1
```

**Response:**  
```json
{
    "id": 1,
    "name": "Kumar Wedding",
    "date": "2024-02-15T10:00:00.000Z",
    "location": "Sri Mahal, Madurai",
    "event_type": "Wedding",
    "created_at": "2023-12-20T10:00:00.000Z",
    "updated_at": "2023-12-20T10:00:00.000Z"
}
```

---

## 3. Create a New Event
**Request:**  
```http
POST /api/events
```

**Headers:**  
```json
Content-Type: application/json
```

**Request Body:**  
```json
{
    "name": "Sample Event",
    "date": "2024-03-15T10:00:00.000Z",
    "location": "Sample Location",
    "event_type": "Wedding"
}
```

**Response:**  
```json
{
    "id": 2,
    "name": "Sample Event",
    "date": "2024-03-15T10:00:00.000Z",
    "location": "Sample Location",
    "event_type": "Wedding",
    "created_at": "2023-12-20T10:00:00.000Z",
    "updated_at": "2023-12-20T10:00:00.000Z"
}
```

---

## 4. Update an Event
**Request:**  
```http
PUT /api/events/{id}
```

**Example:**  
```http
PUT /api/events/1
```

**Headers:**  
```json
Content-Type: application/json
```

**Request Body:**  
```json
{
    "name": "Updated Event",
    "date": "2024-03-15T10:00:00.000Z",
    "location": "Updated Location",
    "event_type": "Birthday"
}
```

**Response:**  
```json
{
    "id": 1,
    "name": "Updated Event",
    "date": "2024-03-15T10:00:00.000Z",
    "location": "Updated Location",
    "event_type": "Birthday",
    "created_at": "2023-12-20T10:00:00.000Z",
    "updated_at": "2023-12-20T10:30:00.000Z"
}
```

---

## 5. Delete an Event
**Request:**  
```http
DELETE /api/events/{id}
```

**Example:**  
```http
DELETE /api/events/1
```

**Response:**  
```json
{
    "message": "Event deleted successfully",
    "deletedEvent": {
        "id": 1,
        "name": "Updated Event"
    }
}
```

---

## Error Responses
### 404 Not Found
```json
{
    "message": "Event not found"
}
```

### 400 Bad Request
```json
{
    "message": "Missing required fields",
    "required": ["name", "date", "location", "event_type"]
}
```

### 500 Internal Server Error
```json
{
    "message": "Internal server error",
    "error": "Error details here"
}
```

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

-- Insert sample data for testing
INSERT INTO Users (username, password, name) VALUES
('admin', '$2a$10$XKR6QZYkXoXnwP3JaLzQe.1Ym1oNTY4LzX5JZxW1rh9Uh8YDUTHPS', 'Admin User');

INSERT INTO Events (name, date, location, event_type) VALUES
('Kumar Wedding', '2024-02-15 10:00:00', 'Sri Mahal, Madurai', 'Wedding'),
('Rajan Housewarming', '2024-03-01 09:00:00', '123 New Street, Coimbatore', 'Housewarming');

INSERT INTO MoyEntries (event_id, contributor_name, amount, notes, place) VALUES
(1, 'Ramesh Kumar', 5000.00, 'Best wishes for the wedding', 'Madurai'),
(1, 'Lakshmi Devi', 10000.00, 'Blessings for the couple', 'Chennai'),
(2, 'Murugan', 2500.00, 'Happy housewarming', 'Coimbatore');

-- Insert sample users
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

-- Sample queries for the application

-- User authentication
-- SELECT id, username, password, name FROM Users WHERE username = $1;

-- Create new user
-- INSERT INTO Users (username, password, name) VALUES ($1, $2, $3) RETURNING id, username, name;

-- Get all events
-- SELECT * FROM Events ORDER BY date DESC;

-- Get event with moy entries
-- SELECT e.*, m.id as entry_id, m.contributor_name, m.amount, m.notes
-- FROM Events e
-- LEFT JOIN MoyEntries m ON e.id = m.event_id
-- WHERE e.id = $1;

-- Create new event
-- INSERT INTO Events (name, date, location, event_type) VALUES ($1, $2, $3, $4) RETURNING *;

-- Add moy entry
-- INSERT INTO MoyEntries (event_id, contributor_name, amount, notes)
-- VALUES ($1, $2, $3, $4) RETURNING *;

-- Get event summary
-- SELECT e.id, e.name,
--        COUNT(m.id) as total_entries,
--        COALESCE(SUM(m.amount), 0) as total_amount
-- FROM Events e
-- LEFT JOIN MoyEntries m ON e.id = m.event_id
-- WHERE e.id = $1
-- GROUP BY e.id, e.name;