import { Column, Entity, JoinColumn, ManyToOne, OneToMany, PrimaryGeneratedColumn } from 'typeorm';
import { User } from './User';
import { CartItem } from './CartItem';

@Entity({ name: 'carts' })
export class Cart {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: number;

  @Column({ name: 'user_id', type: 'bigint', unique: true })
  userId!: number;

  @ManyToOne(() => User, (user) => user.carts, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'user_id' })
  user!: User;

  @Column({ name: 'updated_at', type: 'datetime', nullable: true })
  updatedAt!: Date | null;

  @OneToMany(() => CartItem, (item) => item.cart)
  items!: CartItem[];
}
