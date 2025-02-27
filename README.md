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

# Finance API Documentation

## Base URL
```
http://localhost:3000/api/finance
```

## 1. Get All Finance Entries
**Request:**
```http
GET http://localhost:3000/api/finance
```
**Response:**
```json
[
    {
        "id": 1,
        "event_id": 1,
        "type": "INCOME",
        "amount": 5000.00,
        "description": "Ticket sales",
        "date": "2024-01-15T10:00:00Z",
        "category": "Sales",
        "created_at": "2024-01-15T10:00:00.000Z",
        "updated_at": "2024-01-15T10:00:00.000Z"
    }
]
```

## 2. Get Event Finance Summary
**Request:**
```http
GET http://localhost:3000/api/finance/event/1
```
**Response:**
```json
{
    "total_income": 7000.00,
    "total_expense": 3000.00,
    "balance": 4000.00,
    "entries": [
        {
            "id": 1,
            "event_id": 1,
            "type": "INCOME",
            "amount": 5000.00,
            "description": "Ticket sales",
            "date": "2024-01-15T10:00:00Z",
            "category": "Sales"
        }
    ]
}
```

## 3. Get Detailed Summary by Event
**Request:**
```http
GET http://localhost:3000/api/finance/detailed-summary/1
```
**Response:**
```json
{
    "event_id": "1",
    "total_income": 7000.00,
    "total_expense": 3000.00,
    "balance": 4000.00,
    "income_entries": [
        {
            "id": 1,
            "event_id": 1,
            "type": "INCOME",
            "amount": 5000.00,
            "description": "Ticket sales",
            "date": "2024-01-15T10:00:00Z",
            "category": "Sales"
        }
    ],
    "expense_entries": [
        {
            "id": 2,
            "event_id": 1,
            "type": "EXPENSE",
            "amount": 3000.00,
            "description": "Venue booking",
            "date": "2024-01-15T10:00:00Z",
            "category": "Venue"
        }
    ]
}
```

## 4. Get Overall Finance Summary
**Request:**
```http
GET http://localhost:3000/api/finance/summary
```
**Response:**
```json
{
    "total_income": 15000.00,
    "total_expense": 8000.00,
    "balance": 7000.00,
    "by_category": {}
}
```

## 5. Create Income Entry
**Request:**
```http
POST http://localhost:3000/api/finance/income
```
**Headers:**
```
Content-Type: application/json
```
**Body:**
```json
{
    "event_id": 1,
    "amount": 5000.00,
    "description": "Ticket sales",
    "date": "2024-01-15T10:00:00Z",
    "category": "Sales"
}
```

## 6. Create Expense Entry
**Request:**
```http
POST http://localhost:3000/api/finance/expense
```
**Headers:**
```
Content-Type: application/json
```
**Body:**
```json
{
    "event_id": 1,
    "amount": 3000.00,
    "description": "Venue booking",
    "date": "2024-01-15T10:00:00Z",
    "category": "Venue"
}
```

## 7. Update Finance Entry
**Request:**
```http
PUT http://localhost:3000/api/finance/1
```
**Headers:**
```
Content-Type: application/json
```
**Body:**
```json
{
    "event_id": 1,
    "amount": 6000.00,
    "description": "Updated ticket sales",
    "date": "2024-01-15T10:00:00Z",
    "category": "Sales"
}
```

## 8. Delete Finance Entry
**Request:**
```http
DELETE http://localhost:3000/api/finance/1
```

## Error Responses

### 400 Bad Request
```json
{
    "message": "Missing or invalid required fields",
    "required": ["event_id", "amount", "description", "date", "category"],
    "received": {
        // received data
    }
}
```

### 404 Not Found
```json
{
    "message": "Entry not found"
}
```

### 500 Internal Server Error
```json
{
    "message": "Internal server error"
}
```

**Notes:**
- All amounts must be positive numbers
- Dates must be in ISO 8601 format
- Required fields: event_id, amount, description, date, category
- Type is automatically set for income/expense creation
- Categories can be: "Sales", "Venue", "Catering", "Decoration", etc.

# Material Entries API Documentation

## Base URL
```
http://localhost:3000/api/materialentries
```

## 1. Get All Material Entries
**Request:**
```http
GET http://localhost:3000/api/materialentries
```
**Response:**
```json
[
    {
        "id": 1,
        "event_id": 1,
        "contributor_name": "Ramesh Kumar",
        "material_type": "Gold",
        "weight": 15.250,
        "description": "Gold chain",
        "place": "Madurai",
        "created_at": "2024-01-15T10:00:00.000Z",
        "updated_at": "2024-01-15T10:00:00.000Z"
    }
]
```

## 2. Get Material Entries by Event ID
**Request:**
```http
GET http://localhost:3000/api/materialentries/event/1
```
**Response:**
```json
[
    {
        "id": 1,
        "event_id": 1,
        "contributor_name": "Ramesh Kumar",
        "material_type": "Gold",
        "weight": 15.250,
        "description": "Gold chain",
        "place": "Madurai",
        "created_at": "2024-01-15T10:00:00.000Z",
        "updated_at": "2024-01-15T10:00:00.000Z"
    }
]
```

## 3. Create New Material Entry
**Request:**
```http
POST http://localhost:3000/api/materialentries
```
**Headers:**
```
Content-Type: application/json
```
**Body:**
```json
{
    "contributor_name": "John Doe",
    "material_type": "Gold",
    "weight": 10.500,
    "description": "Gold necklace",
    "event_id": 1,
    "place": "Chennai"
}
```
**Response (201 Created):**
```json
{
    "id": 2,
    "event_id": 1,
    "contributor_name": "John Doe",
    "material_type": "Gold",
    "weight": 10.500,
    "description": "Gold necklace",
    "place": "Chennai",
    "created_at": "2024-01-15T10:30:00.000Z",
    "updated_at": "2024-01-15T10:30:00.000Z"
}
```

## 4. Update Material Entry
**Request:**
```http
PUT http://localhost:3000/api/materialentries/1
```
**Headers:**
```
Content-Type: application/json
```
**Body:**
```json
{
    "contributor_name": "John Doe Updated",
    "material_type": "Silver",
    "weight": 100.000,
    "description": "Silver items",
    "place": "Madurai",
    "event_id": 1
}
```
**Response:**
```json
{
    "id": 1,
    "event_id": 1,
    "contributor_name": "John Doe Updated",
    "material_type": "Silver",
    "weight": 100.000,
    "description": "Silver items",
    "place": "Madurai",
    "created_at": "2024-01-15T10:00:00.000Z",
    "updated_at": "2024-01-15T11:00:00.000Z"
}
```

## 5. Delete Material Entry
**Request:**
```http
DELETE http://localhost:3000/api/materialentries/1
```
**Response:**
```json
{
    "message": "Material entry deleted successfully",
    "deletedEntry": {
        "id": 1,
        "contributor_name": "John Doe Updated",
        "material_type": "Silver"
    }
}
```

## Error Responses

### 400 Bad Request
```json
{
    "message": "Missing or invalid required fields",
    "required": ["contributor_name", "material_type", "weight", "event_id"],
    "received": {
        // received data
    }
}
```

### 404 Not Found
```json
{
    "message": "Material entry not found"
}
```

### 500 Internal Server Error
```json
{
    "message": "Internal server error",
    "error": "Error details here"
}
```

## Notes
- All weights are in grams with up to 3 decimal places.
- Material types can be: "Gold", "Silver", "Diamond", etc.
- Description and place fields are optional.
- All timestamps are in ISO 8601 format.
