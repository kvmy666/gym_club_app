import { Router } from 'express';
import { AppDataSource } from '../data-source';
import { UserExercise } from '../entities/UserExercise';

const router = Router();
const repo = () => AppDataSource.getRepository(UserExercise);

// Create or reuse a user exercise by name
router.post('/users/:userId/exercises', async (req, res) => {
  try {
    const userId = Number(req.params.userId);
    const { name, category = 'other', description = null } = req.body;
    if (!name || typeof name !== 'string') {
      return res.status(400).json({ error: 'name required' });
    }

    // check existing (case-insensitive match)
    const existing = await repo().findOne({
      where: { userId, name },
    });
    if (existing) {
      return res.json(existing);
    }

    const exercise = repo().create({
      userId,
      name,
      category,
      description,
    });
    await repo().save(exercise);
    return res.status(201).json(exercise);
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: 'failed to create exercise' });
  }
});

export default router;
