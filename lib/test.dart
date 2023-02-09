import 'package:intl/intl.dart';

void main() {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy/MM/dd – kk:mm').format(now);
  print(formattedDate);
}
