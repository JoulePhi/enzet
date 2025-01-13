import 'package:enzet/app/modules/home/views/widgets/home_card.dart';
import 'package:enzet/theme/styles.dart';
import 'package:enzet/theme/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final String today = DateFormat('EEEE').format(DateTime.now());
    final String date = DateFormat('d MMMM').format(DateTime.now());
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: _calculateHorizontalPadding(context),
          vertical: AppStyle.mediumPadding,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      today,
                      style: AppStyle.textDarkGrey.copyWith(
                        fontSize: GetPlatform.isWeb ? 14 : 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      date,
                      style: AppStyle.textBlack.copyWith(
                        fontSize: GetPlatform.isWeb ? 20 : 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: GetPlatform.isWeb ? 48 : 40,
                  height: GetPlatform.isWeb ? 48 : 40,
                  decoration: const BoxDecoration(
                    color: AppStyle.lightGrey,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.search_rounded,
                    size: GetPlatform.isWeb ? 24 : 20,
                    color: AppStyle.lightBlack,
                  ),
                )
              ],
            ),
            verticalSpace(AppStyle.largePadding),
            _buildResponsiveCardGrid(context),
            verticalSpace(AppStyle.largePadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Top Products',
                  style: AppStyle.textBlack.copyWith(
                    fontSize: GetPlatform.isWeb ? 18 : 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: GetPlatform.isWeb ? 18 : 14,
                  color: AppStyle.black,
                ),
              ],
            ),
            verticalSpace(AppStyle.defaultPadding),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsiveCardGrid(BuildContext context) {
    if (!GetPlatform.isWeb) {
      // Original mobile layout
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HomeCard(
            colors: const [
              Color(0xffA9FFEA),
              Color(0xff00B288),
            ],
            title: 'Total Products',
            value: controller.totalItem.value.toString(),
          ),
          HomeCard(
            colors: const [
              Color(0xffFFA0BC),
              Color(0xffFF1B5E),
            ],
            title: 'Invoice Generated',
            value: controller.totalInvoice.value.toString(),
          ),
        ],
      );
    }

    // Web layout with responsive grid
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = _calculateCrossAxisCount(constraints.maxWidth);
        return Wrap(
          spacing: AppStyle.defaultPadding,
          runSpacing: AppStyle.defaultPadding,
          alignment: WrapAlignment.start,
          children: [
            HomeCard(
              colors: const [
                Color(0xffA9FFEA),
                Color(0xff00B288),
              ],
              title: 'Total Products',
              value: controller.totalItem.value.toString(),
            ),
            HomeCard(
              colors: const [
                Color(0xffFFA0BC),
                Color(0xffFF1B5E),
              ],
              title: 'Invoice Generated',
              value: controller.totalInvoice.value.toString(),
            ),
          ],
        );
      },
    );
  }

  double _calculateHorizontalPadding(BuildContext context) {
    if (!GetPlatform.isWeb) return AppStyle.defaultPadding;

    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 1200) {
      return AppStyle.defaultPadding * 2;
    } else if (screenWidth > 800) {
      return AppStyle.defaultPadding * 1.5;
    }
    return AppStyle.defaultPadding;
  }

  int _calculateCrossAxisCount(double width) {
    if (width > 1200) return 4;
    if (width > 800) return 3;
    if (width > 600) return 2;
    return 1;
  }
}
