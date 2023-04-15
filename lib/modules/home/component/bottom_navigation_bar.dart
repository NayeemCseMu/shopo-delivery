import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import 'main_controller.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = MainController();
    return Container(
      height: Platform.isAndroid ? 80 : 100,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          )),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: StreamBuilder(
          initialData: 0,
          stream: controller.naveListener.stream,
          builder: (_, AsyncSnapshot<int> index) {
            int selectedIndex = index.data ?? 0;
            return BottomNavigationBar(
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedLabelStyle:
                  const TextStyle(fontSize: 14, color: greenColor),
              unselectedLabelStyle:
                  const TextStyle(fontSize: 14, color: blackColor),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  tooltip: "Home",
                  icon: SvgPicture.asset(Kimages.homeIcon),
                  activeIcon: SvgPicture.asset(Kimages.homeActive),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  tooltip: "Orders",
                  icon: SvgPicture.asset(Kimages.history),
                  activeIcon: SvgPicture.asset(Kimages.historyActive),
                  label: "Orders",
                ),
                BottomNavigationBarItem(
                  tooltip: "Profile",
                  icon: SvgPicture.asset(Kimages.profileIcon),
                  activeIcon: SvgPicture.asset(Kimages.profileActive),
                  label: "Profile",
                ),
                // BottomNavigationBarItem(
                //   tooltip: Language.wallet,
                //   activeIcon: SvgPicture.asset(Kimages.walletActive),
                //   icon: SvgPicture.asset(Kimages.wallet),
                //   label: Language.wallet,
                // ),
              ],
              // type: BottomNavigationBarType.fixed,
              currentIndex: selectedIndex,
              onTap: (int index) {
                controller.naveListener.sink.add(index);
              },
            );
          },
        ),
      ),
    );
  }
}
