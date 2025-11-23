import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity({ name: 'membership_plans' })
export class MembershipPlan {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: number;

  @Column({ length: 120 })
  name!: string;

  @Column({ name: 'duration_days', type: 'int' })
  durationDays!: number;

  @Column({ type: 'decimal', precision: 10, scale: 2 })
  price!: string;

  @Column({ name: 'is_active', type: 'tinyint', width: 1, default: 1 })
  isActive!: boolean;

  @Column({ name: 'created_at', type: 'datetime', nullable: true })
  createdAt!: Date | null;

  @Column({ name: 'updated_at', type: 'datetime', nullable: true })
  updatedAt!: Date | null;
}
