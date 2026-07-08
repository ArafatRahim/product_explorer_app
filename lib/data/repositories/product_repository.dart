import '../../services/api_service.dart';
import '../database/database_helper.dart';
import '../models/product_model.dart';

class ProductRepository {
  final ApiService _apiService = ApiService();
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<List<Product>> getProducts() async {
    // First check local database
    final localProducts = await _databaseHelper.getProducts();

    if (localProducts.isNotEmpty) {
      return localProducts
          .map((item) => Product.fromMap(item))
          .toList();
    }

    // If database is empty, fetch from API
    final apiProducts = await _apiService.fetchProducts();

    await _databaseHelper.insertProducts(
      apiProducts.map((e) => e.toMap()).toList(),
    );

    // Return products from SQLite
    final savedProducts = await _databaseHelper.getProducts();

    return savedProducts
        .map((item) => Product.fromMap(item))
        .toList();
  }

  Future<void> addProduct(Product product) async {
    await _databaseHelper.insertProduct(product.toMap());
  }

  Future<void> updateProduct(Product product) async {
    await _databaseHelper.updateProduct(product.toMap());
  }

  Future<void> deleteProduct(int id) async {
    await _databaseHelper.deleteProduct(id);
  }
}