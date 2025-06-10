import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';

class NameViewModel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  String? isAName;

  void setValidator(String value, BuildContext context) {
    String? temp;
    if (value.isEmpty) {
      temp = null;
    } else if (value.trim().length < 2) {
      temp = context.tr.Atleastletters;
    }
    isAName = temp;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
