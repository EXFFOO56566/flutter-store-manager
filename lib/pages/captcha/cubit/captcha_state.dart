part of 'captcha_cubit.dart';

class CaptchaState extends Equatable {
  const CaptchaState({
    this.status = const InitState(),
    this.loadingValidate = false,
    this.captcha,
    this.error,
  });

  final BaseState status;
  final bool loadingValidate;
  final Map? captcha;
  final String? error;

  CaptchaState copyWith({
    BaseState? status,
    bool? loadingValidate,
    Map? captcha,
    String? error,
  }) {
    return CaptchaState(
      status: status ?? this.status,
      loadingValidate: loadingValidate ?? this.loadingValidate,
      captcha: captcha ?? this.captcha,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, loadingValidate, captcha, error];
}
