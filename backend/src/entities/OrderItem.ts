import { Column, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn } from 'typeorm';
import { Order } from './Order';
import { Product } from './Product';

@Entity({ name: 'order_items' })
export class OrderItem {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: number;

  @Column({ name: 'order_id', type: 'bigint' })
  orderId!: number;

  @ManyToOne(() => Order, (order) => order.items, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'order_id' })
  order!: Order;

  @Column({ name: 'product_id', type: 'bigint' })
  productId!: number;

  @ManyToOne(() => Product, { onDelete: 'RESTRICT' })
  @JoinColumn({ name: 'product_id' })
  product!: Product;

  @Column({ type: 'int' })
  quantity!: number;

  @Column({ name: 'price_each', type: 'decimal', precision: 10, scale: 2 })
  priceEach!: string;

  @Column({ name: 'created_at', type: 'datetime', nullable: true })
  createdAt!: Date | null;
}
