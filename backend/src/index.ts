import express from 'express';
import dotenv from 'dotenv';
import { AppDataSource } from './data-source';
import cors from 'cors';
import userRoutes from './routes/users';
import trainingRoutes from './routes/trainingDays';
import workoutRoutes from './routes/workouts';
import shopRoutes from './routes/productsAndCart';
import userExerciseRoutes from './routes/userExercises';
import exercisesCatalogRoutes from './routes/exercisesCatalog';
import authRoutes from './routes/auth';

dotenv.config();

const app = express();
app.use(express.json());
app.use(cors());

app.get('/health', (_req, res) => res.json({ ok: true }));

// Routes
app.use(userRoutes);
app.use(trainingRoutes);
app.use(workoutRoutes);
app.use(shopRoutes);
app.use(userExerciseRoutes);
app.use(exercisesCatalogRoutes);
app.use(authRoutes);

const port = Number(process.env.APP_PORT || 3000);

AppDataSource.initialize()
  .then(() => {
    app.listen(port, () => {
      console.log(`API running at http://localhost:${port}`);
    });
  })
  .catch((err) => {
    console.error('Failed to initialize data source', err);
    process.exit(1);
  });
