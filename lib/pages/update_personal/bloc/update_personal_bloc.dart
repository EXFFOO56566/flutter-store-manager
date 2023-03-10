import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/common/widgets/image/image.dart';
import 'package:flutter_store_manager/mixins/utility_mixin.dart';
import 'package:formz/formz.dart';
import 'package:media_repository/media_repository.dart';
import 'package:personal_repository/personal_repository.dart';
import 'package:user_repository/user_repository.dart';

import '../models/models.dart';

part 'update_personal_event.dart';
part 'update_personal_state.dart';

class UpdatePersonalBloc extends Bloc<UpdatePersonalEvent, UpdatePersonalState> {
  final PersonalRepository personalRepository;
  final MediaRepository mediaRepository;
  final RequestCancel _cancelToken = RequestCancel();
  final void Function(BaseState store)? onChanged;
  final String token;
  final User user;
  UpdatePersonalBloc({
    required this.personalRepository,
    required this.mediaRepository,
    required this.token,
    required this.user,
    this.onChanged,
    Equatable? value,
  }) : super(value != null ? value as UpdatePersonalState : const UpdatePersonalState()) {
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<ImageChanged>(_onImageChanged);
    on<AboutChanged>(_onAboutChanged);
    on<PhoneChanged>(_onPhoneChanged);
    on<ImageDeletedChanged>(_onImageDeletedChanged);
    on<InitData>(_initData);
    on<Submitted>(_onSubmit);
  }

  ///init data
  void _initData(InitData event, Emitter<UpdatePersonalState> emit) async {
    if (state.personal == null) {
      emit(state.copyWith(actionState: const LoadingState()));
    }
    try {
      event.firstName.text = state.personal?.firstName ?? '';
      event.lastName.text = state.personal?.lastName ?? '';
      event.email.text = state.personal?.email ?? '';
      event.phone.text = state.personal?.phone ?? '';
      event.about.text = state.personal?.description ?? '';
      final res = await personalRepository.getVendorProfile(
        requestData: RequestData(
          token: token,
          query: {'app-builder-decode': true},
        ),
      );
      Personal personal = Personal.fromJson(res?['personal'] ?? {});
      event.firstName.text = personal.firstName ?? '';
      event.lastName.text = personal.lastName ?? '';
      event.email.text = personal.email ?? '';
      event.phone.text = personal.phone ?? '';
      event.about.text = personal.description ?? '';
      emit(state.copyWith(
        personal: personal,
        actionState: const LoadedState(),
        firstName: FistName.pure(personal.firstName ?? ''),
        lastName: LastName.pure(personal.lastName ?? ''),
        email: EmailModel.pure(personal.email ?? ''),
        phone: PersonalPhone.pure(personal.phone ?? ''),
        about: About.pure(personal.description ?? ''),
        image: personal.avatarSrc != null
            ? ImagePersonal.dirty(ImageData(
                type: ImageDataType.image,
                image: ImageLink(
                  id: ConvertData.stringToInt(personal.avatar),
                  src: personal.avatarSrc ?? '',
                )))
            : const ImagePersonal.pure(),
        imageSrc: personal.avatarSrc ?? '',
      ));
    } catch (e) {
      emit(state.copyWith(actionState: const ErrorState()));
      avoidPrint("ERR at updatePersonal in update_personal_cubit");
    }
  }

  void _onFirstNameChanged(FirstNameChanged event, Emitter<UpdatePersonalState> emit) {
    final firstName = FistName.dirty(event.firstName);
    emit(state.copyWith(
      firstName: firstName,
      status: Formz.validate([firstName, state.lastName, state.email]),
    ));
  }

  void _onLastNameChanged(LastNameChanged event, Emitter<UpdatePersonalState> emit) {
    final lastName = LastName.dirty(event.lastName);
    emit(state.copyWith(
      lastName: lastName,
      status: Formz.validate([lastName, state.firstName, state.email]),
    ));
  }

  void _onEmailChanged(EmailChanged event, Emitter<UpdatePersonalState> emit) {
    final email = EmailModel.dirty(event.email);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.lastName, state.firstName]),
    ));
  }

  void _onAboutChanged(AboutChanged event, Emitter<UpdatePersonalState> emit) {
    final about = About.dirty(event.about);
    emit(state.copyWith(
      about: about,
    ));
  }

  void _onPhoneChanged(PhoneChanged event, Emitter<UpdatePersonalState> emit) {
    final phone = PersonalPhone.dirty(event.phone);
    emit(state.copyWith(
      phone: phone,
    ));
  }

  void _onImageChanged(ImageChanged event, Emitter<UpdatePersonalState> emit) {
    emit(state.copyWith(
      image: ImagePersonal.dirty(event.image),
      isSelectdImage: event.isSelectdImage,
    ));
  }

  void _onImageDeletedChanged(ImageDeletedChanged event, Emitter<UpdatePersonalState> emit) {
    emit(state.copyWith(image: const ImagePersonal.pure()));
  }

  Future<String> _postImage() async {
    String imageId = '';
    if (state.isSelectdImage == true) {
      if (state.image.value?.file != null) {
        try {
          String path = state.image.value!.file!.path;
          FormData formData = FormData.fromMap({
            'file': await MultipartFile.fromFile(
              path,
              filename: path.split('/').last,
            ),
          });
          Media res = await mediaRepository.postMedia(
              requestData: RequestData(
            data: formData,
            token: token,
            query: {'app-builder-decode': true},
          ));
          imageId = "${res.id}";
        } catch (e) {
          avoidPrint("ERR at post img at update_personal_cubit");
        }
      }
      if (state.image.value?.image != null) {
        imageId = "${state.image.value?.image?.id}";
      }
      if (state.image.value?.image == null && state.image.value?.file == null) {
        imageId = "";
      }
    }
    return imageId;
  }

  void _onSubmit(Submitted event, Emitter<UpdatePersonalState> emit) async {
    final firstName = FistName.dirty(state.firstName.value);
    final lastName = LastName.dirty(state.lastName.value);
    final email = EmailModel.dirty(state.email.value);

    FormzStatus status = Formz.validate([firstName, lastName, email]);
    if (status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      String imageId = await _postImage();

      try {
        Map<String, dynamic> data = {
          'first_name': state.firstName.value,
          'last_name': state.lastName.value,
          'email': state.email.value,
          'phone': state.phone.value,
          'description': state.about.value,
          'avatar': imageId.isNotEmpty ? imageId : state.personal!.avatar,
        };

        Map personalData = await personalRepository.updatePersonal(
          requestData: RequestData(
            data: {'personal': data},
            token: token,
            cancelToken: _cancelToken,
            query: {'app-builder-decode': true},
          ),
        );
        dynamic imageSrc = get(personalData, ['personal', 'avatar_src'], '');
        emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          isSelectdImage: false,
          imageSrc: imageSrc is String ? imageSrc : '',
        ));
      } on RequestError catch (e) {
        emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: e.message,
        ));
      }
    } else {
      emit(state.copyWith(firstName: firstName, lastName: lastName, email: email, status: status));
    }
  }

  @override
  void onChange(Change<UpdatePersonalState> change) {
    super.onChange(change);
    if (onChanged != null) {
      onChanged!(change.nextState);
    }
  }

  @override
  Future<void> close() {
    _cancelToken.cancel();
    return super.close();
  }
}
