import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopo_delivery/modules/order/controller/cubit/cubit/update_cubit.dart';
import 'package:shopo_delivery/modules/order/controller/cubit/order_request_cubit.dart';
import '../../../utils/constants.dart';

import '../../../utils/utils.dart';
import '../../../widgets/primary_button.dart';
import '../controller/cubit/cubit/order_details_cubit.dart';

class CollapseWidget extends StatelessWidget {
  const CollapseWidget({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateCubit, UpdateState>(
      listener: (context, state){
        if (state is UpdateOrderLoading) {
          Utils.loadingDialog(context);
        } else if (state is UpdateOrderStateError) {
          Utils.errorSnackBar(context, state.message);
        }
        else if (state is UpdateOrderStateLoaded) {
          Utils.showSnackBar(context, state.message);
          context.read<OrderRequestCubit>().getRequestOrderList();
          Navigator.pop(context);
          Navigator.pop(context);
        }
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: PrimaryButton(
                    text: 'Ignore',
                    onPressed: () {
                      final map = <String, String>{'order_request_status': '2'};
                      context
                          .read<UpdateCubit>()
                          .updateRequestStatus(id, map);
                    },
                    fontSize: 16.0,
                    borderRadiusSize: 4.0,
                    bgColor: redColor,
                    textColor: Colors.white,
                    minimumSize: const Size(160.0, 45.0),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: PrimaryButton(
                    text: 'Accept',
                    onPressed: () {
                      final map = <String, String>{'order_request_status': '1'};
                      context
                          .read<UpdateCubit>()
                          .updateRequestStatus(id, map);
                    },
                    bgColor: greenColor,
                    fontSize: 16.0,
                    textColor: Colors.white,
                    borderRadiusSize: 4.0,
                    minimumSize: const Size(160.0, 45.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
