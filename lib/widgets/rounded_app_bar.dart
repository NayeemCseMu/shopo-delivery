import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'app_bar_leading.dart';

class RoundedAppBar extends AppBar {
  final String? titleText;

  final Color bgColor;
  final Color textColor;
  final void Function()? onTap;

  RoundedAppBar({
    this.titleText,
    this.textColor = Colors.black,
    this.bgColor = lightningYellowColor,
    this.onTap,
    Key? key,
  }) : super(
          key: key,
          titleSpacing: 5,
          backgroundColor: bgColor,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(28))),
          leading: const AppbarLeading(),
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
              color: textColor, fontSize: 18, fontWeight: FontWeight.w600),
          title: titleText != null ? Text(titleText) : null,
          elevation: 0.0,
          centerTitle: false,
          automaticallyImplyLeading: false,
        );
}
