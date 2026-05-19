import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/test_model.dart';
import '../service/test_service.dart';

part 'test_state.dart';

class TestCubit extends Cubit<TestState> {
  final TestService _service;
  TestCubit(this._service) : super(TestInitial());

  void getProducts() async {
    try {
      emit(TestLoading());
      final products = await _service.getProducts();
      emit(TestSuccess(products));
  } catch (e) {
      emit(TestError(message: 'Ошибка при загрузке данных $e'));
    }
  }
}
