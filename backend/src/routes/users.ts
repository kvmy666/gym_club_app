import { Router } from 'express';
import { AppDataSource } from '../data-source';
import { User } from '../entities/User';
import { UserProfile } from '../entities/UserProfile';
import { UserPreferences } from '../entities/UserPreferences';

const router = Router();
const userRepo = () => AppDataSource.getRepository(User);
const profileRepo = () => AppDataSource.getRepository(UserProfile);
const prefsRepo = () => AppDataSource.getRepository(UserPreferences);

// Create a user (minimal, no auth)
router.post('/users', async (req, res) => {
  try {
    const { email, passwordHash, fullName } = req.body;
    if (!email) return res.status(400).json({ error: 'email required' });
    const exists = await userRepo().findOne({ where: { email } });
    if (exists) return res.status(409).json({ error: 'email in use' });
    const user = userRepo().create({
      email,
      passwordHash: passwordHash ?? null,
      fullName: fullName ?? null,
    });
    await userRepo().save(user);
    // create default profile + prefs
    await profileRepo().save(profileRepo().create({ userId: user.id }));
    await prefsRepo().save(prefsRepo().create({ userId: user.id }));
    return res.status(201).json(user);
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: 'failed to create user' });
  }
});

// Get user with profile and preferences
router.get('/users/:id', async (req, res) => {
  try {
    const id = Number(req.params.id);
    const user = await userRepo().findOne({
      where: { id },
      relations: ['profile', 'preferences'],
    });
    if (!user) return res.status(404).json({ error: 'not found' });
    return res.json(user);
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: 'failed to fetch user' });
  }
});

export default router;
