import express from 'express';

import User from '../models/User';

const router = express.Router();

// Login route
router.post('/login', async (req, res) => {
  const { username, password } = req.body;

  try {
    const user = await User.findOne({ where: { username } });

    if (!user || !(await user.validatePassword(password))) {
      return res.status(401).json({ message: 'Invalid credentials' });
    }

    return res.json({
      id: user.id,
      username: user.username,
      name: user.name
    });
  } catch (error) {
    console.error('Login error:', error);
    return res.status(500).json({ message: 'Internal server error' });
  }
});

// Create new user
router.post('/register', async (req, res) => {
  const { username, password, name } = req.body;

  try {
    const existingUser = await User.findOne({ where: { username } });
    if (existingUser) {
      return res.status(400).json({ message: 'Username already exists' });
    }

    const user = await User.create({
      username,
      password,
      name
    });

    return res.status(201).json({
      id: user.id,
      username: user.username,
      name: user.name
    });
  } catch (error) {
    console.error('Registration error:', error);
    return res.status(500).json({ message: 'Internal server error' });
  }
});

export default router;