part of 'delete_account_cubit.dart';

class DeleteAccountState extends Equatable {
  const DeleteAccountState({
    this.status = const InitState(),
    this.statusSendOtp = const InitState(),
    this.isAgree = false,
    this.reason,
  });

  final BaseState status;
  final BaseState statusSendOtp;
  final Option? reason;
  final bool isAgree;

  DeleteAccountState copyWith({
    BaseState? status,
    BaseState? statusSendOtp,
    Option? reason,
    bool? isAgree,
  }) {
    return DeleteAccountState(
      status: status ?? this.status,
      statusSendOtp: statusSendOtp ?? this.statusSendOtp,
      reason: reason ?? this.reason,
      isAgree: isAgree ?? this.isAgree,
    );
  }

  @override
  List<Object?> get props => [status, statusSendOtp, isAgree, reason];
}
