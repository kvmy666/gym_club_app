import {
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { User } from './User';
import { MembershipPlan } from './MembershipPlan';
import { Admin } from './Admin';

@Entity({ name: 'user_memberships' })
export class UserMembership {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: number;

  @Column({ name: 'user_id', type: 'bigint' })
  userId!: number;

  @ManyToOne(() => User, (user) => user.memberships, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'user_id' })
  user!: User;

  @Column({ name: 'plan_id', type: 'bigint', nullable: true })
  planId!: number | null;

  @ManyToOne(() => MembershipPlan, { onDelete: 'SET NULL' })
  @JoinColumn({ name: 'plan_id' })
  plan!: MembershipPlan | null;

  @Column({ name: 'start_date', type: 'date' })
  startDate!: string;

  @Column({ name: 'end_date', type: 'date' })
  endDate!: string;

  @Column({ type: 'varchar', length: 255, nullable: true })
  notes!: string | null;

  @Column({ name: 'created_by_admin_id', type: 'bigint', nullable: true })
  createdByAdminId!: number | null;

  @ManyToOne(() => Admin, { onDelete: 'SET NULL' })
  @JoinColumn({ name: 'created_by_admin_id' })
  createdByAdmin!: Admin | null;

  @Column({ name: 'created_at', type: 'datetime', nullable: true })
  createdAt!: Date | null;

  @Column({ name: 'updated_at', type: 'datetime', nullable: true })
  updatedAt!: Date | null;
}
