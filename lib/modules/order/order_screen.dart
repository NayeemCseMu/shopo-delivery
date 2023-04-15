import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:shopo_delivery/modules/order/components/complete_order_segment.dart';
import 'package:shopo_delivery/modules/order/components/order_request_segment.dart';
import 'package:shopo_delivery/modules/order/components/running_order_segment.dart';
import 'package:shopo_delivery/widgets/rounded_app_bar.dart';
import '../../utils/constants.dart';
import '../../widgets/toggle_button_scroll_component.dart';
import 'components/tab_data.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late List<Widget> screenList;
  int _currentIndex = 0;
  final _controller =
      PageController(initialPage: 0, viewportFraction: 1, keepPage: true);

  @override
  void initState() {
    super.initState();
    screenList = [
      const RequestOrder(),
      const RunningOrder(),
      const CompleteOrder(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
              .copyWith(top: 40),
          color: primaryColor,
          width: double.infinity,
          alignment: Alignment.center,
          child: const Text("Order",
          style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black),),
        ),
        ToggleButtonScrollComponent(
          textList: tab,
          initialLabelIndex: _currentIndex,
          onChange: (v) {
            _currentIndex = v;
            _controller.animateToPage(v,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);
            // if (mounted) setState(() {});
          },
        ),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  child: ExpandablePageView.builder(
                      controller: _controller,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: screenList.length,
                      itemBuilder: (c, i) {
                        return screenList[i];
                      }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
