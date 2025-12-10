import 'package:intl/intl.dart';

class ConvertDate {

  //yyyy-MM-dd to dd MMM yyyy
  convertToddMMMyyyy1(String date) {
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(date);
    var outputFormat = DateFormat('dd MMM yyyy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }

  //yyyy-MM-dd to MMMM yyyy
  convertToMMMMyyyy(String date) {
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(date);
    var outputFormat = DateFormat('MMMM yyyy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }

  //dd-MMM-yyyy to dd MMM yyyy
  convertToddMMMyyyy2(String date) {
    var inputFormat = DateFormat('dd-MMM-yyyy');
    var inputDate = inputFormat.parse(date);
    var outputFormat = DateFormat('dd MMM yyyy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }

  isoFormatToReadable(String dateString) {
    try {
      DateTime dt = DateTime.parse(dateString);
      return DateFormat("dd MMM yyyy").format(dt);
    } catch (e) {
      return dateString; // fallback kalau parsing gagal
    }
  }

}