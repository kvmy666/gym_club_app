import 'reflect-metadata';
import { AppDataSource } from '../data-source';
import { Exercise } from '../entities/Exercise';

type SeedRow = { id: number; name: string; muscle: string };

const seedData: SeedRow[] = [
  // Chest
  { id: 1001, name: 'Barbell Bench Press', muscle: 'chest' },
  { id: 1002, name: 'Incline Barbell Bench Press', muscle: 'chest' },
  { id: 1003, name: 'Flat Dumbbell Bench Press', muscle: 'chest' },
  { id: 1004, name: 'Incline Dumbbell Bench Press', muscle: 'chest' },
  { id: 1005, name: 'Decline Bench Press', muscle: 'chest' },
  { id: 1006, name: 'Chest Fly (Machine/Cable)', muscle: 'chest' },
  { id: 1007, name: 'Dumbbell Chest Fly (Flat)', muscle: 'chest' },
  { id: 1008, name: 'Push-ups', muscle: 'chest' },
  // Back
  { id: 1101, name: 'Deadlift', muscle: 'back' },
  { id: 1102, name: 'Conventional Barbell Row', muscle: 'back' },
  { id: 1103, name: 'One-Arm Dumbbell Row', muscle: 'back' },
  { id: 1104, name: 'Lat Pulldown (Wide Grip)', muscle: 'back' },
  { id: 1105, name: 'Seated Cable Row', muscle: 'back' },
  { id: 1106, name: 'Pull-ups / Chin-ups', muscle: 'back' },
  { id: 1107, name: 'T-Bar Row', muscle: 'back' },
  { id: 1108, name: 'Straight-Arm Cable Pulldown', muscle: 'back' },
  // Shoulders
  { id: 1201, name: 'Overhead Barbell Press', muscle: 'shoulders' },
  { id: 1202, name: 'Seated Dumbbell Shoulder Press', muscle: 'shoulders' },
  { id: 1203, name: 'Lateral Raise (Dumbbell)', muscle: 'shoulders' },
  { id: 1204, name: 'Front Raise (Dumbbell/Plate)', muscle: 'shoulders' },
  { id: 1205, name: 'Rear Delt Fly (Dumbbell)', muscle: 'shoulders' },
  { id: 1206, name: 'Rear Delt Fly (Machine/Cable)', muscle: 'shoulders' },
  { id: 1207, name: 'Arnold Press', muscle: 'shoulders' },
  { id: 1208, name: 'Upright Row (Barbell/Cable)', muscle: 'shoulders' },
  // Biceps -> arms
  { id: 1301, name: 'Barbell Curl', muscle: 'arms' },
  { id: 1302, name: 'Dumbbell Curl (Standing)', muscle: 'arms' },
  { id: 1303, name: 'Hammer Curl', muscle: 'arms' },
  { id: 1304, name: 'Incline Dumbbell Curl', muscle: 'arms' },
  { id: 1305, name: 'Preacher Curl (EZ Bar/Machine)', muscle: 'arms' },
  { id: 1306, name: 'Concentration Curl', muscle: 'arms' },
  // Triceps -> arms
  { id: 1401, name: 'Close-Grip Bench Press', muscle: 'arms' },
  { id: 1402, name: 'Triceps Pushdown (Cable)', muscle: 'arms' },
  { id: 1403, name: 'Overhead Triceps Extension', muscle: 'arms' },
  { id: 1404, name: 'Skull Crushers (EZ Bar)', muscle: 'arms' },
  { id: 1405, name: 'Bench Dips', muscle: 'arms' },
  { id: 1406, name: 'One-Arm Cable Triceps Extension', muscle: 'arms' },
  // Legs
  { id: 1501, name: 'Back Squat', muscle: 'legs' },
  { id: 1502, name: 'Front Squat', muscle: 'legs' },
  { id: 1503, name: 'Leg Press', muscle: 'legs' },
  { id: 1504, name: 'Walking Lunge', muscle: 'legs' },
  { id: 1505, name: 'Romanian Deadlift', muscle: 'legs' },
  { id: 1506, name: 'Leg Extension', muscle: 'legs' },
  { id: 1507, name: 'Lying Leg Curl', muscle: 'legs' },
  { id: 1508, name: 'Seated Leg Curl', muscle: 'legs' },
  { id: 1509, name: 'Bulgarian Split Squat', muscle: 'legs' },
  { id: 1510, name: 'Hack Squat', muscle: 'legs' },
  // Glutes -> legs
  { id: 1601, name: 'Barbell Hip Thrust', muscle: 'legs' },
  { id: 1602, name: 'Glute Bridge', muscle: 'legs' },
  { id: 1603, name: 'Cable Kickback', muscle: 'legs' },
  { id: 1604, name: 'Step-ups', muscle: 'legs' },
  { id: 1605, name: 'Smith Machine Squat', muscle: 'legs' },
  { id: 1606, name: 'Reverse Lunge', muscle: 'legs' },
  // Core
  { id: 1701, name: 'Plank', muscle: 'core' },
  { id: 1702, name: 'Hanging Leg Raise', muscle: 'core' },
  { id: 1703, name: 'Cable Crunch', muscle: 'core' },
  { id: 1704, name: 'Russian Twist', muscle: 'core' },
  { id: 1705, name: 'Bicycle Crunch', muscle: 'core' },
  { id: 1706, name: 'Sit-ups / Crunches', muscle: 'core' },
  { id: 1707, name: 'Ab-Wheel Rollout', muscle: 'core' },
  { id: 1708, name: 'Mountain Climbers', muscle: 'core' },
];

const validCategories = new Set([
  'back',
  'chest',
  'legs',
  'shoulders',
  'core',
  'arms',
  'other',
]);

function mapMuscleToCategory(muscle: string): string {
  const m = muscle.toLowerCase();
  if (validCategories.has(m)) return m;
  if (m === 'biceps' || m === 'triceps') return 'arms';
  if (m === 'glutes') return 'legs';
  return 'other';
}

async function seed() {
  await AppDataSource.initialize();
  const repo = AppDataSource.getRepository(Exercise);

  for (const row of seedData) {
    const category = mapMuscleToCategory(row.muscle);
    const existing = await repo.findOne({ where: { id: row.id } });
    if (existing) {
      continue;
    }
    await repo
      .createQueryBuilder()
      .insert()
      .into(Exercise)
      .values({
        id: row.id,
        name: row.name,
        category: category as any,
        isGlobal: true,
        isActive: true,
      })
      .execute();
  }

  await AppDataSource.destroy();
  console.log('Seed completed');
}

seed().catch((err) => {
  console.error(err);
  process.exit(1);
});
