import { Router } from 'express';
import { AppDataSource } from '../data-source';
import { CustomTrainingDay } from '../entities/CustomTrainingDay';

const router = Router();
const repo = () => AppDataSource.getRepository(CustomTrainingDay);

// List training days for a user
router.get('/users/:userId/training-days', async (req, res) => {
  try {
    const userId = Number(req.params.userId);
    const days = await repo().find({
      where: { userId },
      order: { displayOrder: 'ASC', createdAt: 'ASC' },
    });
    return res.json(days);
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: 'failed to fetch training days' });
  }
});

// Create training day
router.post('/users/:userId/training-days', async (req, res) => {
  try {
    const userId = Number(req.params.userId);
    const { name, displayOrder = 0 } = req.body;
    if (!name) return res.status(400).json({ error: 'name required' });
    const day = repo().create({ userId, name, displayOrder });
    await repo().save(day);
    return res.status(201).json(day);
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: 'failed to create training day' });
  }
});

// Update training day
router.patch('/training-days/:id', async (req, res) => {
  try {
    const id = Number(req.params.id);
    const { name, displayOrder } = req.body;
    const day = await repo().findOne({ where: { id } });
    if (!day) return res.status(404).json({ error: 'not found' });
    if (name) day.name = name;
    if (displayOrder !== undefined) day.displayOrder = displayOrder;
    await repo().save(day);
    return res.json(day);
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: 'failed to update training day' });
  }
});

// Delete training day
router.delete('/training-days/:id', async (req, res) => {
  try {
    const id = Number(req.params.id);
    const result = await repo().delete(id);
    if (!result.affected) return res.status(404).json({ error: 'not found' });
    return res.status(204).send();
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: 'failed to delete training day' });
  }
});

export default router;
