import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopo_delivery/modules/order/controller/cubit/cubit/complete_order_cubit.dart';
import 'package:shopo_delivery/modules/order/controller/cubit/cubit/running_order_cubit.dart';
import 'package:shopo_delivery/widgets/loading_widget.dart';
import 'package:shopo_delivery/widgets/primary_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../core/dummy_data/dummy_data.dart';
import '../../utils/utils.dart';
import '../../widgets/rounded_app_bar.dart';
import 'components/collapse_widget.dart';
import 'components/collapsed_body.dart';
import 'components/panel_component.dart';
import 'controller/cubit/cubit/order_details_cubit.dart';
import 'controller/cubit/cubit/update_cubit.dart';

class RequestOrderDetails extends StatelessWidget {
  RequestOrderDetails({Key? key, required this.orderId}) : super(key: key);
  final panelController = PanelController();
  final String orderId;

  @override
  Widget build(BuildContext context) {
    context.read<OrderDetailsCubit>().getOrderDetails(orderId);
    return Scaffold(
      appBar: RoundedAppBar(
        titleText: "Details",
      ),
      body: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
        builder: (context, state) {
          if (state is OrdeDetailsLoading) {
            return const Center(child: LoadingWidget());
          } else if (state is OrderDetailsStateLoaded) {
            return SlidingUpPanel(
              controller: panelController,
              minHeight: state.orders.orderRequest == "0" ? 80 :   state.orders.orderRequest == "1" ? 280.0 : 0,
              isDraggable:state.orders.orderRequest == "1" ? true : false,
              maxHeight:  50,
              backdropEnabled: false,
              backdropTapClosesPanel: false,
              parallaxEnabled: false,
              backdropOpacity: .0,
              collapsed: state.orders.orderRequest == "0"
                  ? CollapseWidget(id: state.orders.id.toString())
                  : state.orders.orderRequest == "1"
                      ? RunningUpdate(id: state.orders.id.toString())
                      : const BookingCollapse(),
              panelBuilder: (controller) => PanelComponent(
                scrollController: controller,
              ),
              body: const Body(),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class RunningUpdate extends StatefulWidget {
  const RunningUpdate({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<RunningUpdate> createState() => _RunningUpdateState();
}

class _RunningUpdateState extends State<RunningUpdate> {
  String paymentStatus = '';
  String orderStatus = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 24.0, top: 10.0),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(4),
            ),
            height: 4,
            width: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                child: Text(
                  "Payment",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                flex: 2,
                child: DropdownButtonFormField(
                    isExpanded: true,
                    decoration: const InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                        // borderSide: BorderSide(width: 1, color: CustomColors.lineColor),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                    hint: const Text("Select"),
                    items: paymentStatusList
                        .map((e) => DropdownMenuItem(
                            value: e['value'], child: Text(e['name']!)))
                        .toList(),
                    onChanged: (v) {
                      setState(() {
                        paymentStatus = v!;
                      });
                    }),
              )
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                child: Text(
                  "Order",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                flex: 2,
                child: DropdownButtonFormField(
                    isExpanded: true,
                    decoration: const InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                        // borderSide: BorderSide(width: 1, color: CustomColors.lineColor),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                    hint: const Text("Select"),
                    items: orderStatusList
                        .map((e) => DropdownMenuItem(
                            value: e['value'], child: Text(e['name']!)))
                        .toList(),
                    onChanged: (v) {
                      setState(() {
                        orderStatus = v!;
                      });
                    }),
              )
            ],
          ),
          const SizedBox(height: 16),
          BlocConsumer<UpdateCubit, UpdateState>(
            listener: (context, state) {
              if (state is UpdateOrderStateLoaded) {
                Utils.showSnackBar(context, state.message);
                context.read<RunningOrderCubit>().getRunningOrderList();
                context.read<CompleteOrderCubit>().getCompleteOrderList();
              }
            },
            builder: (context, state) {
              if (state is UpdateOrderLoading) {
                return const LoadingWidget();
              }
              return PrimaryButton(
                  text: "Update",
                  onPressed: () {
                    final map = <String, String>{
                      'payment_status': paymentStatus,
                      'order_status': orderStatus
                    };
                    print("$map");
                    context
                        .read<UpdateCubit>()
                        .updateRunningStatus(widget.id, map);
                  });
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class BookingCollapse extends StatelessWidget {
  const BookingCollapse({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const SizedBox(),
    );
  }
}

class UpdateRunning extends StatelessWidget {
  const UpdateRunning({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
