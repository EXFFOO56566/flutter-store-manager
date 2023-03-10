part of 'update_personal_address_bloc.dart';

class UpdatePersonalAddressState extends Equatable {
  final Customers? billing;
  final Customers? shipping;
  final FormzStatus statusSaveAddress;
  final bool enableShipping;
  final bool enableButtonBilling;
  final bool enableButtonShipping;
  final bool enableInitData;
  const UpdatePersonalAddressState({
    this.billing,
    this.shipping,
    this.statusSaveAddress = FormzStatus.valid,
    this.enableShipping = true,
    this.enableButtonBilling = true,
    this.enableButtonShipping = false,
    this.enableInitData = true,
  });

  @override
  List<Object?> get props => [
        billing,
        shipping,
        statusSaveAddress,
        enableShipping,
        enableButtonBilling,
        enableButtonShipping,
        enableInitData,
      ];

  UpdatePersonalAddressState copyWith({
    Customers? billing,
    Customers? shipping,
    FormzStatus? statusSaveAddress,
    bool? enableShipping,
    bool? enableButtonBilling,
    bool? enableButtonShipping,
    bool? enableInitData,
  }) {
    return UpdatePersonalAddressState(
      billing: billing ?? this.billing,
      shipping: shipping ?? this.shipping,
      statusSaveAddress: statusSaveAddress ?? this.statusSaveAddress,
      enableShipping: enableShipping ?? this.enableShipping,
      enableButtonBilling: enableButtonBilling ?? this.enableButtonBilling,
      enableButtonShipping: enableButtonShipping ?? this.enableButtonShipping,
      enableInitData:enableInitData ?? this.enableInitData,
    );
  }
}
