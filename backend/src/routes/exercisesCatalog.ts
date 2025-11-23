import { Router } from 'express';
import { AppDataSource } from '../data-source';
import { Exercise } from '../entities/Exercise';

const router = Router();
const repo = () => AppDataSource.getRepository(Exercise);

router.get('/exercises', async (_req, res) => {
  try {
    // Some DBs may not have the is_global column yet; fall back to all rows.
    let items: Exercise[] = [];
    try {
      items = await repo().find({
        where: { isGlobal: true, isActive: true },
        order: { id: 'ASC' },
      });
    } catch (_) {
      items = await repo().find({ order: { id: 'ASC' } });
    }

    const payload = items.map((e) => ({
      id: e.id,
      name: e.name ?? 'Exercise',
      muscle_group: e.category ?? 'other',
      description: e.description ?? '',
      image_url: (e as any).imageUrl ?? 'default_placeholder.png',
    }));

    return res.json(payload);
  } catch (err) {
    console.error(err);

    const fallback = [
      {
        id: 1001,
        name: 'Barbell Bench Press',
        muscle_group: 'chest',
        description: 'Standard chest press',
        image_url: '',
      },
      {
        id: 1101,
        name: 'Deadlift',
        muscle_group: 'back',
        description: 'Heavy compound lift',
        image_url: '',
      },
      {
        id: 1501,
        name: 'Back Squat',
        muscle_group: 'legs',
        description: 'Leg strength builder',
        image_url: '',
      },
      {
        id: 1701,
        name: 'Plank',
        muscle_group: 'core',
        description: 'Core stability hold',
        image_url: '',
      },
    ];
    return res.json(fallback);
  }
});

export default router;
