import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../stores/products_store.dart';
import '../../models/product.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _quantityController = TextEditingController();
  String? _editingProductId;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, StateSetter setState) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('ru', 'RU'),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = DateTime(
          picked.year,
          picked.month,
          picked.day,
          _selectedTime.hour,
          _selectedTime.minute,
        );
      });
    }
  }

  Future<void> _selectTime(BuildContext context, StateSetter setState) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _selectedDate = DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  void _showAddProductDialog() {
    _editingProductId = null;
    _nameController.clear();
    _categoryController.clear();
    _quantityController.clear();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();

    showDialog(
      context: context,
      builder: (context) => _buildProductDialog(),
    );
  }

  void _showEditProductDialog(Product product) {
    _editingProductId = product.id;
    _nameController.text = product.name;
    _categoryController.text = product.category;
    _quantityController.text = product.quantity.toString();
    _selectedDate = product.updatedAt;
    _selectedTime = TimeOfDay.fromDateTime(product.updatedAt);

    showDialog(
      context: context,
      builder: (context) => _buildProductDialog(),
    );
  }

  Widget _buildProductDialog() {
    final productsStore = Provider.of<ProductsStore>(context, listen: false);

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return AlertDialog(
          title: Text(
              _editingProductId == null ? 'Добавить продукт' : 'Редактировать продукт'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Название',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите название';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _categoryController,
                    decoration: const InputDecoration(
                      labelText: 'Категория',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите категорию';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _quantityController,
                    decoration: const InputDecoration(
                      labelText: 'Количество',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите количество';
                      }
                      final quantity = int.tryParse(value);
                      if (quantity == null || quantity < 0) {
                        return 'Введите корректное количество';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Дата и время
                  const Text(
                    'Дата обновления:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _selectDate(context, setState),
                          icon: const Icon(Icons.calendar_today),
                          label: Text(
                            '${_selectedDate.day.toString().padLeft(2, '0')}.'
                                '${_selectedDate.month.toString().padLeft(2, '0')}.'
                                '${_selectedDate.year}',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _selectTime(context, setState),
                          icon: const Icon(Icons.access_time),
                          label: Text(
                            '${_selectedTime.hour.toString().padLeft(2, '0')}:'
                                '${_selectedTime.minute.toString().padLeft(2, '0')}',
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                  Text(
                    'Текущая дата: ${_selectedDate.day}.${_selectedDate.month}.${_selectedDate.year} '
                        '${_selectedTime.hour.toString().padLeft(2, '0')}:'
                        '${_selectedTime.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final product = Product(
                    id: _editingProductId ?? DateTime.now().millisecondsSinceEpoch.toString(),
                    name: _nameController.text,
                    category: _categoryController.text,
                    quantity: int.parse(_quantityController.text),
                    updatedAt: _selectedDate,
                  );

                  if (_editingProductId == null) {
                    productsStore.addProduct(product);
                  } else {
                    productsStore.updateProduct(product);
                  }

                  Navigator.of(context).pop();
                }
              },
              child: const Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation(Product product) {
    final productsStore = Provider.of<ProductsStore>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удаление продукта'),
        content: Text('Вы уверены, что хотите удалить "${product.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              productsStore.deleteProduct(product.id);
              Navigator.of(context).pop();
            },
            child: const Text(
              'Удалить',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productsStore = Provider.of<ProductsStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Продукты'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          // Поисковая строка
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Observer(
              builder: (_) => TextField(
                decoration: InputDecoration(
                  hintText: 'Поиск продуктов...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: productsStore.searchQuery.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => productsStore.setSearchQuery(''),
                  )
                      : null,
                ),
                onChanged: productsStore.setSearchQuery,
              ),
            ),
          ),

          // Список продуктов
          Expanded(
            child: Observer(
              builder: (_) {
                if (productsStore.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                final products = productsStore.filteredProducts;

                if (products.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.inventory_2,
                          size: 80,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          productsStore.searchQuery.isEmpty
                              ? 'Нет продуктов'
                              : 'Продукты не найдены',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        if (productsStore.searchQuery.isEmpty)
                          TextButton(
                            onPressed: _showAddProductDialog,
                            child: const Text('Добавить первый продукт'),
                          ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 16),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: _getCategoryColor(product.category),
                          child: Text(
                            product.name[0].toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          product.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Категория: ${product.category}'),
                            Text('Количество: ${product.quantity} шт.'),
                            Text(
                              'Обновлено: ${product.updatedAt.day}.${product.updatedAt.month}.${product.updatedAt.year} '
                                  '${product.updatedAt.hour.toString().padLeft(2, '0')}:'
                                  '${product.updatedAt.minute.toString().padLeft(2, '0')}',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _showEditProductDialog(product),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _showDeleteConfirmation(product),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddProductDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'электроника':
        return Colors.blue;
      case 'мебель':
        return Colors.green;
      case 'офисная техника':
        return Colors.orange;
      default:
        return Colors.purple;
    }
  }
}