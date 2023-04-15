import 'package:flutter/material.dart';

import '../utils/constants.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    this.maximumSize = const Size(double.infinity, 52),
    required this.text,
    this.bgColor = primaryColor,
    this.textColor = buttonTextColor,
    this.fontSize = 16,
    required this.onPressed,
    this.minimumSize = const Size(double.infinity, 52),
    this.borderRadiusSize = 0,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Color bgColor;
  final Color textColor;
  final String text;
  final Size maximumSize;
  final Size minimumSize;
  final double fontSize;
  final double borderRadiusSize;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(borderRadiusSize);
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          backgroundColor: Colors.transparent,
          minimumSize: minimumSize,
          maximumSize: maximumSize,
          shadowColor: Colors.transparent,
        ),
        child: Text(
          text,
          style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              height: 1.5,
          
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
