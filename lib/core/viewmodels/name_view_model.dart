import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';

class NameViewModel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  String? isAName;

  void setValidator(BuildContext context) {
    String? temp;
    if (nameController.text.isEmpty) {
      temp = null;
    } else if (nameController.text.trim().length < 2) {
      temp = context.tr.atleastletters;
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
