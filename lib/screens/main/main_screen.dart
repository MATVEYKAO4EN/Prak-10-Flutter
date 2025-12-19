import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../stores/main_store.dart';
import '../../stores/user_store.dart';
import '../../stores/products_store.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  void _navigateBackToAuth(BuildContext context) {
    final userStore = Provider.of<UserStore>(context, listen: false);
    userStore.clear();
    context.go('/authorization');
  }

  @override
  Widget build(BuildContext context) {
    final mainStore = Provider.of<MainStore>(context);
    final productsStore = Provider.of<ProductsStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Главное меню')
      ),
      body: Observer(
        builder: (_) {
          // Вычисляем статистику
          final totalProducts = productsStore.products.length;
          final totalQuantity = productsStore.products.fold(
              0,
                  (sum, product) => sum + product.quantity
          );

          // Получаем уникальные категории
          final categories = productsStore.products
              .map((p) => p.category)
              .toSet()
              .toList();
          final totalCategories = categories.length;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Статистика (3 карточки в ряд)
                const Text(
                  'Статистика склада',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Карточка общего количества продуктов
                    _buildStatCard(
                      context,
                      'Всего продуктов',
                      totalProducts.toString(),
                      Icons.inventory,
                      Colors.blue,
                    ),

                    // Карточка количества категорий
                    _buildStatCard(
                      context,
                      'Категории',
                      totalCategories.toString(),
                      Icons.category,
                      Colors.green,
                    ),

                    // Карточка общего количества единиц
                    _buildStatCard(
                      context,
                      'Единиц на складе',
                      totalQuantity.toString(),
                      Icons.shopping_cart,
                      Colors.orange,
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    shrinkWrap: true,
                    children: [
                      _buildMenuButton(
                        context,
                        'Профиль',
                        Icons.person,
                        Colors.blue,
                            () => context.push('/profile'),
                      ),
                      _buildMenuButton(
                        context,
                        'Статистика',
                        Icons.bar_chart,
                        Colors.green,
                            () => context.push('/dashboard'),
                      ),
                      _buildMenuButton(
                        context,
                        'История',
                        Icons.history,
                        Colors.orange,
                            () => context.push('/logs'),
                      ),
                      _buildMenuButton(
                        context,
                        'Продукты',
                        Icons.shopping_cart,
                        Colors.purple,
                            () => context.push('/products'),
                      ),
                      _buildMenuButton(
                        context,
                        'Документы',
                        Icons.description,
                        Colors.brown,
                            () => context.push('/documents'),
                      ),
                      _buildMenuButton(
                        context,
                        'Помощь',
                        Icons.help,
                        Colors.red,
                            () => context.push('/info'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Виджет для карточки статистики
  Widget _buildStatCard(
      BuildContext context,
      String title,
      String value,
      IconData icon,
      Color color,
      ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: color,
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: color.withOpacity(0.8),
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Виджет для кнопки меню
  Widget _buildMenuButton(
      BuildContext context,
      String title,
      IconData icon,
      Color color,
      VoidCallback onPressed,
      ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: color,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}