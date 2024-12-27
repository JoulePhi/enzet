import 'package:enzet/app/data/models/invoice_model.dart';
import 'package:enzet/app/data/utils/formatter.dart';
import 'package:enzet/app/modules/history/controllers/history_controller.dart';
import 'package:enzet/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class InvoiceCard extends StatelessWidget {
  const InvoiceCard({
    super.key,
    required this.invoice,
  });
  final Invoice invoice;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Get.toNamed(Routes.DETAIL, arguments: item);
        Get.find<HistoryController>().generatePdf(invoice);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Container(
            //   width: 50,
            //   height: 50,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(8),
            //     child: Stack(
            //       fit: StackFit.expand,
            //       children: [
            //         CachedNetworkImage(
            //           imageUrl: item.imageUrls.first,
            //           fit: BoxFit.cover,
            //           placeholder: (context, url) => const Center(
            //             child: CircularProgressIndicator(),
            //           ),
            //           errorWidget: (context, url, error) => Image.asset(
            //             'assets/images/placeholder.png',
            //             fit: BoxFit.cover,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  invoice.code,
                  style: AppStyle.textBlack.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat('d MMMM yyyy').format(invoice.createdAt),
                  style: AppStyle.textGrey.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              Formatter.formatToRupiah(invoice.total),
              style: AppStyle.textLightBlack.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
