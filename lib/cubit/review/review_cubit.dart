import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/reviews_model.dart';
import '../../service/review_service.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final ReviewService _service;

  ReviewCubit(this._service) : super(ReviewInitial());

  void CreateReview({
    required String name,
    required String description,
    required double rating,
    required String productId,
  }) async {
    try {
      emit(ReviewLoading());
      await _service.createReview(
        name: name,
        description: description,
        rating: rating,
        productId: productId,
      );
      emit(ReviewSuccess());
    } catch (e) {
      emit(ReviewError(message: e.toString()));
    }
  }

  // Твой метод внутри ReviewCubit
  Future<void> GetReviews(String productId) async {
    emit(ReviewLoading());
    try {
      // Передаем полученный productId в метод сервиса
      final reviews = await _service.getAllReviews(productId);
      emit(ReviewsLoaded(reviews)); // Эмитим состояние со списком
    } catch (e) {
      emit(ReviewError(message: e.toString()));
    }
  }
}
