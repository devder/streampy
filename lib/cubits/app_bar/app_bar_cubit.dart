import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';

// part 'app_bar_state.dart';
//we dont ake use of the app_bar_state file

class AppBarCubit extends Cubit<double> {
  AppBarCubit() : super(0);

  void setOffset(double offset) => emit(offset);
}

// event -->  bloc --> state //with bloc
// bloc --> state // with cubits
