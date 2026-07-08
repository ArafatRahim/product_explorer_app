import 'package:flutter/material.dart';

import '../data/models/product_model.dart';
import '../data/repositories/product_repository.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepository _repository = ProductRepository();

  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  List<Product> _visibleProducts = [];

  bool _isLoading = false;
  String _error = '';

  static const int _pageSize = 20;
  int _currentPage = 1;

  List<Product> get products => _products;
  List<Product> get filteredProducts => _visibleProducts;
  bool get isLoading => _isLoading;
  String get error => _error;

  bool get hasMore =>
      _visibleProducts.length < _filteredProducts.length;

  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _products = await _repository.getProducts();
      _filteredProducts = List.from(_products);

      _currentPage = 1;
      _updateVisibleProducts();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void _updateVisibleProducts() {
    final end = (_currentPage * _pageSize);

    if (end >= _filteredProducts.length) {
      _visibleProducts = List.from(_filteredProducts);
    } else {
      _visibleProducts = _filteredProducts.sublist(0, end);
    }
  }

  void loadMore() {
    if (!hasMore) return;

    _currentPage++;
    _updateVisibleProducts();

    notifyListeners();
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      _filteredProducts = List.from(_products);
    } else {
      _filteredProducts = _products.where((product) {
        return product.title
            .toLowerCase()
            .contains(query.toLowerCase()) ||
            product.category
                .toLowerCase()
                .contains(query.toLowerCase());
      }).toList();
    }

    _currentPage = 1;
    _updateVisibleProducts();

    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    await _repository.addProduct(product);

    _products.insert(0, product);

    searchProducts("");
  }

  Future<void> updateProduct(Product product) async {
    await _repository.updateProduct(product);

    final index = _products.indexWhere((p) => p.id == product.id);

    if (index != -1) {
      _products[index] = product;
    }

    searchProducts("");
  }

  Future<void> deleteProduct(int id) async {
    await _repository.deleteProduct(id);

    _products.removeWhere((p) => p.id == id);

    searchProducts("");
  }
}