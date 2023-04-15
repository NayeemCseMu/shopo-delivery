import 'package:flutter/material.dart';
import 'package:shopo_delivery/modules/profile/profile_screen.dart';
import '../order/order_screen.dart';
import '/modules/dashboard/dashboard_screen.dart';

import 'component/bottom_navigation_bar.dart';
import 'component/main_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeController = MainController();
  late List<Widget> screenList;

  @override
  void initState() {
    super.initState();
    screenList = [
      const DashboardScreen(),
      const OrderScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<int>(
        initialData: 0,
        stream: _homeController.naveListener.stream,
        builder: (context, AsyncSnapshot<int> snapshot) {
          int item = snapshot.data ?? 0;
          return screenList[item];
        },
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
