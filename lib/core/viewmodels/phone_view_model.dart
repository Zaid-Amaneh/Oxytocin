import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oxytocin/generated/l10n.dart';

class PhoneViewModel extends ChangeNotifier {
  final TextEditingController phoneController = TextEditingController();
  String? errorText;

  final RegExp _syrianPhoneRegExp = RegExp(r'^09\d{8}$');
  final RegExp _digitValidator = RegExp(r'[0-9]');

  void validatePhone(String value, BuildContext context) {
    String? temp;
    if (value.isEmpty) {
      temp = null;
    } else if (!_syrianPhoneRegExp.hasMatch(value)) {
      temp = S.of(context).PleaseEnterValidNumber;
    }
    errorText = temp;
    notifyListeners();
  }

  List<TextInputFormatter> get inputFormatters => [
    FilteringTextInputFormatter.allow(_digitValidator),
    LengthLimitingTextInputFormatter(10),
  ];

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}
