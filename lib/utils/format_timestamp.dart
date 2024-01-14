import 'package:intl/intl.dart';

String formatTimestamp(int timestamp) {
  // Convert timestamp (in seconds) to DateTime
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

  // Format the DateTime using the desired format
  String formattedDate = DateFormat('yyyy-MM-dd, HH:mm').format(dateTime);

  return formattedDate;
}
