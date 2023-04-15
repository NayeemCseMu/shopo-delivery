import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '/utils/constants.dart';
import '../../core/dummy_data/dummy_data.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/loading_widget.dart';
import 'components/balance_withdraw_card.dart';
import 'components/home_app_bar.dart';
import 'controller/dashboard_cubit.dart';
import 'model/dashboard_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardCubit>().getDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    // final dashboard = context.read<DashboardCubit>();
    return BlocBuilder<DashboardCubit, DashboardState>(builder: (c, state) {
      if (state is DashboardStateLoading) {
        return const LoadingWidget();
      } else if (state is DashboardStateError) {
        return Center(
          child: Text(state.message),
        );
      } else if (state is DashboardStateLoaded) {
        return DashboardLoadedWidget(dashboardModel: state.dashboardModel);
      }
      return const SizedBox();
    });
  }
}

class DashboardLoadedWidget extends StatelessWidget {
  const DashboardLoadedWidget({Key? key, required this.dashboardModel})
      : super(key: key);
  final DashboardModel dashboardModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeAppBar(),
        Expanded(
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 10.0)),
              SliverToBoxAdapter(
                child: BalanceAndWithdrawCard(dashboardModel: dashboardModel),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 10.0)),
              itemCount(),
              const SliverToBoxAdapter(child: SizedBox(height: 20.0)),
            ],
          ),
        ),
      ],
    );
  }

  Widget itemCount() {
    final List<int> count = [
      dashboardModel.totalOrderRequest,
      dashboardModel.todayAcceptOrders,
      dashboardModel.totalCompletedOrder,
      dashboardModel.totalDeclinedOrder,
      dashboardModel.thisMonthEarning,
      dashboardModel.totalEarning,
    ];
    return SliverToBoxAdapter(
      child: GridView.builder(
        itemCount: dummyData.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, index) {
          final data = dummyData[index];
          return Container(
            height: 50.0,
            width: 200.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(
                color: const Color.fromRGBO(0, 0, 0, 0.1),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImage(path: data.image),
                const SizedBox(height: 10.0),
                Text(
                  data.name,
                  style: GoogleFonts.inter(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                    color: textGreyColor,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(count[index].toString().padLeft(2, '0'),
                    style: GoogleFonts.inter(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      color: blackColor,
                    )),
              ],
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
      ),
    );
  }
}
