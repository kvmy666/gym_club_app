import { Router } from 'express';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import { AppDataSource } from '../data-source';
import { User } from '../entities/User';
import { authMiddleware, AuthRequest } from '../middleware/authMiddleware';

const router = Router();
const repo = () => AppDataSource.getRepository(User);

const JWT_SECRET: jwt.Secret = process.env.JWT_SECRET || 'devsecret';
const JWT_EXPIRES_IN = process.env.JWT_EXPIRES_IN || '7d';

function signToken(userId: number) {
  return jwt.sign({ sub: userId }, JWT_SECRET, {
    expiresIn: JWT_EXPIRES_IN,
  } as jwt.SignOptions);
}

router.post('/auth/register', async (req, res) => {
  try {
    const { email, password, firstName, lastName, gender } = req.body;
    if (!email || !password) {
      return res.status(400).json({ error: 'email and password required' });
    }
    const existing = await repo().findOne({ where: { email } });
    if (existing) {
      return res.status(409).json({ error: 'email already in use' });
    }
    const passwordHash = await bcrypt.hash(password, 10);
    const fullName = [firstName, lastName]
        .map((e) => (typeof e === 'string' ? e.trim() : ''))
        .filter((e) => e.length > 0)
        .join(' ')
        .trim();
    const user = repo().create({ email, passwordHash, fullName, gender });
    await repo().save(user);
    const token = signToken(user.id);
    return res.status(201).json({ token, user: { id: user.id, email: user.email } });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: 'failed to register' });
  }
});

router.post('/auth/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    if (!email || !password) {
      return res.status(400).json({ error: 'email and password required' });
    }
    const user = await repo().findOne({ where: { email } });
    if (!user || !user.passwordHash) {
      return res.status(401).json({ error: 'invalid credentials' });
    }
    const ok = await bcrypt.compare(password, user.passwordHash);
    if (!ok) return res.status(401).json({ error: 'invalid credentials' });
    const token = signToken(user.id);
    return res.json({ token, user: { id: user.id, email: user.email } });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: 'failed to login' });
  }
});

router.get('/auth/me', authMiddleware, async (req: AuthRequest, res) => {
  try {
    const user = await repo().findOne({ where: { id: req.userId } });
    if (!user) return res.status(404).json({ error: 'not found' });
    return res.json({
      id: user.id,
      email: user.email,
      fullName: user.fullName,
      gender: user.gender,
    });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: 'failed to load user' });
  }
});

export default router;
