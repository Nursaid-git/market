import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // 1. Импортируем Bloc
import '../cubit/home/home_cubit.dart'; // 2. Импортируем Cubit
import '../models/product_model.dart'; // 3. Импортируем модель продукта

import '../core/widgets/brand_card.dart';
import '../core/widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.sort), onPressed: () {}),
        actions: [IconButton(icon: const Icon(Icons.shopping_bag_outlined), onPressed: () {})],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Hello", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const Text("Welcome to Laza.", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      hintText: "Search...",
                      filled: true,
                      fillColor: const Color(0xFFF5F6F7),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: const Color(0xFF9775FA), borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.mic_none, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildSectionHeader("Choose Brand"),
            const SizedBox(height: 15),
            SizedBox(
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  BrandCard(title: "Adidas", logoPath: "assets/icons/adidas.png", onTap: () {}),
                  const SizedBox(width: 10),
                  BrandCard(title: "Nike", logoPath: "assets/icons/nike.png", onTap: () {}),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionHeader("New Arrival"),

            // 4. СЛУШАЕМ ПОТОК ДАННЫХ ИЗ SUPABASE
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const Center(child: CircularProgressIndicator(color: Color(0xFF9775FA)));
                }

                if (state is HomeError) {
                  return Center(child: Text("Ошибка загрузки: ${state.message}", style: const TextStyle(color: Colors.red)));
                }

                if (state is HomeLoaded) {
                  final products = state.products;

                  if (products.isEmpty) {
                    return const Center(child: Text("В базе данных Supabase пока нет товаров."));
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];

                      return GestureDetector(
                        onTap: () {
                          // Переходим на экран деталей и передаем ВЕСЬ объект продукта через аргументы
                          Navigator.pushNamed(
                            context,
                            '/product_detail',
                            arguments: product,
                          );
                        },
                        child: ProductCard(
                          title: product.name,
                          price: "\$${product.price.toStringAsFixed(0)}",
                          imagePath: product.imageUrl,
                        ),
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), label: "Wishlist"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.wallet_outlined), label: "Wallet"),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        TextButton(onPressed: () {}, child: const Text("View All", style: TextStyle(color: Colors.grey))),
      ],
    );
  }
}