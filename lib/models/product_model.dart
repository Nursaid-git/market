class ProductModel {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  ProductModel({required this.id, required this.name, required this.price, required this.imageUrl});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'],
    name: json['name'],
    price: json['price'].toDouble(),
    imageUrl: json['image_url'],
  );
}