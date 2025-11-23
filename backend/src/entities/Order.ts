import {
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { User } from './User';
import { OrderItem } from './OrderItem';

@Entity({ name: 'orders' })
export class Order {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: number;

  @Column({ name: 'user_id', type: 'bigint' })
  userId!: number;

  @ManyToOne(() => User, (user) => user.orders, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'user_id' })
  user!: User;

  @Column({ name: 'total_amount', type: 'decimal', precision: 12, scale: 2 })
  totalAmount!: string;

  @Column({
    type: 'enum',
    enum: ['pending', 'paid', 'shipped', 'cancelled', 'refunded'],
    default: 'pending',
  })
  status!: 'pending' | 'paid' | 'shipped' | 'cancelled' | 'refunded';

  @Column({ name: 'payment_method', type: 'varchar', length: 100, nullable: true })
  paymentMethod!: string | null;

  @Column({ name: 'transaction_ref', type: 'varchar', length: 190, nullable: true })
  transactionRef!: string | null;

  @Column({ name: 'created_at', type: 'datetime', nullable: true })
  createdAt!: Date | null;

  @Column({ name: 'updated_at', type: 'datetime', nullable: true })
  updatedAt!: Date | null;

  @OneToMany(() => OrderItem, (item) => item.order)
  items!: OrderItem[];
}
