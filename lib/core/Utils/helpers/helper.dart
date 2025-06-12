import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oxytocin/generated/l10n.dart';

class Helper {
  static bool isArabic() {
    return Intl.getCurrentLocale() == 'ar';
  }
}

extension LocalizationExt on BuildContext {
  S get tr => S.of(this);
}
