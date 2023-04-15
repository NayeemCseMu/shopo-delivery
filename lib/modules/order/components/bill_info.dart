import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants.dart';
import '../../../widgets/separator.dart';
import '../controller/cubit/cubit/order_details_cubit.dart';

class BillInfo extends StatelessWidget {
  const BillInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
        builder: (context, state) {
          if (state is OrderDetailsStateLoaded) {
            final element = state.orders;
            final total = double.parse(element.totalAmount) +
                double.parse(element.shippingCost);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Bill Info",
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: borderColor)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      // controller: scrollController,
                      // padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Container(
                        //   margin: const EdgeInsets.only(bottom: 24.0, top: 10.0),
                        //   decoration: BoxDecoration(
                        //     color: Colors.grey,
                        //     borderRadius: BorderRadius.circular(4),
                        //   ),
                        //   height: 4,
                        //   width: 60,
                        // ),

                        _billInfo('SubTotal', '\$${element.totalAmount}',
                            const Color(0xFF2E2E2E), const Color(0xFF2E2E2E)),
                        const Padding(
                          padding:  EdgeInsets.symmetric(vertical: 10),
                          child:  MySeparator(),
                        ),
                        _billInfo('Shipping Cost', '\$${element.shippingCost}',
                            redColor, const Color(0xFF2E2E2E)),
                        // _billInfo(
                        //     'Coupon Coast',
                        //     '\$${double.parse(order.couponCoast).toStringAsFixed(2)}',
                        //     redColor,
                        //     redColor),

                        const Padding(
                          padding:  EdgeInsets.symmetric(vertical: 10),
                          child:  MySeparator(),
                        ),
                        _billInfo('Total', '\$$total', const Color(0xFF2E2E2E),
                            const Color(0xFF2E2E2E)),
                        // _billInfo(
                        //     'Discount',
                        //     '\$${order.discountPrice.toStringAsFixed(2)}',
                        //     redColor,
                        //     redColor),

                      ],
                    )
                ),
              ],
            );
          }
          return const SizedBox();
        });
  }
  Widget _billInfo(String title, String price, Color color, Color color2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textStyle(color),
        ),
        Text(
          price,
          style: textStyle(color2),
        ),
      ],
    );
  }

  textStyle(Color color) {
    return GoogleFonts.roboto(
        fontWeight: FontWeight.w400, fontSize: 16.0, color: color);
  }
}