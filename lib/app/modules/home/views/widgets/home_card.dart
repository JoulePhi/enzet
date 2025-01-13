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
    // Calculate responsive width based on screen size and platform
    double cardWidth = _calculateCardWidth(context);
    double fontSize = _calculateFontSize(context);

    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(AppStyle.defaultRadius),
      child: Container(
        width: cardWidth,
        padding: EdgeInsets.all(_calculatePadding(context)),
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
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: AppStyle.textLightGrey.copyWith(
                fontSize: fontSize * 0.4, // Title is 40% of value font size
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateCardWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // For web platform
    if (GetPlatform.isWeb) {
      // Adjust width based on screen size
      if (screenWidth > 1200) {
        return (screenWidth - 300) / 4; // For large screens, 4 cards per row
      } else if (screenWidth > 800) {
        return (screenWidth - 250) / 3; // For medium screens, 3 cards per row
      } else if (screenWidth > 600) {
        return (screenWidth - 200) / 2; // For small screens, 2 cards per row
      }
      return screenWidth - 150; // For very small screens, 1 card per row
    }

    // For mobile platform, maintain original behavior
    return Get.width / 2 - 24;
  }

  double _calculateFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // For web platform
    if (GetPlatform.isWeb) {
      if (screenWidth > 1200) {
        return 36; // Larger font for big screens
      } else if (screenWidth > 800) {
        return 30; // Medium font for medium screens
      } else if (screenWidth > 600) {
        return 24; // Smaller font for small screens
      }
      return 20; // Smallest font for very small screens
    }

    // For mobile platform, maintain original size
    return 30;
  }

  double _calculatePadding(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // For web platform
    if (GetPlatform.isWeb) {
      if (screenWidth > 1200) {
        return AppStyle.defaultPadding * 1.5;
      } else if (screenWidth > 800) {
        return AppStyle.defaultPadding * 1.25;
      }
    }

    // Default padding for mobile and smaller web screens
    return AppStyle.defaultPadding;
  }
}
