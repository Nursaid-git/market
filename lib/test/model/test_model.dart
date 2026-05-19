class TestModel {
  final String id;
  final DateTime createdAt;
  final String title;
  final double price;
  final String currency;
  final String? imageUrl;
  final bool isAvailable;

  TestModel({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.price,
    required this.currency,
    this.imageUrl,
    this.isAvailable = true
  });
  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] ?? 'KZT',
      imageUrl: json['image_url'],
      isAvailable: json['is_available'] ?? true,
    );
  }
}
