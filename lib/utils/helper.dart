import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class Helper {
  static String formatReputation(int reputation) {
    if (reputation >= 1000000) {
      return '${(reputation / 1000000).toStringAsFixed(1)}M';
    } else if (reputation >= 1000) {
      return '${(reputation / 1000).toStringAsFixed(1)}K';
    }
    return reputation.toString();
  }

  static String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  static String timeAgoFromUnix(int timestamp, {String locale = 'en'}) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return timeago.format(date, locale: locale);
  }
}
