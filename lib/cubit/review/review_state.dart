part of 'review_cubit.dart';

@immutable
sealed class ReviewState {}

final class ReviewInitial extends ReviewState {}

final class ReviewLoading extends ReviewState {}

final class ReviewSuccess extends ReviewState {}

final class ReviewsLoaded extends ReviewState {
  final List<ReviewsModel> reviews; // Тут именно List!
  ReviewsLoaded(this.reviews);
}
final class ReviewError extends ReviewState {
  final String message;

  ReviewError({required this.message});
}


