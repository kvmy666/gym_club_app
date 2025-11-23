import { Router } from 'express';
import { AppDataSource } from '../data-source';
import { Product } from '../entities/Product';
import { Cart } from '../entities/Cart';
import { CartItem } from '../entities/CartItem';

const router = Router();
const productRepo = () => AppDataSource.getRepository(Product);
const cartRepo = () => AppDataSource.getRepository(Cart);
const cartItemRepo = () => AppDataSource.getRepository(CartItem);

// List active products (safely mapped to avoid nulls)
router.get('/products', async (_req, res) => {
  try {
    const products = await productRepo().find({ where: { isActive: true } });
    const payload = products.map((p) => ({
      id: p.id,
      name: p.name ?? 'Product',
      description: p.description ?? '',
      price: Number(p.price ?? 0) || 0,
      stock: p.stock ?? 0,
      categoryId: p.categoryId ?? null,
      imageUrl: (p as any).imageUrl ?? '',
      isActive: Boolean(p.isActive),
    }));
    return res.json(payload);
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: 'failed to fetch products' });
  }
});

// Get or create cart for user
router.get('/users/:userId/cart', async (req, res) => {
  try {
    const userId = Number(req.params.userId);
    let cart = await cartRepo().findOne({
      where: { userId },
      relations: ['items', 'items.product'],
    });
    if (!cart) {
      cart = cartRepo().create({ userId });
      await cartRepo().save(cart);
      cart.items = [];
    }
    return res.json(cart);
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: 'failed to fetch cart' });
  }
});

// Add item to cart
router.post('/users/:userId/cart/items', async (req, res) => {
  try {
    const userId = Number(req.params.userId);
    const { productId, quantity = 1 } = req.body;
    const pid = Number(productId);
    const qty = Number(quantity) || 1;
    if (!pid) return res.status(400).json({ error: 'productId required' });

    const product = await productRepo().findOne({ where: { id: pid, isActive: true } });
    if (!product) return res.status(404).json({ error: 'product not found or inactive' });

    let cart = await cartRepo().findOne({ where: { userId } });
    if (!cart) {
      cart = cartRepo().create({ userId });
      await cartRepo().save(cart);
    }
    const existing = await cartItemRepo().findOne({
      where: { cartId: cart.id, productId: pid },
    });
    if (existing) {
      existing.quantity += qty;
      await cartItemRepo().save(existing);
      const refreshed = await cartRepo().findOne({
        where: { id: cart.id },
        relations: ['items', 'items.product'],
      });
      return res.json(refreshed);
    }
    const item = cartItemRepo().create({
      cartId: cart.id,
      productId: pid,
      quantity: qty,
    });
    await cartItemRepo().save(item);
    const refreshed = await cartRepo().findOne({
      where: { id: cart.id },
      relations: ['items', 'items.product'],
    });
    return res.status(201).json(refreshed);
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: 'failed to add to cart' });
  }
});

// Update quantity
router.patch('/users/:userId/cart/items/:itemId', async (req, res) => {
  try {
    const itemId = Number(req.params.itemId);
    const { quantity } = req.body;
    if (quantity === undefined) return res.status(400).json({ error: 'quantity required' });
    const item = await cartItemRepo().findOne({ where: { id: itemId } });
    if (!item) return res.status(404).json({ error: 'not found' });
    item.quantity = Number(quantity);
    await cartItemRepo().save(item);
    return res.json(item);
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: 'failed to update item' });
  }
});

// Remove item
router.delete('/users/:userId/cart/items/:itemId', async (req, res) => {
  try {
    const itemId = Number(req.params.itemId);
    const item = await cartItemRepo().findOne({ where: { id: itemId } });
    if (!item) return res.status(404).json({ error: 'not found' });
    await cartItemRepo().delete(itemId);
    return res.status(204).send();
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: 'failed to remove item' });
  }
});

export default router;
