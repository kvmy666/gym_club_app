import 'reflect-metadata';
import { DataSource } from 'typeorm';
import { Admin } from './entities/Admin';
import { User } from './entities/User';
import { UserProfile } from './entities/UserProfile';
import { UserPreferences } from './entities/UserPreferences';
import { MembershipPlan } from './entities/MembershipPlan';
import { UserMembership } from './entities/UserMembership';
import { CustomTrainingDay } from './entities/CustomTrainingDay';
import { Exercise } from './entities/Exercise';
import { UserExercise } from './entities/UserExercise';
import { WorkoutSession } from './entities/WorkoutSession';
import { WorkoutSessionExercise } from './entities/WorkoutSessionExercise';
import { WorkoutSet } from './entities/WorkoutSet';
import { AIConversation } from './entities/AIConversation';
import { AIMessage } from './entities/AIMessage';
import { ProductCategory } from './entities/ProductCategory';
import { Product } from './entities/Product';
import { Cart } from './entities/Cart';
import { CartItem } from './entities/CartItem';
import { Order } from './entities/Order';
import { OrderItem } from './entities/OrderItem';
import dotenv from 'dotenv';

dotenv.config();

export const AppDataSource = new DataSource({
  type: 'mysql',
  host: process.env.DB_HOST || 'localhost',
  port: Number(process.env.DB_PORT || 3306),
  username: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME || 'gym_club_db',
  synchronize: false,
  logging: false,
  entities: [
    Admin,
    User,
    UserProfile,
    UserPreferences,
    MembershipPlan,
    UserMembership,
    CustomTrainingDay,
    Exercise,
    UserExercise,
    WorkoutSession,
    WorkoutSessionExercise,
    WorkoutSet,
    AIConversation,
    AIMessage,
    ProductCategory,
    Product,
    Cart,
    CartItem,
    Order,
    OrderItem,
  ],
});
