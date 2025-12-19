import 'package:mobx/mobx.dart';
import '../models/product.dart';

part 'products_store.g.dart';

class ProductsStore = _ProductsStore with _$ProductsStore;

abstract class _ProductsStore with Store {
  @observable
  ObservableList<Product> products = ObservableList.of([
    Product(
      id: '1',
      name: 'Ноутбук Dell',
      category: 'Электроника',
      quantity: 10,
      updatedAt: DateTime.now(),
    ),
    Product(
      id: '2',
      name: 'Стол офисный',
      category: 'Мебель',
      quantity: 5,
      updatedAt: DateTime.now().subtract(Duration(days: 1)),
    ),
    Product(
      id: '3',
      name: 'Кресло ортопедическое',
      category: 'Мебель',
      quantity: 8,
      updatedAt: DateTime.now().subtract(Duration(days: 2)),
    ),
    Product(
      id: '4',
      name: 'Монитор 24"',
      category: 'Электроника',
      quantity: 15,
      updatedAt: DateTime.now().subtract(Duration(days: 3)),
    ),
    Product(
      id: '5',
      name: 'Принтер лазерный',
      category: 'Офисная техника',
      quantity: 3,
      updatedAt: DateTime.now().subtract(Duration(days: 4)),
    ),
  ]);

  @observable
  String searchQuery = '';

  @observable
  bool isLoading = false;

  @computed
  List<Product> get filteredProducts {
    if (searchQuery.isEmpty) {
      return products;
    }

    return products.where((product) {
      return product.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          product.category.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }
  @computed
  List<Product> get allProducts => List<Product>.from(products);

  @action
  void setSearchQuery(String query) {
    searchQuery = query;
  }

  @action
  void addProduct(Product product) {
    products.add(product);
  }

  @action
  void updateProduct(Product updatedProduct) {
    final index = products.indexWhere((p) => p.id == updatedProduct.id);
    if (index != -1) {
      products[index] = updatedProduct;
    }
  }

  @action
  void deleteProduct(String id) {
    products.removeWhere((product) => product.id == id);
  }

  @action
  Product getProductById(String id) {
    return products.firstWhere((product) => product.id == id);
  }

  @action
  Future<void> loadProducts() async {
    isLoading = true;
    // Имитация загрузки
    await Future.delayed(const Duration(seconds: 1));
    isLoading = false;
  }
}