import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/product_model.dart';
import '../../service/product_service.dart';

part 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final ProductService _service;

  ProductDetailCubit(this._service) : super(ProductDetailLoading());

  Future<void> loadProduct(String id) async {
    emit(ProductDetailLoading());
    try {
      final product = await _service.fetchProductById(id);
      emit(ProductDetailLoaded(product));
    } catch (e) {
      emit(ProductDetailError("Не удалось загрузить товар: ${e.toString()}"));
    }
  }
}