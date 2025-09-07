// Configuration file for MongoDB connection
module.exports = {
  // MongoDB Connection String
  // Prefer env var, otherwise default to your Atlas URI
  MONGODB_URI: process.env.MONGODB_URI || 'mongodb+srv://ghatagekaran2_db_user:sTGBtebpfLUTr3kF@fire.awywi80.mongodb.net/?retryWrites=true&w=majority&appName=fire',

  // JWT Secret Key (change this to a secure random string in production)
  JWT_SECRET: process.env.JWT_SECRET || 'your-super-secret-jwt-key-change-this-in-production',

  // Server Port
  PORT: process.env.PORT || 5000
};
