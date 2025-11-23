import { Column, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn } from 'typeorm';
import { Cart } from './Cart';
import { Product } from './Product';

@Entity({ name: 'cart_items' })
export class CartItem {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: number;

  @Column({ name: 'cart_id', type: 'bigint' })
  cartId!: number;

  @ManyToOne(() => Cart, (cart) => cart.items, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'cart_id' })
  cart!: Cart;

  @Column({ name: 'product_id', type: 'bigint' })
  productId!: number;

  @ManyToOne(() => Product, { onDelete: 'RESTRICT' })
  @JoinColumn({ name: 'product_id' })
  product!: Product;

  @Column({ type: 'int', default: 1 })
  quantity!: number;

  @Column({ name: 'added_at', type: 'datetime', nullable: true })
  addedAt!: Date | null;
}
