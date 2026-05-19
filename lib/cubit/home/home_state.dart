part of 'home_cubit.dart';

@immutable
abstract class HomeState {}
class HomeLoading extends HomeState {}
class HomeLoaded extends HomeState { final List<ProductModel> products; HomeLoaded(this.products); }
class HomeError extends HomeState { final String message; HomeError(this.message); }
