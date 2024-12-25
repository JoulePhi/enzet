import 'package:enzet/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.colors,
    required this.title,
    required this.value,
  });
  final List<Color> colors;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(AppStyle.defaultRadius),
      child: Container(
        width: Get.width / 2 - 24,
        padding: const EdgeInsets.all(AppStyle.defaultPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppStyle.defaultRadius),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: colors,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: AppStyle.textLightGrey.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: AppStyle.textLightGrey.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
