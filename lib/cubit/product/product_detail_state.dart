part of 'product_detail_cubit.dart';

@immutable

abstract class ProductDetailState {}

class ProductDetailLoading extends ProductDetailState {}

class ProductDetailLoaded extends ProductDetailState {
  final ProductModel product;
  // Можно добавить список похожих товаров или отзывов
  ProductDetailLoaded(this.product);
}

class ProductDetailError extends ProductDetailState {
  final String message;
  ProductDetailError(this.message);
}
