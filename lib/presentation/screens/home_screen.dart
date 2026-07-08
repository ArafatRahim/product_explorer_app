import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/product_provider.dart';
import '../widgets/product_card.dart';
import 'add_edit_product_screen.dart';
import 'product_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ProductProvider>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();

    final screenWidth = MediaQuery.of(context).size.width;

    final crossAxisCount = screenWidth > 1200
        ? 5
        : screenWidth > 900
        ? 4
        : screenWidth > 600
        ? 3
        : 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Explorer"),
        centerTitle: true,
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          await provider.fetchProducts();
        },
        child: Builder(
          builder: (_) {
            // Loading
            if (provider.isLoading) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 15),
                    Text("Loading Products..."),
                  ],
                ),
              );
            }

            // Error
            if (provider.error.isNotEmpty) {
              return Center(
                child: Text(provider.error),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Explore Products",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    "Find your favourite products",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Search Box
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Search products...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                    onChanged: provider.searchProducts,
                  ),

                  const SizedBox(height: 18),

                  // Empty State
                  if (provider.filteredProducts.isEmpty)
                    const Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 70,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 12),
                            Text(
                              "No Products Found",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: GridView.builder(
                        itemCount: provider.filteredProducts.length,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.68,
                        ),
                        itemBuilder: (context, index) {
                          final product = provider.filteredProducts[index];

                          return ProductCard(
                            product: product,
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ProductDetailsScreen(
                                    product: product,
                                  ),
                                ),
                              );

                              if (context.mounted) {
                                await provider.fetchProducts();
                              }
                            },
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        tooltip: "Add Product",
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddProductScreen(),
            ),
          );

          if (result == true && context.mounted) {
            await provider.fetchProducts();
          }
        },
      ),
    );
  }
}