import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopo_delivery/modules/withdraw/controller/method_cubit/method_cubit.dart';
import 'package:shopo_delivery/modules/withdraw/model/method_model.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/primary_button.dart';
import '../../authentication/widgets/sign_up_form.dart';
import '../controller/account_info/account_info_cubit.dart';
import '../controller/create_withdraw/create_withdraw_cubit.dart';
import '../controller/create_withdraw/create_withdraw_state_model.dart';
import '../controller/single_account_info/single_account_info_cubit.dart';
import '../model/account_info_model.dart';
import 'account_info_dialog.dart';

class WithdrawDialog extends StatelessWidget {
  const WithdrawDialog({Key? key}) : super(key: key);
  final _className = 'WithdrawDialog';

  @override
  Widget build(BuildContext context) {
    final withdrawCubit = context.read<CreateWithdrawCubit>();
    final accountCubit = context.read<SingleAccountInfoCubit>();
    final methodList = context.read<MethodCubit>().methods;
    return AlertDialog(
      content: MultiBlocListener(
        listeners: [
          BlocListener<CreateWithdrawCubit, CreateWithdrawStateModel>(
            listener: (_, state) {
              final withdraw = state.withdrawState;
              if (withdraw is CreateWithdrawError) {
                Navigator.of(context).pop(true);
                Utils.errorSnackBar(context, withdraw.message);
              } else if (withdraw is CreateWithdrawLoaded) {
                Navigator.of(context).pop(true);
                Utils.showSnackBar(context, withdraw.message);
              }
            },
          ),
          BlocListener<SingleAccountInfoCubit, SingleAccountInfoState>(
            listener: (context, state) {
              if (state is SingleAccountInfoLoading) {
                log(state.toString(), name: _className);
              } else if (state is SingleAccountInfoError) {
                Utils.errorSnackBar(context, state.message);
              } else if (state is SingleAccountInfoLoaded) {
                showDialog<void>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext dialogContext) {
                    return AccountInfoDialog(accountInfo: state.accountInfo);
                  },
                );
              }
            },
          ),
        ],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('New Withdraw'),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const CustomImage(
                    path: Kimages.cancel,
                    height: 15.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            BlocBuilder<CreateWithdrawCubit, CreateWithdrawStateModel>(
              builder: (context, state) {
                final amount = state.withdrawState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<MethodModel>(
                      hint: const Text('Select Method'),
                      items: methodList
                          .map<DropdownMenuItem<MethodModel>>(
                              (account) => DropdownMenuItem(
                                    value: account,
                                    child: Text(account.name),
                                  ))
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        withdrawCubit.changeMethodId(value.id.toString());
                        accountCubit.getAccountInformation(value.id.toString());
                      },
                      icon: const Icon(Icons.keyboard_arrow_down),
                      isDense: true,
                      isExpanded: true,
                    ),
                    if (amount is CreateWithdrawFormError) ...[
                      if (amount.errors.methodId.isNotEmpty)
                        ErrorText(text: amount.errors.methodId.first)
                    ]
                  ],
                );
              },
            ),
            const SizedBox(height: 14.0),
            BlocBuilder<CreateWithdrawCubit, CreateWithdrawStateModel>(
              builder: (context, state) {
                final amount = state.withdrawState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'Withdraw Amount'),
                      keyboardType: TextInputType.number,
                      initialValue: state.withdrawAmount,
                      onChanged: (String amount) =>
                          withdrawCubit.changeAmount(amount),
                    ),
                    if (amount is CreateWithdrawFormError) ...[
                      if (amount.errors.withdrawAmount.isNotEmpty)
                        ErrorText(text: amount.errors.withdrawAmount.first)
                    ]
                  ],
                );
              },
            ),
            const SizedBox(height: 14.0),
            BlocBuilder<CreateWithdrawCubit, CreateWithdrawStateModel>(
              builder: (context, state) {
                final amount = state.withdrawState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Account Information'),
                      keyboardType: TextInputType.text,
                      initialValue: state.accountInfo,
                      onChanged: (String amount) =>
                          withdrawCubit.changeBankInfo(amount),
                      maxLines: 3,
                    ),
                    if (amount is CreateWithdrawFormError) ...[
                      if (amount.errors.accountInfo.isNotEmpty)
                        ErrorText(text: amount.errors.accountInfo.first)
                    ]
                  ],
                );
              },
            ),
            const SizedBox(height: 14.0),
            BlocBuilder<CreateWithdrawCubit, CreateWithdrawStateModel>(
              builder: (context, state) {
                final amount = state.withdrawState;
                if (amount is CreateWithdrawLoading) {
                  return const LoadingWidget();
                }
                return PrimaryButton(
                  onPressed: () {
                    Utils.closeKeyBoard(context);
                    withdrawCubit.createWithdrawMethod();
                  },
                  text: 'Withdraw',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
