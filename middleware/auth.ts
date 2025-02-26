import { Request, Response, NextFunction } from 'express';
import User from '../models/User';

declare global {
  namespace Express {
    interface Request {
      user?: User;
    }
  }
}

export const authenticate = async (req: Request, res: Response, next: NextFunction) => {
  const { username, password } = req.headers;

  if (!username || !password || typeof username !== 'string' || typeof password !== 'string') {
    return res.status(401).json({ message: 'Authentication credentials missing' });
  }

  try {
    const user = await User.findOne({ where: { username } });

    if (!user || !(await user.validatePassword(password))) {
      return res.status(401).json({ message: 'Invalid credentials' });
    }

    req.user = user;
    next();
  } catch (error) {
    console.error('Authentication error:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
};