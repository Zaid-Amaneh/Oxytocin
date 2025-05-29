import 'package:intl/intl.dart';

class Helper {
  bool isArabic() {
    return Intl.getCurrentLocale() == 'ar';
  }
}
