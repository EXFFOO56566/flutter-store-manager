import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'login_social_event.dart';

part 'login_social_state.dart';

class LoginSocialBloc extends Bloc<LoginSocialEvent, LoginSocialState> {
  LoginSocialBloc({
    required AuthenticationRepository authenticationRepository,
    required void Function(FormzStatus status) onChangeStatus,
  })  : _authenticationRepository = authenticationRepository,
        _onChangeStatus = onChangeStatus,
        super(const LoginSocialState()) {
    on<LoginSocialSubmitted>(_onLoginSocialSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;
  final void Function(FormzStatus status) _onChangeStatus;

  void _onLoginSocialSubmitted(LoginSocialSubmitted event, Emitter<LoginSocialState> emit) async {
    _onChangeStatus(FormzStatus.submissionInProgress);
    try {
      await _authenticationRepository.logIn(
        requestData: RequestData(
          query: event.queryParameters,
        ),
      );
      _onChangeStatus(FormzStatus.submissionSuccess);
      if (event.queryParameters['callback'] != null) {
        await event.queryParameters['callback'].call();
      }
    } catch (_) {
      _onChangeStatus(FormzStatus.submissionFailure);
    }
  }
}
