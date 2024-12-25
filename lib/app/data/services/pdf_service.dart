import 'dart:io';
import 'package:enzet/app/data/models/invoice_model.dart';
import 'package:enzet/app/data/utils/formatter.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfService {
  Future<void> generatePurchaseOrder({required Invoice invoice}) async {
    final pdf = pw.Document();

    final check = await imageFromAssetBundle('assets/images/check.png');
    final checkMini =
        await imageFromAssetBundle('assets/images/check_mini.png');

    for (var item in invoice.items) {
      final image = await networkImage(item.item.imageUrls.first);

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Purchase Order eNZet',
                      style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),

                // Supplier Info and Status
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.only(right: 15),
                        child: pw.Table(
                          children: [
                            _buildTableRow('Supplier', item.item.supplier),
                            _buildTableRow(
                                'Tanggal Masuk',
                                DateFormat('dd-MM-yyyy')
                                    .format(invoice.createdAt),
                                alternate: true),
                            _buildTableRow('Jenis Pesanan', item.item.name),
                            _buildTableRow('Artikel', item.item.article ?? "-",
                                alternate: true),
                            _buildTableRow('Material', item.item.material),
                            _buildTableRow('Warna', item.item.color,
                                alternate: true),
                            _buildTableRow(
                                'Printing', item.item.printing ?? '-'),
                            _buildTableRow('Jumlah', '${item.quantity} Pcs',
                                alternate: true),
                            _buildTableRow('Harga',
                                Formatter.formatToRupiah(item.item.price)),
                          ],
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          _buildStatusRow(invoice.status, checkMini),
                          pw.SizedBox(height: 20),
                          _buildBarcodeSection(item.item.code, invoice.code),
                          pw.SizedBox(height: 10),
                          _buildNotesSection(invoice.note),
                        ],
                      ),
                    ),
                  ],
                ),

                pw.SizedBox(height: 10),

                // Product Image
                pw.Container(
                  margin: const pw.EdgeInsets.symmetric(vertical: 20),
                  padding: const pw.EdgeInsets.symmetric(vertical: 20),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(),
                    borderRadius: pw.BorderRadius.circular(10),
                  ),
                  width: double.infinity,
                  height: 250,
                  child: pw.Image(image),
                  alignment: pw.Alignment.center,
                ),

                // Product Details Table
                _buildProductDetailsTable(invoice, check),

                pw.SizedBox(height: 10),

                // Notes
                pw.Container(
                  width: double.infinity,
                  padding: const pw.EdgeInsets.all(10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Keterangan:'),
                      pw.Text(invoice.message),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      );
    }

    // Print or save the PDF
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  pw.TableRow _buildTableRow(String label, String value,
      {bool alternate = false}) {
    return pw.TableRow(
      decoration:
          alternate ? const pw.BoxDecoration(color: PdfColors.grey200) : null,
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 5),
          child: pw.Text('$label: $value'),
        ),
      ],
    );
  }

  pw.Widget _buildStatusRow(InvoiceStatus status, pw.ImageProvider checkMini) {
    return pw.Row(
      children: [
        pw.Text('Status: '),
        _buildStatusIndicator(status == InvoiceStatus.newOrder, checkMini),
        pw.Text(' New Order '),
        _buildStatusIndicator(status == InvoiceStatus.repeatOrder, checkMini),
        pw.Text(' Repeat Order '),
        _buildStatusIndicator(status == InvoiceStatus.sample, checkMini),
        pw.Text(' Sample'),
      ],
    );
  }

  pw.Widget _buildStatusIndicator(bool isActive, pw.ImageProvider checkMini) {
    return pw.Container(
      width: 10,
      height: 10,
      decoration: pw.BoxDecoration(
        image: isActive
            ? pw.DecorationImage(image: checkMini, fit: pw.BoxFit.cover)
            : null,
        shape: pw.BoxShape.circle,
        border: !isActive ? pw.Border.all() : null,
      ),
    );
  }

  pw.Widget _buildBarcodeSection(String itemCode, String invoiceCode) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        _buildBarcodeContainer(itemCode, 'Kode Barang'),
        pw.SizedBox(width: 5),
        _buildBarcodeContainer(invoiceCode, 'Purchase Invoice'),
      ],
    );
  }

  pw.Widget _buildBarcodeContainer(String data, String label) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(),
        borderRadius: pw.BorderRadius.circular(10),
      ),
      child: pw.Column(
        children: [
          pw.Text(label),
          pw.BarcodeWidget(
            data: data,
            width: 100,
            height: 50,
            barcode: pw.Barcode.code128(),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildNotesSection(String note) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(),
        borderRadius: pw.BorderRadius.circular(10),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('Catatan:'),
          pw.Text(note),
        ],
      ),
    );
  }

  pw.Widget _buildProductDetailsTable(Invoice invoice, pw.ImageProvider check) {
    return pw.Table(
      border: pw.TableBorder.all(),
      children: [
        pw.TableRow(
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Penerima'),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Pengirim'),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('QC 1'),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('QC 2'),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('QC 3'),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(invoice.receiver),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(invoice.sender),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: invoice.qc1 ? pw.Image(check, width: 20) : pw.Container(),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: invoice.qc2 ? pw.Image(check, width: 20) : pw.Container(),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: invoice.qc3 ? pw.Image(check, width: 20) : pw.Container(),
            ),
          ],
        ),
      ],
    );
  }
}
