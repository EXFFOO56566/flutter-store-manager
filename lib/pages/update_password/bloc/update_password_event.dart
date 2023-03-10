part of 'update_password_bloc.dart';

@immutable
abstract class UpdatePasswordEvent extends Equatable {
  const UpdatePasswordEvent();

  @override
  List<Object> get props => [];
}

class OldPasswordChanged extends UpdatePasswordEvent {
  const OldPasswordChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class NewPasswordChanged extends UpdatePasswordEvent {
  const NewPasswordChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class ConfirmPasswordChanged extends UpdatePasswordEvent {
  const ConfirmPasswordChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class Submitted extends UpdatePasswordEvent {
  const Submitted();
}
