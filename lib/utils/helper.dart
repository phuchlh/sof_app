import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class Helper {
  static String formatReputation(int value) {
    final formatter = NumberFormat("#,##0", "en_US");
    return formatter.format(value);
  }

  static String timeAgoFromUnix(int timestamp, {String locale = 'en'}) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return timeago.format(date, locale: locale, allowFromNow: true);
  }
}
