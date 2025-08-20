import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/viewmodels/favorites_cubit.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/viewmodels/favorites_state.dart';

class AnimatedFavoriteButton extends StatefulWidget {
  final int doctorId;
  final bool initialFavoriteStatus;

  const AnimatedFavoriteButton({
    super.key,
    required this.doctorId,
    required this.initialFavoriteStatus,
  });

  @override
  AnimatedFavoriteButtonState createState() => AnimatedFavoriteButtonState();
}

class AnimatedFavoriteButtonState extends State<AnimatedFavoriteButton>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _rotationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.initialFavoriteStatus;

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.1).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, favState) {
        bool isLoading = favState is FavoritesLoading;

        if (favState is FavoritesAddSuccess) {
          isFavorite = true;
          _rotationController.forward().then((_) {
            _rotationController.reverse();
          });
        } else if (favState is FavoritesRemoveSuccess) {
          isFavorite = false;
          _rotationController.forward().then((_) {
            _rotationController.reverse();
          });
        }

        return AnimatedBuilder(
          animation: Listenable.merge([_scaleAnimation, _rotationAnimation]),
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Transform.rotate(
                angle: _rotationAnimation.value,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: isFavorite
                            ? Colors.red.withValues(alpha: 0.3)
                            : AppColors.kPrimaryColor1.withValues(alpha: 0.15),
                        blurRadius: isLoading ? 12 : 8,
                        offset: const Offset(0, 3),
                        spreadRadius: isLoading ? 2 : 1,
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: isLoading
                          ? Stack(
                              key: const ValueKey('loading'),
                              alignment: Alignment.center,
                              children: [
                                Opacity(
                                  opacity: 0.2,
                                  child: Icon(
                                    isFavorite
                                        ? Icons.favorite_border
                                        : Icons.favorite,
                                    color: !isFavorite
                                        ? Colors.red
                                        : AppColors.textSecondary,
                                    size: 22,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      !isFavorite
                                          ? Colors.red.withValues(alpha: 0.8)
                                          : AppColors.kPrimaryColor1,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              key: ValueKey('icon_$isFavorite'),
                              color: isFavorite
                                  ? Colors.red
                                  : AppColors.textSecondary,
                              size: 22,
                            ),
                    ),
                    onPressed: isLoading
                        ? null
                        : () async {
                            _scaleController.forward().then((_) {
                              _scaleController.reverse();
                            });

                            if (isFavorite) {
                              context
                                  .read<FavoritesCubit>()
                                  .removeDoctorFromFavorites(widget.doctorId);
                            } else {
                              context
                                  .read<FavoritesCubit>()
                                  .addDoctorToFavorites(widget.doctorId);
                            }
                          },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
