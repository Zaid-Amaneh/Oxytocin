import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/theme/app_colors.dart';

class SkeletonLoadingAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  final Color? backgroundColor;

  const SkeletonLoadingAppBar({super.key, this.backgroundColor});

  @override
  State<SkeletonLoadingAppBar> createState() => _SkeletonLoadingAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}

class _SkeletonLoadingAppBarState extends State<SkeletonLoadingAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _shimmerAnimation = Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.linear),
    );
    _shimmerController.repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.backgroundColor ?? Colors.white,
      elevation: 0,
      leading: _buildBackButton(context),
      title: _buildSkeletonTitle(),
      centerTitle: true,
      actions: [_buildSkeletonFavorite()],
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return IconButton(
      icon: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..scale(Helper.isArabic(context) ? -1.0 : 1.0, 1.0, 1),
        child: SvgPicture.asset(
          AppImages.backIcon,
          colorFilter: const ColorFilter.mode(
            AppColors.textPrimary,
            BlendMode.srcIn,
          ),
        ),
      ),
      onPressed: () => NavigationService().goBack(),
    );
  }

  Widget _buildSkeletonTitle() {
    return AnimatedBuilder(
      animation: _shimmerAnimation,
      builder: (context, child) {
        return Container(
          width: 120,
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [
                (_shimmerAnimation.value - 1).clamp(0.0, 1.0),
                _shimmerAnimation.value.clamp(0.0, 1.0),
                (_shimmerAnimation.value + 1).clamp(0.0, 1.0),
              ],
              colors: const [
                Color(0xFFEBEBF4),
                Color(0xFFF4F4F4),
                Color(0xFFEBEBF4),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSkeletonFavorite() {
    return AnimatedBuilder(
      animation: _shimmerAnimation,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.only(
            right: 16,
            top: 12,
            bottom: 12,
            left: 16,
          ),
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [
                (_shimmerAnimation.value - 1).clamp(0.0, 1.0),
                _shimmerAnimation.value.clamp(0.0, 1.0),
                (_shimmerAnimation.value + 1).clamp(0.0, 1.0),
              ],
              colors: const [
                Color(0xFFEBEBF4),
                Color(0xFFF4F4F4),
                Color(0xFFEBEBF4),
              ],
            ),
          ),
        );
      },
    );
  }
}
