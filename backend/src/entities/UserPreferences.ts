import { Column, Entity, JoinColumn, OneToOne, PrimaryColumn } from 'typeorm';
import { User } from './User';

@Entity({ name: 'user_preferences' })
export class UserPreferences {
  @PrimaryColumn({ name: 'user_id', type: 'bigint' })
  userId!: number;

  @OneToOne(() => User, (user) => user.preferences, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'user_id' })
  user!: User;

  @Column({
    type: 'enum',
    enum: ['light', 'dark', 'system'],
    default: 'system',
  })
  theme!: 'light' | 'dark' | 'system';

  @Column({ length: 10, default: 'en' })
  language!: string;

  @Column({ name: 'notifications_enabled', type: 'tinyint', width: 1, default: 1 })
  notificationsEnabled!: boolean;

  @Column({ name: 'updated_at', type: 'datetime', nullable: true })
  updatedAt!: Date | null;
}
