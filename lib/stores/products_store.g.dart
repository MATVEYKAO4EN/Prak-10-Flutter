// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductsStore on _ProductsStore, Store {
  Computed<List<Product>>? _$filteredProductsComputed;

  @override
  List<Product> get filteredProducts => (_$filteredProductsComputed ??=
          Computed<List<Product>>(() => super.filteredProducts,
              name: '_ProductsStore.filteredProducts'))
      .value;
  Computed<List<Product>>? _$allProductsComputed;

  @override
  List<Product> get allProducts => (_$allProductsComputed ??=
          Computed<List<Product>>(() => super.allProducts,
              name: '_ProductsStore.allProducts'))
      .value;

  late final _$productsAtom =
      Atom(name: '_ProductsStore.products', context: context);

  @override
  ObservableList<Product> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(ObservableList<Product> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$searchQueryAtom =
      Atom(name: '_ProductsStore.searchQuery', context: context);

  @override
  String get searchQuery {
    _$searchQueryAtom.reportRead();
    return super.searchQuery;
  }

  @override
  set searchQuery(String value) {
    _$searchQueryAtom.reportWrite(value, super.searchQuery, () {
      super.searchQuery = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_ProductsStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$loadProductsAsyncAction =
      AsyncAction('_ProductsStore.loadProducts', context: context);

  @override
  Future<void> loadProducts() {
    return _$loadProductsAsyncAction.run(() => super.loadProducts());
  }

  late final _$_ProductsStoreActionController =
      ActionController(name: '_ProductsStore', context: context);

  @override
  void setSearchQuery(String query) {
    final _$actionInfo = _$_ProductsStoreActionController.startAction(
        name: '_ProductsStore.setSearchQuery');
    try {
      return super.setSearchQuery(query);
    } finally {
      _$_ProductsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addProduct(Product product) {
    final _$actionInfo = _$_ProductsStoreActionController.startAction(
        name: '_ProductsStore.addProduct');
    try {
      return super.addProduct(product);
    } finally {
      _$_ProductsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateProduct(Product updatedProduct) {
    final _$actionInfo = _$_ProductsStoreActionController.startAction(
        name: '_ProductsStore.updateProduct');
    try {
      return super.updateProduct(updatedProduct);
    } finally {
      _$_ProductsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteProduct(String id) {
    final _$actionInfo = _$_ProductsStoreActionController.startAction(
        name: '_ProductsStore.deleteProduct');
    try {
      return super.deleteProduct(id);
    } finally {
      _$_ProductsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Product getProductById(String id) {
    final _$actionInfo = _$_ProductsStoreActionController.startAction(
        name: '_ProductsStore.getProductById');
    try {
      return super.getProductById(id);
    } finally {
      _$_ProductsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
products: ${products},
searchQuery: ${searchQuery},
isLoading: ${isLoading},
filteredProducts: ${filteredProducts},
allProducts: ${allProducts}
    ''';
  }
}
