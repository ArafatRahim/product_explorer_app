import 'package:flutter/material.dart';

import '../data/models/product_model.dart';
import '../data/repositories/product_repository.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepository _repository = ProductRepository();

  List<Product> _products = [];
  List<Product> _filteredProducts = [];

  bool _isLoading = false;
  String _error = '';

  List<Product> get products => _products;
  List<Product> get filteredProducts => _filteredProducts;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _products = await _repository.getProducts();
      _filteredProducts = List.from(_products);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
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

    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    await _repository.addProduct(product);

    _products.insert(0, product);
    _filteredProducts = List.from(_products);

    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    await _repository.updateProduct(product);

    final index = _products.indexWhere((p) => p.id == product.id);

    if (index != -1) {
      _products[index] = product;
      _filteredProducts = List.from(_products);
      notifyListeners();
    }
  }

  Future<void> deleteProduct(int id) async {
    await _repository.deleteProduct(id);

    _products.removeWhere((p) => p.id == id);
    _filteredProducts.removeWhere((p) => p.id == id);

    notifyListeners();
  }
}