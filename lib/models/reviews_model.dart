import 'package:flutter/foundation.dart';

class ReviewsModel {
  final String name;
  final String description;
  final double rating;
  final String productid;

  ReviewsModel({required this.name, required this.description, required this.rating, required this.productid});

  factory ReviewsModel.fromJson(Map<String, dynamic> json) {
    return ReviewsModel(
      // Если в базе колонка называется "product_Id", то и тут ключ "product_Id"
      productid: (json['product_id'] ?? 0).toString(),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      rating: (json['rating'] is int)
          ? (json['rating'] as int).toDouble()
          : (json['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}