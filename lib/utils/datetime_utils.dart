import 'package:intl/intl.dart';

enum DateFormats {
  yyyyMMdd,
  yyyyMMddTHHmmssZ,
}

String _getKey(DateFormats key) {
  switch (key) {
    case DateFormats.yyyyMMdd:
      return 'yyyy-MM-dd';
    case DateFormats.yyyyMMddTHHmmssZ:
      return 'yyyy-MM-ddTHH:mm:ssZ';
    default:
      return '';
  }
}

String formatDate(String date, DateFormats currentDateFormat,
    DateFormats requiredDateFormat) {
  try {
    final DateFormat curFormatter = DateFormat(_getKey(currentDateFormat));
    final DateFormat reqFormatter = DateFormat(_getKey(requiredDateFormat));
    return reqFormatter.format(curFormatter.parse(date));
  } catch (err) {
    print(err);
  }
  return date;
}
