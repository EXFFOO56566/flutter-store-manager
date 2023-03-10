part of 'update_personal_address_bloc.dart';

abstract class UpdatePersonalAddressEvent extends Equatable {
  const UpdatePersonalAddressEvent();

  @override
  List<Object> get props => [];
}

class GetUpdatePersonalAddressEvent extends UpdatePersonalAddressEvent {
  const GetUpdatePersonalAddressEvent();
}

class SubmitAddressEvent extends UpdatePersonalAddressEvent {
  final Customers billing;
  final Customers shipping;
  const SubmitAddressEvent(this.billing, this.shipping);
  @override
  List<Object> get props => [billing, shipping];
}

class EnableShippingEvent extends UpdatePersonalAddressEvent {
  final bool enableShipping;

  const EnableShippingEvent(this.enableShipping);

  @override
  List<Object> get props => [enableShipping];
}

class EnableButtonEvent extends UpdatePersonalAddressEvent {
  final bool? enableButtonBilling;
  final bool? enableButtonShipping;

  const EnableButtonEvent(this.enableButtonBilling, this.enableButtonShipping);

  @override
  List<Object> get props => [];
}
