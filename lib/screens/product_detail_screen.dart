import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../core/widgets/size_selector.dart';
import '../models/product_model.dart'; // 1. Добавили импорт модели товара

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String _selectedSize = 'S';

  @override
  Widget build(BuildContext context) {
    // 2. Вытаскиваем переданный продукт из аргументов навигатора
    final product = ModalRoute.of(context)?.settings.arguments as ProductModel?;

    // Защита: если вдруг продукт забыли передать, не роняем приложение
    if (product == null) {
      return const Scaffold(
        body: Center(child: Text("Данные товара не найдены")),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Изображение и кнопки управления
            Stack(
              children: [
                // 3. Умная загрузка картинки: сеть или локальный ассет
                product.imageUrl.startsWith('http')
                    ? Image.network(product.imageUrl, fit: BoxFit.cover, width: double.infinity, height: 350)
                    : Image.asset(product.imageUrl, fit: BoxFit.cover, width: double.infinity),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black), onPressed: () {}),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Men's Printed Pullover Hoodie", style: TextStyle(color: Colors.grey)),
                            const SizedBox(height: 4),
                            // 4. Подставляем реальное название товара
                            Text(product.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Price", style: TextStyle(color: Colors.grey)),
                          // 5. Подставляем реальную цену товара
                          Text("\$${product.price.toStringAsFixed(0)}", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Мини-галерея (Screen 04)
                  SizedBox(
                    height: 80,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (context, index) => ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset('assets/images/thumb_$index.png', width: 80, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildSectionHeader("Size", "Size Guide", onTap: () {}),
                  SizeSelector(
                    selectedSize: _selectedSize,
                    onSizeSelected: (size) => setState(() => _selectedSize = size),
                  ),
                  const SizedBox(height: 20),
                  const Text("Description", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text(
                    "The Nike Throwback Pullover Hoodie is made from premium French terry fabric that blends a performance feel with... Read More..",
                    style: TextStyle(color: Colors.grey, height: 1.5),
                  ),
                  const SizedBox(height: 20),

                  // 6. НАСТРАИВАЕМ ПЕРЕХОД НА ЭКРАН ОТЗЫВОВ С РЕАЛЬНЫМ ID ТОВАРА
                  _buildSectionHeader(
                    "Reviews",
                    "View All",
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/review',
                        arguments: product.id, // Передаем живой ID в main.dart роут
                      );
                    },
                  ),
                  const ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(backgroundImage: AssetImage('assets/images/user_avatar.png')),
                    title: Text("Ronald Richards"),
                    subtitle: Text("13 Sep, 2020"),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("4.8 rating", style: TextStyle(fontWeight: FontWeight.bold)),
                        Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.star, color: Colors.orange, size: 12)]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total Price", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                // 7. Обновляем общую цену внизу экрана
                Text("\$${product.price.toStringAsFixed(0)}", style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 15),
            CustomButton(text: "Add to Cart", onPressed: () {}),
          ],
        ),
      ),
    );
  }

  // Обновили метод заголовка, добавив опциональный клик onTap
  Widget _buildSectionHeader(String title, String actionText, {VoidCallback? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        TextButton(
          onPressed: onTap,
          child: Text(actionText, style: const TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }
}