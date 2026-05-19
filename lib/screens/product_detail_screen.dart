import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../core/widgets/size_selector.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String _selectedSize = 'S';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Изображение и кнопки управления
            Stack(
              children: [
                Image.asset('assets/images/product_large.png', fit: BoxFit.cover, width: double.infinity),
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
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Men's Printed Pullover Hoodie", style: TextStyle(color: Colors.grey)),
                          Text("Nike Club Fleece", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Price", style: TextStyle(color: Colors.grey)),
                          Text("\$120", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
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
                  _buildSectionHeader("Size", "Size Guide"),
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
                  _buildSectionHeader("Reviews", "View All"),
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Price", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                Text("\$125", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 15),
            CustomButton(text: "Add to Cart", onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String actionText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        TextButton(onPressed: () {}, child: Text(actionText, style: const TextStyle(color: Colors.grey))),
      ],
    );
  }
}