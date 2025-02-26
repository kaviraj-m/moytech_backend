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

