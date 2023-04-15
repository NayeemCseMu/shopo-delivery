import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopo_delivery/modules/dashboard/components/balance_withdraw_card.dart';
import 'package:shopo_delivery/modules/profile/controller/cubit/profile_cubit.dart';
import 'package:shopo_delivery/modules/withdraw/model/withdraw_model.dart';
import 'package:shopo_delivery/widgets/rounded_app_bar.dart';

import '/utils/status_code.dart';
import '/utils/utils.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_text_style.dart';
import '../../widgets/loading_widget.dart';
import '../dashboard/controller/dashboard_cubit.dart';
import 'components/withdraw_dialog.dart';
import 'controller/account_info/account_info_cubit.dart';
import 'controller/create_withdraw/create_withdraw_cubit.dart';
import 'controller/create_withdraw/create_withdraw_state_model.dart';
import 'controller/method_cubit/method_cubit.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    context.read<AccountInfoCubit>().getAllWithdrawList();
    context.read<MethodCubit>().getAllMethodList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //     const SystemUiOverlayStyle(statusBarColor: homeAppBar));

    final withdrawCubit = context.read<AccountInfoCubit>();
    return Scaffold(
      appBar: RoundedAppBar(
        titleText: "Wallet Screen",
        textColor: Colors.black,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AccountInfoCubit, AccountInfoState>(
            listener: (_, state) {
              if (state is AllWithdrawListLoaded) {
                log(state.toString(), name: 'Wallet Screen');
              }
            },
          ),
          BlocListener<CreateWithdrawCubit, CreateWithdrawStateModel>(
            listener: (_, state) {
              final withdraw = state.withdrawState;
              if (withdraw is CreateWithdrawError) {
                // Navigator.of(context).pop(true);
                Utils.errorSnackBar(context, withdraw.message);
              } else if (withdraw is CreateWithdrawLoaded) {
                // Navigator.of(context).pop(true);
                //Utils.showSnackBar(context, withdraw.message);
                withdrawCubit.getAllWithdrawList();
              }
            },
          ),
        ],
        child: BlocBuilder<AccountInfoCubit, AccountInfoState>(
          builder: (context, state) {
            if (state is AccountInfoLoading) {
              return const LoadingWidget();
            } else if (state is AccountInfoError) {
              if (state.statusCode == 503) {
                // return LoadedWithdrawList(
                // withdrawList: withdrawCubit.withdrawListModel);
              } else {
                return Center(
                    child: Text(state.message,
                        style: const TextStyle(color: redColor)));
              }
            } else if (state is AllWithdrawListLoaded) {
              return LoadedWithdrawList(withdrawList: state.withdrawList);
            }
            return const Center(child:  Text('Something went wrong!'));
          },
        ),
      ),
    );
  }
}

class LoadedWithdrawList extends StatelessWidget {
  const LoadedWithdrawList({Key? key, required this.withdrawList})
      : super(key: key);
  final List<WithdrawModel> withdrawList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // _balanceAndCreateWithDraw(context),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: BlocBuilder<DashboardCubit, DashboardState>(builder: (c, state) {
            if (state is DashboardStateLoading) {
              return const LoadingWidget();
            } else if (state is DashboardStateError) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is DashboardStateLoaded) {
              return BalanceAndWithdrawCard(dashboardModel: state.dashboardModel);
            }
            return const SizedBox();
          }),
        ),

        Flexible(
          child: ListView.builder(
            itemCount: withdrawList.length,
            shrinkWrap: true,
            //padding: const EdgeInsets.symmetric(horizontal: 20.0),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final result = withdrawList[index];
              // final icon = withdrawList.icon;
              return Container(
                height: 80.0,
                width: double.infinity,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: borderColor),
                    borderRadius: BorderRadius.circular(5.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          result.method,
                          style: KTextStyle.inter(
                              fs: 16.0, c: Colors.black, fw: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Text(
                            Utils.formatAmount(result.totalAmount),
                            style: KTextStyle.inter(
                                fs: 16.0, c: Colors.black, fw: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Utils.formatDate(result.createdAt),
                          style: KTextStyle.inter(
                              fs: 16.0, c: textGreyColor, fw: FontWeight.w400),
                        ),
                        Container(
                          height: 28.0.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: result.status == '1'
                                  ? greenColor.withOpacity(0.2)
                                  : redColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(24.0)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 2.0),
                            child: Text(
                              StatusCode.withdrawStatus(result.status),
                              style: KTextStyle.roboto(
                                  fs: 14.0,
                                  c: result.status == '1'
                                      ? greenColor
                                      : redColor,
                                  fw: FontWeight.w400),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Container _balanceAndCreateWithDraw(BuildContext context) {
    return Container(
      height: 100.0,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Current Balance',
                style: KTextStyle.inter(
                    fs: 14.0, c: Colors.white, fw: FontWeight.w400),
              ),
              // const SizedBox(height: 6.0),

              BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                if (state is ProfileStateLoaded) {
                  final item = state.deliveryManProfile;
                  return Text(
                    Utils.formatAmount(item.currentProductAmount),
                    style: KTextStyle.sourceOpenPro(
                        fs: 25.0, c: Colors.white, fw: FontWeight.w700),
                  );
                }
                return const SizedBox();
              }),
            ],
          ),
          SizedBox(
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => const WithdrawDialog());
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                elevation: MaterialStateProperty.all(0.0),
              ),
              child: Text(
                'Withdraw',
                style: KTextStyle.sourceOpenPro(
                    fs: 16.0, c: Colors.black, fw: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
