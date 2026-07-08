import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'presentation/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'providers/product_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ProductProvider(),
      child: const ProductExplorerApp(),
    ),
  );
}

class ProductExplorerApp extends StatelessWidget {
  const ProductExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Explorer',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}