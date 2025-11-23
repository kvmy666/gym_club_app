import {
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { User } from './User';
import { CustomTrainingDay } from './CustomTrainingDay';
import { WorkoutSessionExercise } from './WorkoutSessionExercise';

@Entity({ name: 'workout_sessions' })
export class WorkoutSession {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: number;

  @Column({ name: 'user_id', type: 'bigint' })
  userId!: number;

  @ManyToOne(() => User, (user) => user.sessions, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'user_id' })
  user!: User;

  @Column({ name: 'training_day_id', type: 'bigint', nullable: true })
  trainingDayId!: number | null;

  @ManyToOne(() => CustomTrainingDay, { onDelete: 'SET NULL' })
  @JoinColumn({ name: 'training_day_id' })
  trainingDay!: CustomTrainingDay | null;

  @Column({ name: 'started_at', type: 'datetime' })
  startedAt!: Date;

  @Column({ name: 'ended_at', type: 'datetime', nullable: true })
  endedAt!: Date | null;

  @Column({ name: 'total_volume', type: 'decimal', precision: 12, scale: 2, nullable: true })
  totalVolume!: string | null;

  @Column({ type: 'text', nullable: true })
  notes!: string | null;

  @Column({ name: 'created_at', type: 'datetime', nullable: true })
  createdAt!: Date | null;

  @OneToMany(() => WorkoutSessionExercise, (ex) => ex.session)
  exercises!: WorkoutSessionExercise[];
}
