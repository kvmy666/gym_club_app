import {
  Column,
  Entity,
  OneToMany,
  OneToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { UserProfile } from './UserProfile';
import { UserPreferences } from './UserPreferences';
import { CustomTrainingDay } from './CustomTrainingDay';
import { WorkoutSession } from './WorkoutSession';
import { AIConversation } from './AIConversation';
import { Cart } from './Cart';
import { Order } from './Order';
import { UserMembership } from './UserMembership';
import { UserExercise } from './UserExercise';

@Entity({ name: 'users' })
export class User {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: number;

  @Column({ length: 190, unique: true })
  email!: string;

  @Column({ name: 'password_hash', type: 'varchar', length: 255, nullable: true })
  passwordHash!: string | null;

  @Column({ name: 'external_auth_id', type: 'varchar', length: 190, nullable: true })
  externalAuthId!: string | null;

  @Column({ name: 'full_name', type: 'varchar', length: 150, nullable: true })
  fullName!: string | null;

  @Column({ type: 'enum', enum: ['male', 'female', 'other'], nullable: true })
  gender!: 'male' | 'female' | 'other' | null;

  @Column({ name: 'date_of_birth', type: 'date', nullable: true })
  dateOfBirth!: string | null;

  @Column({ name: 'created_at', type: 'datetime', nullable: true })
  createdAt!: Date | null;

  @Column({ name: 'updated_at', type: 'datetime', nullable: true })
  updatedAt!: Date | null;

  @OneToOne(() => UserProfile, (profile) => profile.user)
  profile!: UserProfile;

  @OneToOne(() => UserPreferences, (prefs) => prefs.user)
  preferences!: UserPreferences;

  @OneToMany(() => CustomTrainingDay, (day) => day.user)
  trainingDays!: CustomTrainingDay[];

  @OneToMany(() => WorkoutSession, (session) => session.user)
  sessions!: WorkoutSession[];

  @OneToMany(() => AIConversation, (conv) => conv.user)
  conversations!: AIConversation[];

  @OneToMany(() => Cart, (cart) => cart.user)
  carts!: Cart[];

  @OneToMany(() => Order, (order) => order.user)
  orders!: Order[];

  @OneToMany(() => UserMembership, (membership) => membership.user)
  memberships!: UserMembership[];

  @OneToMany(() => UserExercise, (exercise) => exercise.user)
  userExercises!: UserExercise[];
}
