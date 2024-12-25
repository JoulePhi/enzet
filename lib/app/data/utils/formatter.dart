import 'package:intl/intl.dart';

abstract class Formatter {
  static String formatToRupiah(double amount) {
    final NumberFormat formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  static String convertCamelCaseToTitleCase(String camelCase) {
    final RegExp exp = RegExp(r'(?<=[a-z])(?=[A-Z])');
    final List<String> words = camelCase.split(exp);
    final String titleCase = words.map((word) {
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');

    return titleCase;
  }
}
