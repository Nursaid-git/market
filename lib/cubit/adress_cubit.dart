import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'adress_state.dart';

class AdressCubit extends Cubit<AdressState> {
  AdressCubit() : super(AdressInitial());
}
