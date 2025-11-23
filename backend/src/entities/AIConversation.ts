import { Column, Entity, JoinColumn, ManyToOne, OneToMany, PrimaryGeneratedColumn } from 'typeorm';
import { User } from './User';
import { AIMessage } from './AIMessage';

@Entity({ name: 'ai_conversations' })
export class AIConversation {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: number;

  @Column({ name: 'user_id', type: 'bigint' })
  userId!: number;

  @ManyToOne(() => User, (user) => user.conversations, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'user_id' })
  user!: User;

  @Column({ type: 'varchar', length: 200, nullable: true })
  title!: string | null;

  @Column({ name: 'created_at', type: 'datetime', nullable: true })
  createdAt!: Date | null;

  @Column({ name: 'updated_at', type: 'datetime', nullable: true })
  updatedAt!: Date | null;

  @OneToMany(() => AIMessage, (msg) => msg.conversation)
  messages!: AIMessage[];
}
