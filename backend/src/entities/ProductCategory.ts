import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity({ name: 'product_categories' })
export class ProductCategory {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: number;

  @Column({ length: 150 })
  name!: string;

  @Column({ length: 150, unique: true })
  slug!: string;

  @Column({ name: 'created_at', type: 'datetime', nullable: true })
  createdAt!: Date | null;
}
