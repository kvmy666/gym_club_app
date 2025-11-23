import { Column, Entity, JoinColumn, OneToOne, PrimaryColumn } from 'typeorm';
import { User } from './User';

@Entity({ name: 'user_profiles' })
export class UserProfile {
  @PrimaryColumn({ name: 'user_id', type: 'bigint' })
  userId!: number;

  @OneToOne(() => User, (user) => user.profile, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'user_id' })
  user!: User;

  @Column({ name: 'height_cm', type: 'decimal', precision: 5, scale: 2, nullable: true })
  heightCm!: string | null;

  @Column({ name: 'weight_kg', type: 'decimal', precision: 5, scale: 2, nullable: true })
  weightKg!: string | null;

  @Column({
    type: 'enum',
    enum: ['lose', 'maintain', 'gain'],
    nullable: true,
  })
  goal!: 'lose' | 'maintain' | 'gain' | null;

  @Column({
    name: 'activity_level',
    type: 'enum',
    enum: ['sedentary', 'light', 'moderate', 'active', 'very_active'],
    nullable: true,
  })
  activityLevel!: 'sedentary' | 'light' | 'moderate' | 'active' | 'very_active' | null;

  @Column({ name: 'calculated_calories', type: 'int', nullable: true })
  calculatedCalories!: number | null;

  @Column({ name: 'updated_at', type: 'datetime', nullable: true })
  updatedAt!: Date | null;
}
