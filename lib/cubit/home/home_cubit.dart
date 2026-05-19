import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/product_model.dart';
import '../../service/product_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ProductService _service = ProductService();
  HomeCubit() : super(HomeLoading());

  void loadProducts() async {
    try {
      final products = await _service.fetchProducts();
      emit(HomeLoaded(products));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
