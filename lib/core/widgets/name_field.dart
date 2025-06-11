import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/constants/app_constants.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/viewmodels/name_view_model.dart';
import 'package:provider/provider.dart';

class NameField extends StatefulWidget {
  const NameField({super.key, required this.fieldName});
  final String fieldName;
  @override
  State<NameField> createState() => _NameFieldState();
}

class _NameFieldState extends State<NameField> {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<NameViewModel>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DecoratedBox(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: AppColors.textfieldBorder),
            borderRadius: BorderRadius.circular(
              AppConstants.borderRadiusCircular,
            ),
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
          controller: vm.nameController,
          maxLength: 10,
          keyboardType: TextInputType.name,
          onChanged: (value) => vm.setValidator(context),
          validator: (value) {
            if (value!.trim().isEmpty) {
              return context.tr.Thisfieldisrequired;
            } else {
              vm.setValidator(context);
            }
            return null;
          },
          decoration: InputDecoration(
            counterText: '',
            suffixIcon: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(Assets.imagesUserNameIcon),
            ),
            errorText: vm.isAName,
            hintText: widget.fieldName,
            hintStyle: AppStyles.almaraiBold(context).copyWith(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
            errorStyle: AppStyles.almaraiRegular(
              context,
            ).copyWith(color: AppColors.error),
          ),
        ),
      ),
    );
  }
}
