import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/reviews_model.dart';

class ReviewService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> createReview({
    required String productId, // Добавили параметр
    required String name,
    required String description,
    required double rating,
  }) async {
    try {
      final intId = int.tryParse(productId) ?? 0; // Переводим в число для bigint

      await _client.from('review').insert({
        'product_id': intId, // Передаем в базу данных!
        'name': name,
        'description': description,
        'rating': rating,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print("Ошибка добавления отзыва: $e");
    }
  }

  Future<List<ReviewsModel>> getAllReviews(String productId) async {
    try {
      // ПРОВЕРКА: Если строка пустая или не является числом, возвращаем пустой список
      final intId = int.tryParse(productId);
      if (intId == null) {
        return [];
      }

      final response = await _client
          .from('review')
          .select()
          .eq('product_id', intId)
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => ReviewsModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Ошибка при загрузке списка отзывов: $e');
    }
  }
}

