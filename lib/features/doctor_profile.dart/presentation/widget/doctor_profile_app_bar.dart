import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/theme/app_colors.dart';

class DoctorAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String doctorName;
  final bool isFavorite;
  final VoidCallback? onBackPressed;
  final ValueChanged<bool>? onFavoriteToggle;
  final Color backgroundColor;
  final Color textColor;

  const DoctorAppBar({
    super.key,
    required this.doctorName,
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
          onPressed: widget.onBackPressed ?? () => NavigationService().goBack(),
        ),
      ),
      title: Text(
        '${context.tr.profile} ${widget.doctorName}',
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
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      key: ValueKey(_isFavorite),
                      color: _isFavorite ? Colors.red : AppColors.textSecondary,
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
  }
}

class EnhancedIconButton extends StatefulWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final Color shadowColor;
  final double size;

  const EnhancedIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.shadowColor = AppColors.kPrimaryColor1,
    this.size = 48,
  });

  @override
  State<EnhancedIconButton> createState() => _EnhancedIconButtonState();
}

class _EnhancedIconButtonState extends State<EnhancedIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pressAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _pressAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _controller.reverse();
    widget.onPressed?.call();
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _pressAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _pressAnimation.value,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: widget.shadowColor.withValues(
                      alpha: _isPressed ? 0.25 : 0.15,
                    ),
                    blurRadius: _isPressed ? 12 : 8,
                    offset: Offset(0, _isPressed ? 4 : 3),
                    spreadRadius: _isPressed ? 2 : 1,
                  ),
                  BoxShadow(
                    color: const Color(0x0F000000),
                    blurRadius: _isPressed ? 6 : 4,
                    offset: Offset(0, _isPressed ? 2 : 1),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Center(child: widget.icon),
            ),
          );
        },
      ),
    );
  }
}
