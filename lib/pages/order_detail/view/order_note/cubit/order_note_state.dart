part of 'order_note_cubit.dart';

class OrderNoteState extends BaseState {
  final List<OrderNote>? orderNotes;
  final BaseState actionState;
  final String? addNoteValue;
  final String? selectedCustomer;
  final BaseState addLoadingState;

  const OrderNoteState({
    this.orderNotes,
    this.actionState = const InitState(),
    this.addLoadingState = const InitState(),
    this.addNoteValue = '',
    this.selectedCustomer = '0',
  });

  @override
  List<Object?> get props => [
        orderNotes,
        actionState,
        addLoadingState,
        addNoteValue,
        selectedCustomer,
      ];

  OrderNoteState copyWith({
    List<OrderNote>? orderNotes,
    BaseState? actionState,
    BaseState? addLoadingState,
    String? addNoteValue,
    String? selectedCustomer,
  }) {
    return OrderNoteState(
      orderNotes: orderNotes ?? this.orderNotes,
      actionState: actionState ?? this.actionState,
      addLoadingState: addLoadingState ?? this.addLoadingState,
      addNoteValue: addNoteValue ?? this.addNoteValue,
      selectedCustomer: selectedCustomer ?? this.selectedCustomer,
    );
  }
}
