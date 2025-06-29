import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/constants/app_constants.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:oxytocin/core/viewmodels/password_view_model.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/generated/l10n.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    this.nameController,
    this.lastNameController,
    this.phoneController,
  });
  final TextEditingController? nameController,
      lastNameController,
      phoneController;
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PasswordViewModel>();
    vm.updateUserData(
      uname: nameController?.text ?? '',
      lname: lastNameController?.text ?? '',
      phone: phoneController?.text ?? '',
    );
    return Padding(
      padding: AppConstants.textFieldPadding,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          color: AppColors.background,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: AppColors.textfieldBorder),
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
          controller: vm.passwordController,
          focusNode: vm.focusNode,
          obscureText: vm.obscureText,
          onChanged: (value) => vm.validatePassword(context),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return context.tr.Thisfieldisrequired;
            } else {
              vm.validatePassword(context);
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: S.of(context).Password,
            errorText: vm.errorText,
            hintStyle: AppStyles.almaraiBold(context).copyWith(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
            errorStyle: AppStyles.almaraiRegular(
              context,
            ).copyWith(color: AppColors.error),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(16.0),
              child: vm.isFocused
                  ? GestureDetector(
                      onTap: vm.toggleObscure,
                      child: vm.obscureText
                          ? SvgPicture.asset(Assets.imagesHidePassword)
                          : SvgPicture.asset(Assets.imagesShowPassword),
                    )
                  : SvgPicture.asset(Assets.imagesPasswordIcon),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:oxytocin/core/Utils/app_images.dart';
// import 'package:oxytocin/core/Utils/app_styles.dart';
// import 'package:oxytocin/core/Utils/helpers/helper.dart';
// import 'package:oxytocin/core/theme/app_colors.dart';
// import 'package:oxytocin/generated/l10n.dart';

// class PasswordField extends StatefulWidget {
//   const PasswordField({
//     super.key,
//     this.nameController,
//     this.lastNameController,
//     this.phoneController,
//     this.controller,
//   });
//   final TextEditingController? controller,
//       nameController,
//       lastNameController,
//       phoneController;
//   @override
//   State<PasswordField> createState() => _PasswordFieldState();
// }

// class _PasswordFieldState extends State<PasswordField> {
//   final FocusNode focusNode = FocusNode();
//   String? errorText;
//   bool isFocused = false;
//   bool obscureText = false;
//   static final _specialChars = r'!@#$%^&*()_\-+';
//   @override
//   void initState() {
//     super.initState();
//     focusNode.addListener(() {
//       setState(() {
//         isFocused = focusNode.hasFocus;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     focusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: DecoratedBox(
//         decoration: ShapeDecoration(
//           color: Colors.white,
//           shape: RoundedRectangleBorder(
//             side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
//             borderRadius: BorderRadius.circular(25),
//           ),
//           shadows: const [
//             BoxShadow(
//               color: Color(0x3F000000),
//               blurRadius: 4,
//               offset: Offset(0, 4),
//               spreadRadius: 0,
//             ),
//           ],
//         ),
//         child: TextFormField(
//           obscureText: obscureText,
//           focusNode: focusNode,
//           controller: widget.controller,
//           onChanged: (value) {
//             setValidator(value);
//           },
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return context.tr.Thisfieldisrequired;
//             } else {
//               setValidator(value);
//               return errorText;
//             }
//           },
//           onTap: () {},
//           decoration: InputDecoration(
//             suffixIcon: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: isFocused
//                   ? GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           obscureText = !obscureText;
//                         });
//                       },
//                       child: obscureText
//                           ? SvgPicture.asset(Assets.imagesHidePassword)
//                           : SvgPicture.asset(Assets.imagesShowPassword),
//                     )
//                   : SvgPicture.asset(Assets.imagesPasswordIcon),
//             ),
//             errorText: errorText,
//             hintText: S.of(context).Password,
//             hintStyle: AppStyles.almaraiBold(context).copyWith(
//               color: Colors.black,
//               fontSize: 18,
//               fontWeight: FontWeight.w900,
//             ),
//             errorStyle: AppStyles.almaraiRegular(
//               context,
//             ).copyWith(color: AppColors.error),
//           ),
//         ),
//       ),
//     );
//   }

//   void setValidator(String valid) {
//     String? temp;
//     final lowerPassword = valid.toLowerCase();
//     final String username =
//         widget.nameController?.text.trim().toLowerCase() ?? "";
//     final String lastname =
//         widget.lastNameController?.text ?? "".trim().toLowerCase();
//     final String phone = widget.phoneController?.text.trim() ?? "";

//     if (valid.isEmpty) {
//       temp = null;
//     } else if (valid.length < 8) {
//       temp = context.tr.Passwordatleast8characterslong;
//     } else if (!RegExp(r'[a-z]').hasMatch(valid)) {
//       temp = context.tr.Passwordincludeleastonelowercaseletter;
//     } else if (!RegExp(r'[A-Z]').hasMatch(valid)) {
//       temp = context.tr.Passwordincludeleastoneuppercaseletter;
//     } else if (!RegExp(r'[0-9]').hasMatch(valid)) {
//       temp = context.tr.Passwordmustincludeatleastonenumber;
//     } else if (!RegExp('[$_specialChars]').hasMatch(valid)) {
//       temp = context.tr.Passwordmustleastonespecialcharacter;
//     } else if ((username.isNotEmpty && lowerPassword.contains(username)) ||
//         (lastname.isNotEmpty && lowerPassword.contains(lastname)) ||
//         (phone.isNotEmpty && lowerPassword.contains(phone))) {
//       temp = context.tr.passwordmustnotcontainyourorphonenumber;
//     }

//     setState(() {
//       errorText = temp;
//     });
//   }
// }
