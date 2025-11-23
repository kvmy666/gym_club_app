import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';

export interface AuthRequest extends Request {
  userId?: number;
}

export function authMiddleware(
  req: AuthRequest,
  res: Response,
  next: NextFunction,
) {
  const header = req.headers.authorization;
  if (!header) return res.status(401).json({ error: 'unauthorized' });
  const [, token] = header.split(' ');
  try {
    const decoded = jwt.verify(
      token,
      process.env.JWT_SECRET || 'devsecret',
    ) as jwt.JwtPayload;
    const sub = decoded.sub;
    const userId = typeof sub === 'string' ? Number(sub) : sub;
    if (!userId || Number.isNaN(userId)) {
      return res.status(401).json({ error: 'invalid token' });
    }
    req.userId = userId as number;
    return next();
  } catch (err) {
    return res.status(401).json({ error: 'invalid token' });
  }
}
