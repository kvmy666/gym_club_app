import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity({ name: 'admins' })
export class Admin {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: number;

  @Column({ length: 120 })
  name!: string;

  @Column({ length: 190, unique: true })
  email!: string;

  @Column({ name: 'password_hash', length: 255 })
  passwordHash!: string;

  @Column({ type: 'enum', enum: ['super_admin', 'manager', 'staff'], default: 'staff' })
  role!: 'super_admin' | 'manager' | 'staff';

  @Column({ name: 'created_at', type: 'datetime' })
  createdAt!: Date;

  @Column({ name: 'updated_at', type: 'datetime' })
  updatedAt!: Date;
}
