import 'package:example/constants/language.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'setting_state.dart';

class SettingCubit extends HydratedCubit<SettingState> {
  SettingCubit() : super(const SettingState());

  void closeOnBoarding() {
    emit(state.copyWith(showOnBoarding: false));
  }

  void toggleBrightness() {
    Brightness brightness = state.brightness == Brightness.light ? Brightness.dark : Brightness.light;
    emit(state.copyWith(brightness: brightness));
  }

  void changeLocale(String locale) {
    emit(state.copyWith(locale: locale));
  }

  @override
  SettingState fromJson(Map<String, dynamic> json) {
    return SettingState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(SettingState state) {
    return state.toJson();
  }
}
