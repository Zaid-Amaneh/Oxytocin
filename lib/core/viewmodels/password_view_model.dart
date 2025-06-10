import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';

class PasswordViewModel extends ChangeNotifier {
  final TextEditingController passwordController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  String? errorText;
  bool obscureText = true;
  bool isFocused = false;

  String username = '';
  String lastName = '';
  String phoneNumber = '';

  final _specialChars = r'!@#$%^&*()_\-+';

  PasswordViewModel() {
    focusNode.addListener(() {
      isFocused = focusNode.hasFocus;
      notifyListeners();
    });
  }

  void toggleObscure() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void updateUserData({
    required String uname,
    required String lname,
    required String phone,
  }) {
    username = uname.toLowerCase().trim();
    lastName = lname.toLowerCase().trim();
    phoneNumber = phone.trim();
  }

  void validatePassword(String password, BuildContext context) {
    final lowerPassword = password.toLowerCase();
    String? temp;
    if (password.isEmpty) {
      temp = null;
    } else if (password.length < 8) {
      temp = context.tr.passwordmustnotcontainyourorphonenumber;
    } else if (!RegExp(r'[a-z]').hasMatch(password)) {
      temp = context.tr.Passwordincludeleastonelowercaseletter;
    } else if (!RegExp(r'[A-Z]').hasMatch(password)) {
      temp = context.tr.Passwordincludeleastoneuppercaseletter;
    } else if (!RegExp(r'[0-9]').hasMatch(password)) {
      temp = context.tr.Passwordmustincludeatleastonenumber;
    } else if (!RegExp('[$_specialChars]').hasMatch(password)) {
      temp = context.tr.Passwordmustleastonespecialcharacter;
    } else if ((username.isNotEmpty && lowerPassword.contains(username)) ||
        (lastName.isNotEmpty && lowerPassword.contains(lastName)) ||
        (phoneNumber.isNotEmpty && lowerPassword.contains(phoneNumber))) {
      temp = context.tr.passwordmustnotcontainyourorphonenumber;
    }

    errorText = temp;
    notifyListeners();
  }

  @override
  void dispose() {
    passwordController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
