import {
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { ProductCategory } from './ProductCategory';

@Entity({ name: 'products' })
export class Product {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: number;

  @Column({ name: 'category_id', type: 'bigint', nullable: true })
  categoryId!: number | null;

  @ManyToOne(() => ProductCategory, { onDelete: 'SET NULL' })
  @JoinColumn({ name: 'category_id' })
  category!: ProductCategory | null;

  @Column({ length: 180 })
  name!: string;

  @Column({ type: 'text', nullable: true })
  description!: string | null;

  @Column({ type: 'decimal', precision: 10, scale: 2 })
  price!: string;

  @Column({ type: 'int', default: 0 })
  stock!: number;

  @Column({ name: 'image_url', type: 'varchar', length: 255, nullable: true })
  imageUrl!: string | null;

  @Column({ name: 'is_active', type: 'tinyint', width: 1, default: 1 })
  isActive!: boolean;

  @Column({ name: 'created_at', type: 'datetime', nullable: true })
  createdAt!: Date | null;

  @Column({ name: 'updated_at', type: 'datetime', nullable: true })
  updatedAt!: Date | null;
}
