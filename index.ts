import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import sequelize from './config/database';
import userRoutes from './routes/user';
import eventRoutes from './routes/event';
import moyentryRoutes from './routes/moyentry';

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Basic route
app.get('/', (req, res) => {
  res.json({ message: 'Welcome to MoiTech API' });
});

// API routes
app.use('/api/users', userRoutes);
app.use('/api/events', eventRoutes);
app.use('/api/moyentries', moyentryRoutes);

// Sync database
sequelize.sync({ force: false }).then(() => {
  console.log('Database synchronized');
}).catch((error) => {
  console.error('Error synchronizing database:', error);
});

// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

export { sequelize };