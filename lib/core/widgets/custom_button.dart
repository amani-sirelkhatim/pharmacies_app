import 'package:flutter/material.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';


class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      this.onTap,
      this.width = 100,
      this.style,
      required this.bgcolor});
  final String text;
  final Function()? onTap;
  final double width;
  final TextStyle? style;
  final Color bgcolor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        width: width,
        decoration: BoxDecoration(
            color: bgcolor, borderRadius: BorderRadius.circular(15)),
        child: Text(
          text,
          style: style ?? getBodyStyle(color: AppColors.white),
        ),
      ),
    );
  }
}
