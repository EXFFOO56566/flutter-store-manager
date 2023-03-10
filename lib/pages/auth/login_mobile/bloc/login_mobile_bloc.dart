import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_store_manager/constants/auth.dart';
import 'package:formz/formz.dart';
import 'package:flutter_store_manager/themes.dart';

import '../models/models.dart';

part 'login_mobile_event.dart';

part 'login_mobile_state.dart';

class LoginMobileBloc extends Bloc<LoginMobileEvent, LoginMobileState> {
  LoginMobileBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const LoginMobileState()) {
    on<LoginPhoneChanged>(_onPhoneChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<LoginDigitsSubmitted>(_onLoginDigitsSubmitted);
    on<RegisterDigitsSubmitted>(_onRegisterDigitsSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onPhoneChanged(LoginPhoneChanged event, Emitter<LoginMobileState> emit) {
    final phone = Phone.dirty(event.phone);
    emit(state.copyWith(
      phone: phone,
      status: Formz.validate([phone]),
    ));
  }

  void _onSubmitted(LoginSubmitted event, Emitter<LoginMobileState> emit) async {
    if (event.token != '') {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _authenticationRepository.logIn(
          requestData: RequestData(
            data: {
              'type': 'phone',
              'token': event.token,
              'role': userRole,
            },
          ),
        );
        await event.callback();
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (e) {
        await event.callback(false, e);
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }

  void _onRegisterSubmitted(RegisterSubmitted event, Emitter<LoginMobileState> emit) async {
    if (state.phone.value?.completeNumber != '') {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _authenticationRepository.register(
          requestData: RequestData(
            data: {
              'enable_phone_number': true,
              'phone': state.phone.value?.completeNumber,
              'role': userRole,
            },
            contentTypeHeader: 'application/x-www-form-urlencoded',
          ),
        );
        await event.callback();
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (e) {
        await event.callback(false, e);
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }

  void _onLoginDigitsSubmitted(LoginDigitsSubmitted event, Emitter<LoginMobileState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.digitsLogin(
        requestData: RequestData(
          data: event.data,
          contentTypeHeader: 'application/x-www-form-urlencoded',
        ),
      );
      await event.callback();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      await event.callback(false, e);
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  void _onRegisterDigitsSubmitted(RegisterDigitsSubmitted event, Emitter<LoginMobileState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.digitsRegister(
        requestData: RequestData(
          data: event.data,
          contentTypeHeader: 'application/x-www-form-urlencoded',
        ),
      );
      await event.callback();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      await event.callback(false, e);
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
