import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('products.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        price REAL,
        thumbnail TEXT,
        category TEXT,
        rating REAL
      )
    ''');
  }

  // Insert a single product
  Future<int> insertProduct(Map<String, dynamic> product) async {
    final db = await database;

    return await db.insert(
      'products',
      product,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Insert multiple products
  Future<void> insertProducts(List<Map<String, dynamic>> products) async {
    final db = await database;

    final batch = db.batch();

    for (final product in products) {
      batch.insert(
        'products',
        product,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  // Get all products
  Future<List<Map<String, dynamic>>> getProducts() async {
    final db = await database;

    return await db.query(
      'products',
      orderBy: 'id DESC',
    );
  }

  // Update
  Future<int> updateProduct(Map<String, dynamic> product) async {
    final db = await database;

    return await db.update(
      'products',
      product,
      where: 'id = ?',
      whereArgs: [product['id']],
    );
  }

  // Delete
  Future<int> deleteProduct(int id) async {
    final db = await database;

    return await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Clear database
  Future<void> clearProducts() async {
    final db = await database;

    await db.delete('products');
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}