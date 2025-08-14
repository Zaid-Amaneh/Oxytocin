import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/viewmodels/search_view_model.dart';
import 'package:provider/provider.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    this.onSubmitted,
    this.onDebouncedSearch,
    this.onTyping,
  });
  final void Function(String)? onSubmitted;
  final void Function(String)? onDebouncedSearch;
  final void Function(String)? onTyping;
  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SearchViewModel>();
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFA6A6A6)),
          borderRadius: BorderRadius.circular(50),
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
      child: TextField(
        controller: vm.searchController,
        keyboardType: TextInputType.text,
        onChanged: (value) {
          vm.onSearchChanged(
            onDebounce: widget.onDebouncedSearch ?? (_) {},
            onTyping: widget.onTyping,
          );
        },
        onSubmitted: widget.onSubmitted,
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: '',
          suffixIcon: vm.isFieldEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SvgPicture.asset(AppImages.search),
                )
              : IconButton(
                  icon: const Icon(Icons.clear, color: AppColors.textPrimary),
                  onPressed: vm.clearSearch,
                ),
          hintText: context.tr.findRightDoctor,
          hintStyle: AppStyles.almaraiBold(
            context,
          ).copyWith(fontSize: 14, color: AppColors.textPrimary),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
        ),
      ),
    );
  }
}
