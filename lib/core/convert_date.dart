import 'package:intl/intl.dart';

class ConvertDate {

  //yyyy-MM-dd to dd MMM yyyy
  String convertToddMMMyyyy1(String date) {
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(date);
    var outputFormat = DateFormat('dd MMM yyyy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }

  //yyyy-MM-dd to MMMM yyyy
  String convertToMMMMyyyy(String date) {
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(date);
    var outputFormat = DateFormat('MMMM yyyy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }

  //dd-MMM-yyyy to dd MMM yyyy
  String convertToddMMMyyyy2(String date) {
    var inputFormat = DateFormat('dd-MMM-yyyy');
    var inputDate = inputFormat.parse(date);
    var outputFormat = DateFormat('dd MMM yyyy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }

  String isoFormatToReadable(String dateString) {
    try {
      DateTime dt = DateTime.parse(dateString);
      return DateFormat("dd MMM yyyy").format(dt);
    } catch (e) {
      return dateString; // fallback kalau parsing gagal
    }
  }

  String getDateToday({String format = 'yyyy-MM-dd'}) {
    final now = DateTime.now();

    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final year = now.year.toString();
    final month = twoDigits(now.month);
    final day = twoDigits(now.day);

    switch (format) {
      case 'yyyy-MM-dd':
        return '$year-$month-$day';
      case 'dd-MM-yyyy':
        return '$day-$month-$year';
      case 'dd/MM/yyyy':
        return '$day/$month/$year';
      default:
        return '$year-$month-$day';
    }
  }

  String formatToDayMonthYear(String? date) {
    if (date == null || date.isEmpty) return '-';

    try {
      final parsedDate =
      DateFormat('yyyy-MM-dd HH:mm:ss').parse(date);

      return DateFormat('dd MMM yyyy', 'en_US').format(parsedDate);
    } catch (e) {
      return '-';
    }
  }


}