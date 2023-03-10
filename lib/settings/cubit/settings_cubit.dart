import 'dart:ui';
import 'package:flutter_store_manager/constants/languages.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../models/models.dart';

class SettingsCubit extends HydratedCubit<Setting> {
  SettingsCubit() : super(const Setting(locate: defaultLocale, brightness: Brightness.light, enableOnBoarding: true));

  void closeOnBoarding() {
    emit(state.copyWith(enableOnBoarding: false));
  }

  void changeLanguage(String locate) {
    emit(state.copyWith(locate: locate));
  }

  void toggleBrightness() {
    Brightness brightness = state.brightness == Brightness.light ? Brightness.dark : Brightness.light;
    emit(state.copyWith(brightness: brightness));
  }

  @override
  Setting? fromJson(Map<String, dynamic> json) {
    return Setting.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(Setting state) {
    return state.toJson();
  }
}
