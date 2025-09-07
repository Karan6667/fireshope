# FireShop E-Commerce Application with MongoDB

This is a full-stack e-commerce application built with React frontend and Node.js/Express backend connected to MongoDB.

## Features

- User authentication (register/login)
- Product catalog with filtering
- Shopping cart functionality
- Responsive design with Tailwind CSS
- MongoDB database integration

## 🚀 Quick Start (Automatic)

### Option 1: One-Click Launcher (Recommended)
1. **Double-click** `FireShop-Launcher.bat`
2. The launcher will automatically:
   - Check if Node.js is installed
   - Install dependencies if needed
   - Start the MongoDB server
   - Open the application in your browser

### Option 2: Command Line Auto-Start
```bash
npm run auto-start
```

### Option 3: Manual Setup
```bash
npm install
npm run dev
```

## 🔧 Setup Instructions

### 1. Install Dependencies

```bash
npm install
```

### 2. MongoDB Setup

#### Option A: Local MongoDB
1. Install MongoDB locally
2. Start MongoDB service
3. The application will connect to `mongodb://localhost:27017/fireshop`

#### Option B: MongoDB Compass
1. Open MongoDB Compass
2. Create a new connection or use existing connection
3. Create a database named `fireshop`
4. Update the connection string in `config.js` or set environment variables

#### Option C: MongoDB Atlas (Cloud)
1. Create a MongoDB Atlas account
2. Create a new cluster
3. Get your connection string
4. Update `MONGODB_URI` in your environment variables

### 3. Environment Configuration

Create a `.env` file in the root directory:

```env
MONGODB_URI=mongodb://localhost:27017/fireshop
JWT_SECRET=your-super-secret-jwt-key-change-this-in-production
PORT=5000
```

### 4. Start the Backend Server

```bash
# Development mode with auto-restart
npm run dev

# Or production mode
npm start
```

The server will start on `http://localhost:5000`

### 5. Open the Frontend

Open `all-mongodb.html` in your web browser to access the application.

## API Endpoints

### Authentication
- `POST /api/register` - User registration
- `POST /api/login` - User login

### Products
- `GET /api/products` - Get all products
- `GET /api/products/:id` - Get single product
- `POST /api/seed-products` - Seed initial products (development)

### Cart
- `GET /api/cart` - Get user's cart (requires authentication)
- `POST /api/cart/add` - Add item to cart (requires authentication)
- `PUT /api/cart/update` - Update cart item quantity (requires authentication)
- `DELETE /api/cart/remove/:productId` - Remove item from cart (requires authentication)
- `DELETE /api/cart/clear` - Clear entire cart (requires authentication)

### Health Check
- `GET /api/health` - Server health check

## Database Schema

### Users Collection
```javascript
{
  _id: ObjectId,
  email: String,
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
  userId: ObjectId (reference to Users),
  items: [{
    productId: ObjectId (reference to Products),
    quantity: Number,
    price: Number,
    name: String,
    image: String
  }],
  updatedAt: Date
}
```

## MongoDB Compass Connection

To connect with MongoDB Compass:

1. Open MongoDB Compass
2. Use connection string: `mongodb://localhost:27017`
3. Navigate to the `fireshop` database
4. You'll see three collections: `users`, `products`, and `carts`

## Development Notes

- The application automatically seeds initial products when first accessed
- JWT tokens are used for authentication
- Passwords are hashed using bcrypt
- CORS is enabled for frontend-backend communication
- The frontend is a single HTML file with React for easy deployment

## 🔄 Automatic Startup Options

### Windows Startup (Add to Startup Programs)
1. Press `Win + R`, type `shell:startup`, press Enter
2. Copy `startup-launcher.bat` to the startup folder
3. The server will start automatically when Windows boots

### Create Desktop Shortcut
1. Right-click on `FireShop-Launcher.bat`
2. Select "Create shortcut"
3. Move the shortcut to your desktop
4. Double-click to start the application anytime

### Windows Service (Advanced)
For production use, you can install the server as a Windows service using tools like:
- `node-windows` package
- `pm2` with `pm2-windows-service`

## 🛠️ Available Scripts

- `npm run auto-start` - Smart startup with dependency checking
- `npm run dev` - Development mode with auto-restart
- `npm start` - Production mode
- `npm run setup` - Install dependencies and start server

## 📁 Startup Files

- `FireShop-Launcher.bat` - Main launcher with GUI
- `startup-launcher.bat` - Simple startup script
- `auto-start.js` - Smart Node.js startup script
- `start-server.bat` - Windows batch startup
- `start-server.sh` - Linux/Mac startup script

## Troubleshooting

### Server won't start
- Check if MongoDB is running
- Verify the connection string in your configuration
- Ensure port 5000 is available
- Run `FireShop-Launcher.bat` for automatic diagnostics

### Frontend can't connect to backend
- Make sure the backend server is running on port 5000
- Check browser console for CORS errors
- Verify the API_BASE_URL in the frontend code
- Use the launcher to ensure proper startup sequence

### Database connection issues
- Check MongoDB service status
- Verify connection string format
- Ensure database permissions are correct
- The launcher will check MongoDB availability automatically

### Automatic Startup Issues
- Ensure Node.js is installed and in PATH
- Check that all files are in the same directory
- Run as administrator if needed
- Check Windows startup folder permissions
