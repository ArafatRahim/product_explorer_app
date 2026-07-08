import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/product_model.dart';
import '../../providers/product_provider.dart';

class AddProductScreen extends StatefulWidget {
  final Product? product;

  const AddProductScreen({
    super.key,
    this.product,
  });

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();
  final imageController = TextEditingController();
  final ratingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.product != null) {
      titleController.text = widget.product!.title;
      descriptionController.text = widget.product!.description;
      priceController.text = widget.product!.price.toString();
      categoryController.text = widget.product!.category;
      imageController.text = widget.product!.thumbnail;
      ratingController.text = widget.product!.rating.toString();
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    categoryController.dispose();
    imageController.dispose();
    ratingController.dispose();
    super.dispose();
  }

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product == null
              ? "Add Product"
              : "Edit Product",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: inputDecoration("Product Title"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter product title";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: descriptionController,
                decoration: inputDecoration("Description"),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter description";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: priceController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: inputDecoration("Price"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter price";
                  }

                  if (double.tryParse(value) == null) {
                    return "Enter a valid price";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: categoryController,
                decoration: inputDecoration("Category"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter category";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: imageController,
                decoration: inputDecoration("Image URL"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter image URL";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: ratingController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: inputDecoration("Rating"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter rating";
                  }

                  if (double.tryParse(value) == null) {
                    return "Enter a valid rating";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }

                    final product = Product(
                      id: widget.product?.id ??
                          DateTime.now().millisecondsSinceEpoch,
                      title: titleController.text.trim(),
                      description: descriptionController.text.trim(),
                      price: double.parse(priceController.text),
                      thumbnail: imageController.text.trim(),
                      category: categoryController.text.trim(),
                      rating: double.parse(ratingController.text),
                    );

                    if (widget.product == null) {
                      await context
                          .read<ProductProvider>()
                          .addProduct(product);

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Product Added Successfully"),
                        ),
                      );
                    } else {
                      await context
                          .read<ProductProvider>()
                          .updateProduct(product);

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Product Updated Successfully"),
                        ),
                      );
                    }

                    Navigator.pop(context, true);
                  },
                  child: Text(
                    widget.product == null
                        ? "Save Product"
                        : "Update Product",
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}