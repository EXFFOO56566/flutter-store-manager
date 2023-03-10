import 'package:appcheap_flutter_core/di/modules/modules.dart';
import 'package:bloc/bloc.dart';
import 'package:captcha_repository/captcha_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';

part 'captcha_state.dart';

class CaptchaCubit extends Cubit<CaptchaState> {
  final CaptchaRepository captchaRepository;
  CaptchaCubit({required this.captchaRepository}) : super(const CaptchaState());

  Future<void> getCaptcha() async {
    emit(state.copyWith(status: const LoadingState()));
    try {
      Map? captcha = await captchaRepository.getCaptcha();
      emit(state.copyWith(captcha: captcha, status: LoadedState(data: captcha)));
    } catch (e) {
      emit(state.copyWith(status: ErrorState(data: e)));
    }
  }

  Future<void> validateCaptcha(Map<String, dynamic> data, Function callback) async {
    try {
      emit(state.copyWith(loadingValidate: true));
      await captchaRepository.validateCaptcha(
        requestData: RequestData(data: data),
      );
      emit(state.copyWith(loadingValidate: false));
      callback();
    } on RequestError catch (e) {
      emit(state.copyWith(
        loadingValidate: false,
        error: e.message,
      ));
      getCaptcha();
    }
  }
}
