import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../l10n/app_localizations.dart';
import 'models/cart_models.dart';
import 'models/product.dart';
import 'providers/shop_providers.dart';

class ShopScreen extends ConsumerStatefulWidget {
  const ShopScreen({super.key});

  @override
  ConsumerState<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends ConsumerState<ShopScreen> {
  int selected = 0;
  final NumberFormat _sarFormatter =
      NumberFormat.currency(locale: 'ar_SA', symbol: 'SAR ', decimalDigits: 2);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final products = ref.watch(productsProvider);
    final cart = ref.watch(cartProvider);
    final action = ref.read(cartActionProvider);
    final categories = _buildCategories(products.asData?.value ?? const []);
    final visibleProducts = _filterProducts(
      products.asData?.value ?? const [],
      categories,
      selected,
    );
    final cartItems = cart.asData?.value.items ?? const <CartItemModel>[];
    final cartCount =
        cartItems.fold<int>(0, (sum, item) => sum + item.quantity);
    final cartTotal = _calcTotal(cartItems);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.shopTitle),
        actions: [
          IconButton(
            onPressed: () => _refresh(),
            icon: const Icon(Icons.refresh),
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => _showCartDetails(l10n, cartItems, action),
          ),
              if (cartCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    radius: 10,
                    child: Text(
                      '$cartCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: products.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Failed to load products: $e')),
          data: (_) => Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CategoryChips(
                  categories: categories,
                  selected: selected,
                  onSelected: (index) => setState(() => selected = index),
                ),
                const SizedBox(height: 16),
                if (visibleProducts.isEmpty)
                  Expanded(
                    child: Center(
                      child: Text(
                        'No products available',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: GridView.builder(
                      itemCount: visibleProducts.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.76,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemBuilder: (context, index) {
                        final item = visibleProducts[index];
                        return _ProductCard(
                          product: item,
                          onAdd: () async {
                            try {
                              await action(
                                CartAction.add(productId: item.id, quantity: 1),
                              );
                              if (!mounted) return;
                              ref.invalidate(cartProvider);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Added to cart')),
                              );
                            } catch (e) {
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Failed to add to cart: $e'),
                                ),
                              );
                            }
                          },
                          priceFormatter: _formatPrice,
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: cartTotal > 0
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: FilledButton(
                  onPressed: () => _showCartDetails(l10n, cartItems, action),
                  child: Text(
                    '${l10n.cartTotalLabel}: ${_formatPrice(cartTotal)}',
                  ),
                ),
              )
          : null,
    );
  }

  List<String> _buildCategories(List<Product> products) {
    final set = <String>{'all'};
    set.addAll(products.map((p) => p.categoryId?.toString() ?? 'misc'));
    return set.toList();
  }

  List<Product> _filterProducts(
    List<Product> products,
    List<String> categories,
    int selectedIndex,
  ) {
    if (selectedIndex == 0 || selectedIndex >= categories.length) {
      return products;
    }
    final category = categories[selectedIndex];
    return products
        .where((p) => (p.categoryId?.toString() ?? 'misc') == category)
        .toList();
  }

  void _refresh() {
    ref.invalidate(productsProvider);
    ref.invalidate(cartProvider);
  }

  String _formatPrice(double value) => _sarFormatter.format(value);

  double _calcTotal(List<CartItemModel> items) {
    return items.fold<double>(
      0,
      (sum, item) => sum + (item.product?.price ?? 0) * item.quantity,
    );
  }

  void _showCartDetails(
    AppLocalizations l10n,
    List<CartItemModel> items,
    Future<CartModel> Function(CartAction) action,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final sorted = [...items]..sort((a, b) => a.id.compareTo(b.id));
        if (sorted.isEmpty) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Text(
                  l10n.cartEmpty,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          );
        }

        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              top: 16,
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 60,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        l10n.cartTitle(items.length),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.separated(
                      itemCount: sorted.length,
                      separatorBuilder: (_, __) =>
                          const Divider(height: 1, thickness: 0.5),
                      itemBuilder: (context, index) {
                        final entry = sorted[index];
                        final item = entry.product;
                        final qty = entry.quantity;
                        if (item == null) return const SizedBox();
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(item.name),
                          subtitle: Text(
                            '${_formatPrice(item.price)} × $qty',
                          ),
                          trailing: SizedBox(
                            width: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    try {
                                      if (qty <= 1) {
                                        await action(
                                          CartAction.remove(itemId: entry.id),
                                        );
                                      } else {
                                        await action(
                                          CartAction.update(
                                            itemId: entry.id,
                                            quantity: qty - 1,
                                          ),
                                        );
                                      }
                                      if (!context.mounted) return;
                                      Navigator.of(context).pop();
                                      ref.invalidate(cartProvider);
                                    } catch (e) {
                                      if (!context.mounted) return;
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Cart update failed: $e'),
                                        ),
                                      );
                                    }
                                  },
                                  icon:
                                      const Icon(Icons.remove_circle_outline),
                                ),
                                Text('$qty'),
                                IconButton(
                                  onPressed: () async {
                                    try {
                                      await action(
                                        CartAction.update(
                                          itemId: entry.id,
                                          quantity: qty + 1,
                                        ),
                                      );
                                      if (!context.mounted) return;
                                      Navigator.of(context).pop();
                                      ref.invalidate(cartProvider);
                                    } catch (e) {
                                      if (!context.mounted) return;
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Cart update failed: $e'),
                                        ),
                                      );
                                    }
                                  },
                                  icon: const Icon(Icons.add_circle_outline),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${l10n.cartTotalLabel}: ${_formatPrice(_calcTotal(items))}',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CategoryChips extends StatelessWidget {
  const _CategoryChips({
    required this.categories,
    required this.selected,
    required this.onSelected,
  });

  final List<String> categories;
  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(categories.length, (index) {
          final label = categories[index];
          final isSelected = index == selected;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(label.toUpperCase()),
              selected: isSelected,
              onSelected: (_) => onSelected(index),
              selectedColor: theme.colorScheme.primary.withValues(alpha: 0.12),
              labelStyle: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    required this.product,
    required this.onAdd,
    required this.priceFormatter,
  });

  final Product product;
  final VoidCallback onAdd;
  final String Function(double) priceFormatter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      elevation: 2,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    product.stock > 0 ? 'In stock' : 'Out of stock',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              product.name,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              priceFormatter(product.price),
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.icon(
                onPressed: onAdd,
                icon: const Icon(Icons.add),
                label: const Text('Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
