import {
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
  Index,
} from 'typeorm';
import { AIConversation } from './AIConversation';

@Entity({ name: 'ai_messages' })
@Index(['conversationId', 'createdAt'])
export class AIMessage {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: number;

  @Column({ name: 'conversation_id', type: 'bigint' })
  conversationId!: number;

  @ManyToOne(() => AIConversation, (conv) => conv.messages, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'conversation_id' })
  conversation!: AIConversation;

  @Column({ type: 'enum', enum: ['user', 'assistant'] })
  role!: 'user' | 'assistant';

  @Column({ type: 'text' })
  content!: string;

  @Column({ name: 'created_at', type: 'datetime', nullable: true })
  createdAt!: Date | null;
}
