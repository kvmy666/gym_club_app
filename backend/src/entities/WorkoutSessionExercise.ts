import {
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { WorkoutSession } from './WorkoutSession';
import { WorkoutSet } from './WorkoutSet';

@Entity({ name: 'workout_session_exercises' })
export class WorkoutSessionExercise {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: number;

  @Column({ name: 'session_id', type: 'bigint' })
  sessionId!: number;

  @ManyToOne(() => WorkoutSession, (session) => session.exercises, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'session_id' })
  session!: WorkoutSession;

  @Column({
    name: 'exercise_type',
    type: 'enum',
    enum: ['global', 'user'],
  })
  exerciseType!: 'global' | 'user';

  @Column({ name: 'exercise_id', type: 'bigint' })
  exerciseId!: number;

  @Column({ name: 'display_order', type: 'int', default: 0 })
  displayOrder!: number;

  @Column({ name: 'total_volume', type: 'decimal', precision: 12, scale: 2, nullable: true })
  totalVolume!: string | null;

  @Column({ name: 'total_sets', type: 'int', nullable: true })
  totalSets!: number | null;

  @Column({ name: 'created_at', type: 'datetime', nullable: true })
  createdAt!: Date | null;

  @OneToMany(() => WorkoutSet, (set) => set.sessionExercise)
  sets!: WorkoutSet[];
}
