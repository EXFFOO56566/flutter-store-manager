part of 'update_personal_bloc.dart';

@immutable
abstract class UpdatePersonalEvent extends Equatable {
  const UpdatePersonalEvent();

  @override
  List<Object> get props => [];
}

class FirstNameChanged extends UpdatePersonalEvent {
  const FirstNameChanged(this.firstName);

  final String firstName;

  @override
  List<Object> get props => [firstName];
}

class LastNameChanged extends UpdatePersonalEvent {
  const LastNameChanged(this.lastName);

  final String lastName;

  @override
  List<Object> get props => [lastName];
}

class EmailChanged extends UpdatePersonalEvent {
  const EmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class ImageChanged extends UpdatePersonalEvent {
  const ImageChanged(this.image, {required this.isSelectdImage});

  final ImageData image;

  final bool isSelectdImage;

  @override
  List<Object> get props => [image, isSelectdImage];
}

class ImageDeletedChanged extends UpdatePersonalEvent {
  const ImageDeletedChanged();

  @override
  List<Object> get props => [];
}

class InitData extends UpdatePersonalEvent {
  const InitData(
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.about,
  );
  final TextEditingController firstName;
  final TextEditingController lastName;
  final TextEditingController email;
  final TextEditingController phone;
  final TextEditingController about;

  @override
  List<Object> get props => [firstName, lastName, email, phone, about];
}

class AboutChanged extends UpdatePersonalEvent {
  const AboutChanged(this.about);

  final String about;

  @override
  List<Object> get props => [about];
}

class PhoneChanged extends UpdatePersonalEvent {
  const PhoneChanged(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

class Submitted extends UpdatePersonalEvent {
  const Submitted();
}
