import 'package:intl/intl.dart';
import 'package:shamsi_date/shamsi_date.dart';

class DateTimeUtils {
  // Date time Format
  static const dateFormatddMMyyyy = 'dd-MM-yyyy';

  static String dateToString(DateTime dateTime) {
    return DateFormat(dateFormatddMMyyyy).format(dateTime);
  }

  static String convertToJalali(String dateTimeString) {
  // Parse the string to a DateTime object
  DateTime dateTime = DateTime.parse(dateTimeString);

  // Convert to Jalali DateTime
  Jalali jalaliDateTime = Jalali.fromDateTime(dateTime);

  // Format the Jalali date as "YYYY/MM/DD"
  return "${jalaliDateTime.year}/${jalaliDateTime.month.toString().padLeft(2, '0')}/${jalaliDateTime.day.toString().padLeft(2, '0')}";
}
}
