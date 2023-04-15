import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopo_delivery/modules/order/controller/cubit/cubit/order_details_cubit.dart';
import 'package:shopo_delivery/utils/constants.dart';
import 'package:shopo_delivery/utils/utils.dart';
import 'package:shopo_delivery/widgets/capitalized_word.dart';
import 'package:shopo_delivery/widgets/separator.dart';

import 'bill_info.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shrinkWrap: true,
      children: [
        const ProductItems(),
        const SizedBox(height: 16),
        const OrderInfo(),
        const SizedBox(height: 16),
        const AddressInfo(),
        const SizedBox(height: 16),
        const BillInfo(),
        SizedBox(height: size.height * 0.3),
      ],
    );
  }
}

class ProductItems extends StatelessWidget {
  const ProductItems({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
      builder: (context, state) {
        if (state is OrderDetailsStateLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Order Summery",
                style: TextStyle(
                  color: blackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10.0),
              ...List.generate(
                state.orders.orderProducts.length,
                (index) => Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: productCardColor,
                          borderRadius: BorderRadius.circular(4)),
                      margin: const EdgeInsets.only(bottom: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.orders.orderProducts[index].productName,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text.rich(TextSpan(
                              text: "Ticket ID: ",
                              style: const TextStyle(
                                color: textGreyColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                TextSpan(
                                    text:
                                        "${state.orders.orderProducts[index].qty}",
                                    style: const TextStyle(
                                      color: blackColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ))
                              ])),
                          const SizedBox(height: 8),
                          Text.rich(TextSpan(
                              text: "Ticket ID: ",
                              style: const TextStyle(
                                color: textGreyColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                TextSpan(
                                    text: Utils.formatAmount(state
                                        .orders.orderProducts[index].unitPrice),
                                    style: const TextStyle(
                                      color: redColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ))
                              ])),
                        ],
                      ),
                    ),
                    if(index != state.orders.orderProducts.length-1)
                    const MySeparator(),
                  ],
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // expandedAlignment: Alignment.centerLeft,
      children: [
        BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
          builder: (context, state) {
            if (state is OrderDetailsStateLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Order Info",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: borderColor)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Utils.formatDate(state.orders.createdAt),
                                  style: const TextStyle(
                                    color: textGreyColor,
                                    fontSize: 14,
                                    letterSpacing: .5,
                                    wordSpacing: 1.2,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: cardBgGreyColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text.rich(TextSpan(
                                        text: "Order Id: ",
                                        style: const TextStyle(
                                          color: textGreyColor,
                                          fontSize: 16,
                                          letterSpacing: .5,
                                          wordSpacing: 1.2,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        children: [
                                          TextSpan(
                                              text: state.orders.orderId,
                                              style: const TextStyle(
                                                color: primaryColor,
                                                fontSize: 16,
                                                wordSpacing: 1.2,
                                                fontWeight: FontWeight.w600,
                                              ))
                                        ]))),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Order Status",
                                  style: TextStyle(
                                    color: textGreyColor,
                                    fontSize: 14,
                                    letterSpacing: .5,
                                    wordSpacing: 1.2,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color:
                                        Utils.getBgColor(state.orders.orderStatus),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Text(
                                    Utils.orderStatus(state.orders.orderStatus),
                                    style: TextStyle(
                                      color:
                                          Utils.textColor(state.orders.orderStatus),
                                      fontSize: 13,
                                      letterSpacing: .5,
                                      wordSpacing: 1.2,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 13),
                        Text.rich(TextSpan(
                            text: "Shipping: ",
                            style: const TextStyle(
                              color: blackColor,
                              fontSize: 16,
                              letterSpacing: 1,
                              wordSpacing: 1.2,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                  text: state.orders.shippingMethod
                                      .capitalizeByWord(),
                                  style: const TextStyle(
                                    color: greenColor,
                                    fontSize: 14,
                                    letterSpacing: .5,
                                    wordSpacing: 1.2,
                                    fontWeight: FontWeight.w400,
                                  ))
                            ])),
                        const Divider(
                          height: 30,
                          color: borderColor,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Method",
                                  style: TextStyle(
                                    color: textGreyColor,
                                    fontSize: 14,
                                    letterSpacing: .5,
                                    wordSpacing: 1.2,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  state.orders.paymentMethod,
                                  style: const TextStyle(
                                    color: blackColor,
                                    fontSize: 18,
                                    letterSpacing: .5,
                                    wordSpacing: 1.2,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Payment Status",
                                  style: TextStyle(
                                    color: textGreyColor,
                                    fontSize: 14,
                                    letterSpacing: .5,
                                    wordSpacing: 1.2,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Utils.getBgColor(
                                        state.orders.paymentStatus),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Text(
                                    Utils.paymentStatus(state.orders.paymentStatus),
                                    style: TextStyle(
                                      color: Utils.textColor(
                                          state.orders.paymentStatus),
                                      fontSize: 13,
                                      letterSpacing: .5,
                                      wordSpacing: 1.2,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),

      ],
    );
  }
}

class AddressInfo extends StatelessWidget {
  const AddressInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
          builder: (context, state) {
            if (state is OrderDetailsStateLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Customer Info",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          state.orders.orderAddress.shippingName,
                          style: const TextStyle(
                            color: textGreyColor,
                            fontSize: 16,
                            letterSpacing: .5,
                            wordSpacing: 1.2,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          state.orders.orderAddress.shippingEmail,
                          style: const TextStyle(
                            color: textGreyColor,
                            fontSize: 16,
                            letterSpacing: .5,
                            wordSpacing: 1.2,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          state.orders.orderAddress.shippingAddress,
                          style: const TextStyle(
                            color: textGreyColor,
                            fontSize: 16,
                            letterSpacing: .5,
                            wordSpacing: 1.2,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
