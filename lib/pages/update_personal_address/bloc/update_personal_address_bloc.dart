import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:bloc/bloc.dart';
import 'package:customers_repository/customers_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';

part 'update_personal_address_event.dart';
part 'update_personal_address_state.dart';

class UpdatePersonalAddressBloc extends Bloc<UpdatePersonalAddressEvent, UpdatePersonalAddressState> {
  final CustomersRepository customersRepository;
  final String token;
  final User user;
  final RequestCancel _cancelToken = RequestCancel();
  final void Function(Equatable store)? onChanged;
  UpdatePersonalAddressBloc({
    required this.customersRepository,
    required this.user,
    required this.token,
    this.onChanged,
    Equatable? value,
  }) : super(value != null ? value as UpdatePersonalAddressState : const UpdatePersonalAddressState()) {
    on<GetUpdatePersonalAddressEvent>(_getCustomers);
    on<SubmitAddressEvent>(_onSubmitAddress);
    on<EnableShippingEvent>(_onChangedEnableShipping);
    on<EnableButtonEvent>(_onChangedEnableButton);
  }
  Future<void> _getCustomers(GetUpdatePersonalAddressEvent event, Emitter<UpdatePersonalAddressState> emit) async {
    emit(state.copyWith(enableInitData: true));
    try {
      final data = await customersRepository.getCustomers(
        id: ConvertData.stringToInt(user.id),
        requestData: RequestData(
          query: {'app-builder-decode': true},
          token: token,
        ),
      );

      Customers billing = Customers.fromJson(data['billing'] ?? {});
      Customers shipping = Customers.fromJson(data['shipping'] ?? {});
      emit(state.copyWith(billing: billing, shipping: shipping));
    } on RequestError catch (_) {
      rethrow;
    }
  }

  void _onChangedEnableShipping(EnableShippingEvent event, Emitter<UpdatePersonalAddressState> emit) async {
    emit(state.copyWith(enableShipping: event.enableShipping));
  }

  void _onChangedEnableButton(EnableButtonEvent event, Emitter<UpdatePersonalAddressState> emit) async {
    emit(state.copyWith(
      enableButtonBilling: event.enableButtonBilling,
      enableButtonShipping: event.enableButtonShipping,
      enableInitData: false,
    ));
  }

  void _onSubmitAddress(SubmitAddressEvent event, Emitter<UpdatePersonalAddressState> emit) async {
    emit(state.copyWith(enableInitData: false));
    Map<String, dynamic> billing = {
      "first_name": event.billing.firstName,
      "last_name": event.billing.lastName,
      "address_1": event.billing.address1,
      "address_2": event.billing.address2,
      "city": event.billing.city,
      "postcode": event.billing.postCode,
      "country": event.billing.country,
      "state": event.billing.state,
    };
    Map<String, dynamic> data = state.enableShipping == false
        ? {
            "billing": billing,
            "shipping": {
              "first_name": event.shipping.firstName,
              "last_name": event.shipping.lastName,
              "address_1": event.shipping.address1,
              "address_2": event.shipping.address2,
              "city": event.shipping.city,
              "postcode": event.shipping.postCode,
              "country": event.shipping.country,
              "state": event.shipping.state,
            },
          }
        : {
            "billing": billing,
          };
    try {
      emit(state.copyWith(statusSaveAddress: FormzStatus.submissionInProgress));
      await customersRepository.updateCustomers(
        id: ConvertData.stringToInt(user.id),
        requestData: RequestData(
          data: data,
          query: {'app-builder-decode': true},
          cancelToken: _cancelToken,
          token: token,
        ),
      );
      emit(state.copyWith(
        statusSaveAddress: FormzStatus.submissionSuccess,
      ));
    } catch (_) {
      emit(state.copyWith(
        statusSaveAddress: FormzStatus.submissionFailure,
      ));
    }
  }

  @override
  void onChange(Change<UpdatePersonalAddressState> change) {
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
