import { Column, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn } from 'typeorm';
import { WorkoutSessionExercise } from './WorkoutSessionExercise';

@Entity({ name: 'workout_sets' })
export class WorkoutSet {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: number;

  @Column({ name: 'session_exercise_id', type: 'bigint' })
  sessionExerciseId!: number;

  @ManyToOne(() => WorkoutSessionExercise, (ex) => ex.sets, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'session_exercise_id' })
  sessionExercise!: WorkoutSessionExercise;

  @Column({ type: 'decimal', precision: 8, scale: 2 })
  weight!: string;

  @Column({ type: 'int' })
  reps!: number;

  @Column({ type: 'decimal', precision: 4, scale: 2, nullable: true })
  rpe!: string | null;

  @Column({ type: 'varchar', length: 255, nullable: true })
  note!: string | null;

  @Column({ name: 'performed_at', type: 'datetime' })
  performedAt!: Date;

  @Column({ name: 'created_at', type: 'datetime', nullable: true })
  createdAt!: Date | null;
}
