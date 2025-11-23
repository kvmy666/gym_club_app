import { Column, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn } from 'typeorm';
import { Admin } from './Admin';

@Entity({ name: 'exercises' })
export class Exercise {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: number;

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

  @Column({ name: 'is_active', type: 'tinyint', width: 1, default: 1 })
  isActive!: boolean;

  @Column({ name: 'is_global', type: 'tinyint', width: 1, default: 1 })
  isGlobal!: boolean;

  @Column({ name: 'created_at', type: 'datetime', nullable: true })
  createdAt!: Date | null;

  @Column({ name: 'created_by_admin_id', type: 'bigint', nullable: true })
  createdByAdminId!: number | null;

  @ManyToOne(() => Admin, { onDelete: 'SET NULL' })
  @JoinColumn({ name: 'created_by_admin_id' })
  createdByAdmin!: Admin | null;
}
