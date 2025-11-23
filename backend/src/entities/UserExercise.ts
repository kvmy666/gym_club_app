import { Column, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn } from 'typeorm';
import { User } from './User';

@Entity({ name: 'user_exercises' })
export class UserExercise {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: number;

  @Column({ name: 'user_id', type: 'bigint' })
  userId!: number;

  @ManyToOne(() => User, (user) => user.userExercises, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'user_id' })
  user!: User;

  @Column({ length: 150 })
  name!: string;

  @Column({
    type: 'enum',
    enum: ['back', 'chest', 'legs', 'shoulders', 'core', 'arms', 'other'],
    default: 'other',
  })
  category!: 'back' | 'chest' | 'legs' | 'shoulders' | 'core' | 'arms' | 'other';

  @Column({ type: 'text', nullable: true })
  description!: string | null;

  @Column({ name: 'created_at', type: 'datetime', nullable: true })
  createdAt!: Date | null;

  @Column({ name: 'updated_at', type: 'datetime', nullable: true })
  updatedAt!: Date | null;
}
