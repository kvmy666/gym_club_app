import { Router } from 'express';
import { AppDataSource } from '../data-source';
import { WorkoutSession } from '../entities/WorkoutSession';
import { WorkoutSessionExercise } from '../entities/WorkoutSessionExercise';
import { WorkoutSet } from '../entities/WorkoutSet';

const router = Router();
const sessionRepo = () => AppDataSource.getRepository(WorkoutSession);
const sessionExerciseRepo = () => AppDataSource.getRepository(WorkoutSessionExercise);
const setRepo = () => AppDataSource.getRepository(WorkoutSet);

// List sessions for a user
router.get('/users/:userId/workouts', async (req, res) => {
  try {
    const userId = Number(req.params.userId);
    const sessions = await sessionRepo().find({
      where: { userId },
      order: { startedAt: 'DESC' },
    });
    return res.json(sessions);
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: 'failed to fetch workouts' });
  }
});

// Get session with exercises and sets
router.get('/workouts/:id', async (req, res) => {
  try {
    const id = Number(req.params.id);
    const session = await sessionRepo().findOne({
      where: { id },
      relations: ['exercises', 'exercises.sets'],
      order: {
        exercises: { displayOrder: 'ASC' },
      } as any,
    });
    if (!session) return res.status(404).json({ error: 'not found' });
    return res.json(session);
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: 'failed to fetch workout' });
  }
});

// Create a session
router.post('/users/:userId/workouts', async (req, res) => {
  try {
    const userId = Number(req.params.userId);
    const { trainingDayId = null, startedAt, endedAt = null, totalVolume = null, notes = null } = req.body;
    if (!startedAt) return res.status(400).json({ error: 'startedAt required' });
    const session = sessionRepo().create({
      userId,
      trainingDayId,
      startedAt: new Date(startedAt),
      endedAt: endedAt ? new Date(endedAt) : null,
      totalVolume,
      notes,
    });
    await sessionRepo().save(session);
    return res.status(201).json(session);
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: 'failed to create workout' });
  }
});

// Add exercise to a session
router.post('/workouts/:sessionId/exercises', async (req, res) => {
  try {
    const sessionId = Number(req.params.sessionId);
    const { exerciseType, exerciseId, displayOrder = 0 } = req.body;
    if (!exerciseType || !exerciseId) {
      return res.status(400).json({ error: 'exerciseType and exerciseId required' });
    }
    const exists = await sessionRepo().findOne({ where: { id: sessionId } });
    if (!exists) return res.status(404).json({ error: 'session not found' });
    const sessionExercise = sessionExerciseRepo().create({
      sessionId,
      exerciseType,
      exerciseId,
      displayOrder,
    });
    await sessionExerciseRepo().save(sessionExercise);
    return res.status(201).json(sessionExercise);
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: 'failed to add exercise' });
  }
});

// Add set to a session exercise
router.post('/workouts/exercises/:sessionExerciseId/sets', async (req, res) => {
  try {
    const sessionExerciseId = Number(req.params.sessionExerciseId);
    const { weight, reps, rpe = null, note = null, performedAt } = req.body;
    if (weight === undefined || reps === undefined || !performedAt) {
      return res.status(400).json({ error: 'weight, reps, performedAt required' });
    }
    const sessionExercise = await sessionExerciseRepo().findOne({
      where: { id: sessionExerciseId },
    });
    if (!sessionExercise) return res.status(404).json({ error: 'exercise not found' });
    const set = setRepo().create({
      sessionExerciseId,
      weight,
      reps,
      rpe,
      note,
      performedAt: new Date(performedAt),
    });
    await setRepo().save(set);
    return res.status(201).json(set);
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: 'failed to add set' });
  }
});

export default router;
