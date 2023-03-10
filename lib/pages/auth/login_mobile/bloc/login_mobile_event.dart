part of 'login_mobile_bloc.dart';

abstract class LoginMobileEvent extends Equatable {
  const LoginMobileEvent();

  @override
  List<Object> get props => [];
}

///
/// Phone number event
class LoginPhoneChanged extends LoginMobileEvent {
  const LoginPhoneChanged(this.phone);

  final PhoneNumber phone;

  @override
  List<Object> get props => [phone];
}

///
/// Login use firebase phone number event
class LoginSubmitted extends LoginMobileEvent {
  final String token;
  final Future<void> Function([bool navigate, dynamic e]) callback;

  const LoginSubmitted(this.token, this.callback);

  @override
  List<Object> get props => [token, callback];
}

///
/// Register use firebase phone number event
class RegisterSubmitted extends LoginMobileEvent {
  final Future<void> Function([bool navigate, dynamic e]) callback;

  const RegisterSubmitted(this.callback);

  @override
  List<Object> get props => [callback];
}

///
/// Login use Digits plugin API event
class LoginDigitsSubmitted extends LoginMobileEvent {
  final Map<String, dynamic> data;
  final Future<void> Function([bool navigate, dynamic e]) callback;

  const LoginDigitsSubmitted(this.data, this.callback);

  @override
  List<Object> get props => [data, callback];
}

///
/// Register use Digits plugin API event
class RegisterDigitsSubmitted extends LoginMobileEvent {
  final Map<String, dynamic> data;
  final Future<void> Function([bool navigate, dynamic e]) callback;

  const RegisterDigitsSubmitted(this.data, this.callback);

  @override
  List<Object> get props => [data, callback];
}
