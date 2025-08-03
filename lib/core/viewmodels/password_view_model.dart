import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';

class PasswordViewModel extends ChangeNotifier {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final FocusNode focusNode = FocusNode();

  String? errorText, confirmErrorText;
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

  void validatePassword(BuildContext context) {
    final lowerPassword = passwordController.text.toLowerCase();
    String? temp;
    if (passwordController.text.isEmpty) {
      temp = null;
    } else if (passwordController.text.length < 8) {    
      temp = context.tr.passwordatleast8characterslong;
    } else if (!RegExp(r'[a-z]').hasMatch(passwordController.text)) {
      temp = context.tr.passwordincludeleastonelowercaseletter;
    } else if (!RegExp(r'[A-Z]').hasMatch(passwordController.text)) {
      temp = context.tr.passwordincludeleastoneuppercaseletter;
    } else if (!RegExp(r'[0-9]').hasMatch(passwordController.text)) {
      temp = context.tr.passwordmustincludeatleastonenumber;
    } else if (!RegExp('[$_specialChars]').hasMatch(passwordController.text)) {
      temp = context.tr.passwordmustleastonespecialcharacter;
    } else if ((username.isNotEmpty && lowerPassword.contains(username)) ||
        (lastName.isNotEmpty && lowerPassword.contains(lastName)) ||
        (phoneNumber.isNotEmpty && lowerPassword.contains(phoneNumber))) {
      temp = context.tr.passwordmustnotcontainyourorphonenumber;
    }

    errorText = temp;
    notifyListeners();
  }

  void validateConfirmPassword(String paasword, BuildContext context) {
    String? temp;
    if (confirmPasswordController.text.isEmpty) {
      temp = null;
    } else if (paasword.trim() != confirmPasswordController.text.trim()) {
      temp = context.tr.thepasswordsdonotmatch;
    } else {  
      temp = null;
    }
    confirmErrorText = temp;
    notifyListeners();
  }

  @override
  void dispose() {
    passwordController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
