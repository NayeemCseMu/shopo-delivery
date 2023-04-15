import 'package:equatable/equatable.dart';

import 'create_withdraw_cubit.dart';

class CreateWithdrawStateModel extends Equatable {
  final String methodId;
  final String withdrawAmount;
  final String accountInfo;
  final CreateWithdrawState withdrawState;

  const CreateWithdrawStateModel({
    this.methodId = '',
    this.withdrawAmount = '',
    this.accountInfo = '',
    this.withdrawState = const CreateWithdrawInitial(),
  });

  CreateWithdrawStateModel copyWith({
    String? methodId,
    String? withdrawAmount,
    String? accountInfo,
    CreateWithdrawState? withdrawState,
  }) {
    return CreateWithdrawStateModel(
      methodId: methodId ?? this.methodId,
      withdrawAmount: withdrawAmount ?? this.withdrawAmount,
      accountInfo: accountInfo ?? this.accountInfo,
      withdrawState: withdrawState ?? this.withdrawState,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'method_id': methodId,
      'withdraw_amount': withdrawAmount,
      'account_info': accountInfo,
    };
  }

  CreateWithdrawStateModel clear() {
    return const CreateWithdrawStateModel(
      methodId: '',
      withdrawAmount: '',
      accountInfo: '',
      withdrawState: CreateWithdrawInitial(),
    );
  }

  @override
  List<Object> get props => [
        methodId,
        withdrawAmount,
        accountInfo,
        withdrawState,
      ];
}
