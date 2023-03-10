part of 'login_mobile_bloc.dart';

class LoginMobileState extends Equatable {
  const LoginMobileState({
    this.status = FormzStatus.pure,
    this.phone = const Phone.pure(),
  });

  final FormzStatus status;
  final Phone phone;

  LoginMobileState copyWith({
    FormzStatus? status,
    Phone? phone,
  }) {
    return LoginMobileState(
      status: status ?? this.status,
      phone: phone ?? this.phone,
    );
  }

  @override
  List<Object> get props => [status, phone];
}
