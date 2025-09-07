# FireShop API Documentation

## Base URL
```
http://localhost:5000/api
```

## Authentication
All protected routes require a JWT token in the Authorization header:
```
Authorization: Bearer <your-jwt-token>
```

---

## 🔐 Authentication APIs

### 1. User Registration
**POST** `/register`

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

**Response:**
```json
{
  "message": "User created successfully",
  "token": "jwt-token-here",
  "user": {
    "id": "user-id",
    "email": "user@example.com"
  }
}
```

### 2. User Login
**POST** `/login`

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

**Response:**
```json
{
  "message": "Login successful",
  "token": "jwt-token-here",
  "user": {
    "id": "user-id",
    "email": "user@example.com"
  }
}
```

### 3. Get User Profile
**GET** `/user/profile` 🔒

**Response:**
```json
{
  "_id": "user-id",
  "email": "user@example.com",
  "createdAt": "2024-01-01T00:00:00.000Z"
}
```

### 4. Update User Profile
**PUT** `/user/profile` 🔒

**Request Body:**
```json
{
  "email": "newemail@example.com"
}
```

### 5. Change Password
**PUT** `/user/change-password` 🔒

**Request Body:**
```json
{
  "currentPassword": "oldpassword",
  "newPassword": "newpassword123"
}
```

### 6. Verify JWT Token
**GET** `/verify-token` 🔒

**Response:**
```json
{
  "valid": true,
  "user": {
    "id": "user-id",
    "email": "user@example.com"
  }
}
```

---

## 🛍️ Product APIs (CRUD with Filters)

### 1. Get All Products with Filters
**GET** `/products`

**Query Parameters:**
- `category` - Filter by category (e.g., "electronics", "clothing")
- `minPrice` - Minimum price filter
- `maxPrice` - Maximum price filter
- `search` - Search in name and description
- `sortBy` - Sort field (default: "createdAt")
- `sortOrder` - Sort order: "asc" or "desc" (default: "desc")
- `page` - Page number for pagination (default: 1)
- `limit` - Items per page (default: 20)
- `inStock` - Filter only in-stock items ("true")

**Example:**
```
GET /api/products?category=electronics&minPrice=50&maxPrice=200&search=headphones&sortBy=price&sortOrder=asc&page=1&limit=10
```

**Response:**
```json
{
  "products": [
    {
      "_id": "product-id",
      "name": "Wireless Headphones",
      "price": 199.99,
      "category": "electronics",
      "image": "image-url",
      "description": "High-quality wireless headphones",
      "stock": 50,
      "createdAt": "2024-01-01T00:00:00.000Z"
    }
  ],
  "pagination": {
    "currentPage": 1,
    "totalPages": 5,
    "totalProducts": 50,
    "hasNext": true,
    "hasPrev": false
  }
}
```

### 2. Get Single Product
**GET** `/products/:id`

**Response:**
```json
{
  "_id": "product-id",
  "name": "Wireless Headphones",
  "price": 199.99,
  "category": "electronics",
  "image": "image-url",
  "description": "High-quality wireless headphones",
  "stock": 50,
  "createdAt": "2024-01-01T00:00:00.000Z"
}
```

### 3. Create New Product
**POST** `/products` 🔒

**Request Body:**
```json
{
  "name": "New Product",
  "price": 99.99,
  "category": "electronics",
  "image": "image-url",
  "description": "Product description",
  "stock": 25
}
```

### 4. Update Product
**PUT** `/products/:id` 🔒

**Request Body:**
```json
{
  "name": "Updated Product Name",
  "price": 149.99,
  "stock": 30
}
```

### 5. Delete Product
**DELETE** `/products/:id` 🔒

**Response:**
```json
{
  "message": "Product deleted successfully"
}
```

### 6. Get Product Categories
**GET** `/categories`

**Response:**
```json
[
  "electronics",
  "clothing",
  "home",
  "accessories"
]
```

---

## 🛒 Cart APIs

### 1. Get User's Cart
**GET** `/cart` 🔒

**Response:**
```json
{
  "_id": "cart-id",
  "userId": "user-id",
  "items": [
    {
      "productId": "product-id",
      "quantity": 2,
      "price": 199.99,
      "name": "Wireless Headphones",
      "image": "image-url"
    }
  ],
  "updatedAt": "2024-01-01T00:00:00.000Z"
}
```

### 2. Add Item to Cart
**POST** `/cart/add` 🔒

**Request Body:**
```json
{
  "productId": "product-id",
  "quantity": 1
}
```

**Response:**
```json
{
  "message": "Item added to cart",
  "cart": {
    // Updated cart object
  }
}
```

### 3. Update Cart Item Quantity
**PUT** `/cart/update` 🔒

**Request Body:**
```json
{
  "productId": "product-id",
  "quantity": 3
}
```

### 4. Remove Item from Cart
**DELETE** `/cart/remove/:productId` 🔒

**Response:**
```json
{
  "message": "Item removed from cart",
  "cart": {
    // Updated cart object
  }
}
```

### 5. Clear Entire Cart
**DELETE** `/cart/clear` 🔒

**Response:**
```json
{
  "message": "Cart cleared",
  "cart": {
    // Empty cart object
  }
}
```

### 6. Get Cart Item Count
**GET** `/cart/count` 🔒

**Response:**
```json
{
  "count": 5
}
```

### 7. Get Cart Total
**GET** `/cart/total` 🔒

**Response:**
```json
{
  "total": "199.99",
  "items": 2,
  "subtotal": "199.99",
  "tax": "16.00",
  "shipping": 5.00,
  "grandTotal": "220.99"
}
```

---

## 🛠️ Utility APIs

### 1. Health Check
**GET** `/health`

**Response:**
```json
{
  "message": "Server is running",
  "timestamp": "2024-01-01T00:00:00.000Z"
}
```

### 2. Seed Products (Development)
**POST** `/seed-products`

**Response:**
```json
{
  "message": "Products seeded successfully",
  "products": [
    // Array of created products
  ]
}
```

---

## 📝 Error Responses

All APIs return consistent error responses:

```json
{
  "error": "Error message description"
}
```

**Common HTTP Status Codes:**
- `200` - Success
- `201` - Created
- `400` - Bad Request
- `401` - Unauthorized (missing/invalid token)
- `403` - Forbidden (invalid token)
- `404` - Not Found
- `500` - Internal Server Error

---

## 🔧 Environment Variables

Create a `.env` file in your project root:

```env
MONGODB_URI=mongodb://localhost:27017/fireshop
JWT_SECRET=your-super-secret-jwt-key-change-this-in-production
PORT=5000
```

---

## 🚀 Getting Started

1. **Install dependencies:**
   ```bash
   npm install
   ```

2. **Start the server:**
   ```bash
   npm run dev
   ```

3. **Test the API:**
   ```bash
   curl http://localhost:5000/api/health
   ```

---

## 📊 Database Schema

### Users Collection
```javascript
{
  _id: ObjectId,
  email: String (unique),
  password: String (hashed),
  createdAt: Date
}
```

### Products Collection
```javascript
{
  _id: ObjectId,
  name: String,
  price: Number,
  category: String,
  image: String,
  description: String,
  stock: Number,
  createdAt: Date
}
```

### Carts Collection
```javascript
{
  _id: ObjectId,
  userId: ObjectId (ref: Users),
  items: [{
    productId: ObjectId (ref: Products),
    quantity: Number,
    price: Number,
    name: String,
    image: String
  }],
  updatedAt: Date
}
```

---

## 🔒 Security Features

- **JWT Authentication**: Secure token-based authentication
- **Password Hashing**: bcrypt for secure password storage
- **Input Validation**: Server-side validation for all inputs
- **CORS**: Cross-origin resource sharing enabled
- **Error Handling**: Comprehensive error handling and logging

---

## 📱 Frontend Integration

The API is designed to work seamlessly with the provided React frontend:

- **Authentication**: Login/signup pages with JWT token management
- **Product Display**: Filtered product listing with pagination
- **Shopping Cart**: Full cart functionality with real-time updates
- **User Management**: Profile management and password changes

All frontend components are already configured to use these APIs with proper error handling and loading states.
