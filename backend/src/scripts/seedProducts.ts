import 'reflect-metadata';
import { AppDataSource } from '../data-source';
import { Product } from '../entities/Product';

type SeedProduct = {
  id: number;
  name: string;
  price: string;
  stock: number;
  categoryId?: number | null;
  imageUrl?: string | null;
  description?: string | null;
};

// Minimal product catalog to unblock the cart flow
const seedProducts: SeedProduct[] = [
  {
    id: 1,
    name: 'Protein Powder',
    price: '120.00',
    stock: 50,
    categoryId: null,
  },
  {
    id: 2,
    name: 'Creatine Monohydrate',
    price: '80.00',
    stock: 40,
    categoryId: null,
  },
  {
    id: 3,
    name: 'Adjustable Dumbbell',
    price: '300.00',
    stock: 15,
    categoryId: null,
  },
  {
    id: 4,
    name: 'Yoga Mat',
    price: '60.00',
    stock: 25,
    categoryId: null,
  },
];

async function seed() {
  await AppDataSource.initialize();
  const repo = AppDataSource.getRepository(Product);

  for (const p of seedProducts) {
    const exists = await repo.findOne({ where: { id: p.id } });
    if (exists) continue;
    await repo
      .createQueryBuilder()
      .insert()
      .into(Product)
      .values({
        id: p.id,
        name: p.name,
        price: p.price,
        stock: p.stock,
        categoryId: p.categoryId ?? null,
        description: p.description ?? null,
        imageUrl: p.imageUrl ?? null,
        isActive: true,
      })
      .execute();
  }

  await AppDataSource.destroy();
  console.log('Product seed completed');
}

seed().catch((err) => {
  console.error(err);
  process.exit(1);
});
