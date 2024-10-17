import 'dart:developer';
import 'package:easy_date_formatter/date_formatter.dart';

String formateDate( String date ) {
  log(date);

  return DateFormatter.formatDateTime(
    dateTime: DateTime.parse(date),
    outputFormat: 'dd/MM/yyyy',
  );
}