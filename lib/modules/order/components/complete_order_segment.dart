import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/language_string.dart';
import '../../../utils/utils.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/primary_button.dart';
import '../controller/cubit/cubit/complete_order_cubit.dart';

class CompleteOrder extends StatelessWidget {
  const CompleteOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompleteOrderCubit, CompleteOrderState>(
      builder: (context, state) {
        if (state is CompleteOrderLoading) {
          return const Center(child:  LoadingWidget());
        } else if (state is CompleteOrderStateError) {
          return Center(child: Text(state.message));
        } else if (state is CompleteOrderStateLoaded) {
          return Column(
            children: [
              if(state.orders.isEmpty)...[
                const Center(child:EmptyOrderComponent())
              ]else
              ...List.generate(
                  state.orders.length,
                  (index) => Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: borderColor)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        Language.customer,
                                        style: TextStyle(
                                          color: textGreyColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color:
                                                primaryColor.withOpacity(0.12),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            state.orders[index].user.name,
                                            style: const TextStyle(
                                              color: primaryColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        "Date",
                                        style: TextStyle(
                                          color: textGreyColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        Utils.formatDate(
                                            state.orders[index].createdAt),
                                        style: const TextStyle(
                                          color: blackColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 13),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        Language.total,
                                        style: TextStyle(
                                          color: textGreyColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        Utils.formatAmount(
                                            state.orders[index].totalAmount),
                                        style: const TextStyle(
                                          color: primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        Language.paymentMethod,
                                        style: TextStyle(
                                          color: textGreyColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        state.orders[index].paymentMethod,
                                        style: const TextStyle(
                                          color: blackColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              PrimaryButton(
                                bgColor: Colors.black,
                                textColor: Colors.white,
                                borderRadiusSize: 4,
                                fontSize: 16,
                                text: "Check Details Now",
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, RouteNames.details,
                                      arguments:
                                          state.orders[index].id.toString());
                                },
                              )
                            ]),
                      ))
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
