import 'package:flutter/material.dart';

extension WidgetSpacing on int {
  SizedBox get horizontalSpace => SizedBox(
        width: toDouble(),
      );
  SizedBox get verticalSpace => SizedBox(
        height: toDouble(),
      );
}
