import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/viewmodels/doctor_profile_cubit.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/viewmodels/doctor_profile_state.dart';

class DoctorAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool isFavorite;
  final VoidCallback? onBackPressed;
  final ValueChanged<bool>? onFavoriteToggle;
  final Color backgroundColor;
  final Color textColor;

  const DoctorAppBar({
    super.key,
    this.isFavorite = false,
    this.onBackPressed,
    this.onFavoriteToggle,
    this.backgroundColor = AppColors.kPrimaryColor1,
    this.textColor = Colors.black,
  });

  @override
  State<DoctorAppBar> createState() => _DoctorAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}

class _DoctorAppBarState extends State<DoctorAppBar>
    with SingleTickerProviderStateMixin {
  late bool _isFavorite;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    if (widget.onFavoriteToggle != null) {
      widget.onFavoriteToggle!(_isFavorite);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
      builder: (context, state) {
        if (state is DoctorProfileAllDataSuccess) {
          return AppBar(
            backgroundColor: widget.backgroundColor,
            leading: Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.kPrimaryColor1.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                    spreadRadius: 1,
                  ),
                  const BoxShadow(
                    color: Color(0x0F000000),
                    blurRadius: 4,
                    offset: Offset(0, 1),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: IconButton(
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
                onPressed:
                    widget.onBackPressed ?? () => NavigationService().goBack(),
              ),
            ),
            title: Text(
              state.doctorProfile.user.fullName,
              style: AppStyles.almaraiBold(context).copyWith(fontSize: 16),
            ),
            centerTitle: true,
            actions: [
              Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: _isFavorite
                          ? Colors.red.withValues(alpha: 0.2)
                          : AppColors.kPrimaryColor1.withValues(alpha: 0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                      spreadRadius: 1,
                    ),
                    const BoxShadow(
                      color: Color(0x0F000000),
                      blurRadius: 4,
                      offset: Offset(0, 1),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: IconButton(
                        icon: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Icon(
                            _isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            key: ValueKey(_isFavorite),
                            color: _isFavorite
                                ? Colors.red
                                : AppColors.textSecondary,
                            size: 22,
                          ),
                        ),
                        onPressed: _toggleFavorite,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return AppBar(
            backgroundColor: widget.backgroundColor,
            leading: Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.kPrimaryColor1.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                    spreadRadius: 1,
                  ),
                  const BoxShadow(
                    color: Color(0x0F000000),
                    blurRadius: 4,
                    offset: Offset(0, 1),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: IconButton(
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
                onPressed:
                    widget.onBackPressed ?? () => NavigationService().goBack(),
              ),
            ),
            title: const CircularProgressIndicator(),
            centerTitle: true,
            actions: [const CircularProgressIndicator(color: Colors.red)],
          );
        }
      },
    );
  }
}
