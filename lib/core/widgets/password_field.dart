import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/generated/l10n.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  final TextEditingController textController = TextEditingController();
  String? errorText;
  final FocusNode focusNode = FocusNode();
  bool isFocused = false;
  static final _specialChars = r'!@#$%^&*()_\-+';
  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {
        isFocused = focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DecoratedBox(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
            borderRadius: BorderRadius.circular(25),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: TextFormField(
          focusNode: focusNode,
          controller: textController,
          onChanged: (value) {
            setValidator(value);
          },
          decoration: InputDecoration(
            suffixIcon: Padding(
              padding: const EdgeInsets.all(16.0),
              child: isFocused
                  ? SvgPicture.asset(Assets.imagesShowPassword)
                  : SvgPicture.asset(Assets.imagesPasswordIcon),
            ),
            errorText: errorText,
            hintText: S.of(context).Password,
            hintStyle: AppStyles.almaraiBold(context).copyWith(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }

  void setValidator(String valid) {
    String? temp;
    if (valid.isEmpty) {
      temp = context.tr.Passwordisrequired;
    } else if (valid.length < 8) {
      temp = context.tr.Passwordatleast8characterslong;
    } else if (!RegExp(r'[a-z]').hasMatch(valid)) {
      temp = context.tr.Passwordincludeleastonelowercaseletter;
    } else if (!RegExp(r'[A-Z]').hasMatch(valid)) {
      temp = context.tr.Passwordincludeleastoneuppercaseletter;
    } else if (!RegExp(r'[0-9]').hasMatch(valid)) {
      temp = context.tr.Passwordmustincludeatleastonenumber;
    } else if (!RegExp('[$_specialChars]').hasMatch(valid)) {
      temp = context.tr.Passwordmustleastonespecialcharacter;
    }
    setState(() {
      errorText = temp;
    });
  }
}
