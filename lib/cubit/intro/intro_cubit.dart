import 'package:flutter_bloc/flutter_bloc.dart';

class IntroCubit extends Cubit<String?> {
  IntroCubit() : super(null);
  void selectGender(String g) => emit(g);
}
