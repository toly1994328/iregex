import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regexp/src/models/models.dart';

class AppConfigBloc extends Cubit<AppConfig> {
  AppConfigBloc() : super(const AppConfig());

  void switchThemeMode() {
    int newMode = state.appThemeMode == 0 ? 1 : 0;
    emit(state.copyWith(appThemeMode: newMode));
  }
}
