part of 'update_personal_bloc.dart';

class UpdatePersonalState extends BaseState {
  final FormzStatus status;
  final BaseState actionState;
  final FistName firstName;
  final LastName lastName;
  final EmailModel email;
  final PersonalPhone phone;
  final About about;
  final ImagePersonal image;
  final Personal? personal;
  final String? errorMessage;
  final bool isSelectdImage;
  final String imageSrc;

  const UpdatePersonalState({
    this.status = FormzStatus.pure,
    this.image = const ImagePersonal.pure(),
    this.actionState = const InitState(),
    this.firstName = const FistName.pure(),
    this.lastName = const LastName.pure(),
    this.email = const EmailModel.pure(),
    this.phone = const PersonalPhone.pure(),
    this.about = const About.pure(),
    this.personal,
    this.errorMessage = 'error',
    this.isSelectdImage = false,
    this.imageSrc = '',
  });

  @override
  List<Object?> get props => [
        status,
        actionState,
        firstName,
        lastName,
        email,
        phone,
        about,
        image,
        personal,
        errorMessage,
        isSelectdImage,
        imageSrc,
      ];
  UpdatePersonalState copyWith({
    FormzStatus? status,
    ImagePersonal? image,
    String? imageSrc,
    BaseState? actionState,
    FistName? firstName,
    bool? validFirstName,
    LastName? lastName,
    EmailModel? email,
    About? about,
    PersonalPhone? phone,
    Personal? personal,
    String? errorMessage,
    bool? isSelectdImage,
  }) {
    return UpdatePersonalState(
      personal: personal ?? this.personal,
      status: status ?? this.status,
      actionState: actionState ?? this.actionState,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      about: about ?? this.about,
      image: image ?? this.image,
      errorMessage: errorMessage ?? this.errorMessage,
      isSelectdImage: isSelectdImage ?? this.isSelectdImage,
      imageSrc: imageSrc ?? this.imageSrc,
    );
  }
}
