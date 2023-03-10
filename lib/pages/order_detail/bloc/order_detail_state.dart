part of 'order_detail_cubit.dart';

enum OrderDetailStatus { pending, onHold, processing, completed }
enum UpdateOrderStatus { initial, notChange, failure, success }

class OrderDetailState extends BaseState {
  final OrderData? orderDetail;
  final BaseState actionState;
  final BaseState buttonState;
  final OrderDetailStatus orderStatus;
  final UpdateOrderStatus updateOrderStatus;
  final bool onChangedStatus;
  final bool updateData;
  const OrderDetailState({
    this.orderDetail,
    this.actionState = const InitState(),
    this.buttonState = const InitState(),
    this.orderStatus = OrderDetailStatus.pending,
    this.updateOrderStatus = UpdateOrderStatus.initial,
    this.onChangedStatus = false,
    this.updateData = false,
  });

  @override
  List<Object?> get props => [
        orderDetail,
        orderStatus,
        actionState,
        buttonState,
        updateOrderStatus,
        onChangedStatus,
      ];

  OrderDetailState copyWith({
    OrderData? orderDetail,
    BaseState? actionState,
    BaseState? buttonState,
    OrderDetailStatus? orderStatus,
    UpdateOrderStatus? updateOrderStatus,
    bool? onChangedStatus,
    bool? updateData,
  }) {
    return OrderDetailState(
      orderDetail: orderDetail ?? this.orderDetail,
      actionState: actionState ?? this.actionState,
      orderStatus: orderStatus ?? this.orderStatus,
      buttonState: buttonState ?? this.buttonState,
      updateOrderStatus: updateOrderStatus ?? this.updateOrderStatus,
      onChangedStatus: onChangedStatus ?? this.onChangedStatus,
      updateData: updateData ?? this.updateData,
    );
  }

  static dynamic mapOrderStatus({required dynamic key}) {
    if (key is String) {
      switch (key) {
        case "pending":
          return OrderDetailStatus.pending;
        case "processing":
          return OrderDetailStatus.processing;
        case "on-hold":
          return OrderDetailStatus.onHold;
        case "completed":
          return OrderDetailStatus.completed;
        default:
          return OrderDetailStatus.pending;
      }
    } else {
      switch (key) {
        case OrderDetailStatus.pending:
          return "pending";
        case OrderDetailStatus.processing:
          return "processing";
        case OrderDetailStatus.onHold:
          return "on-hold";
        case OrderDetailStatus.completed:
          return "completed";
        default:
          return "pending";
      }
    }
  }
}
