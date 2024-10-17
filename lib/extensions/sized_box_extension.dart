import 'package:flutter/widgets.dart';

extension HeightSizedBox on num {
  SizedBox get h => SizedBox(
        height: toDouble(),
      );
}

extension WidthSizedBox on num {
  SizedBox get w => SizedBox(
        width: toDouble(),
      );
}
