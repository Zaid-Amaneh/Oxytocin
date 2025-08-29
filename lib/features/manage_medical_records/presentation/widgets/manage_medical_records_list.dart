import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/widgets/un_expected_error.dart';
import 'package:oxytocin/features/manage_medical_records/data/models/specialty_access_model.dart';
import 'package:oxytocin/features/manage_medical_records/presentation/viewmodels/specialty_access_cubit.dart';
import 'package:oxytocin/features/manage_medical_records/presentation/viewmodels/specialty_access_state.dart';

class ManageMedicalRecordsList extends StatelessWidget {
  const ManageMedicalRecordsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpecialtyAccessCubit, SpecialtyAccessState>(
      builder: (context, state) {
        if (state is SpecialtyAccessLoading ||
            state is SpecialtyAccessInitial) {
          return const _ShimmerLoadingGrid();
        }

        if (state is SpecialtyAccessError) {
          return const SliverToBoxAdapter(child: UnExpectedError());
        }

        if (state is SpecialtyAccessLoaded) {
          final list = state.specialties;
          final updatingId = state is SpecialtyAccessUpdating
              ? state.updatingId
              : null;

          if (list.isEmpty) {
            return const SliverToBoxAdapter(
              child: Center(child: Text("لا توجد اختصاصات.")),
            );
          }

          return SliverGrid.builder(
            itemCount: list.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (context, index) {
              final item = list[index];
              final bool isUpdating = item.id == updatingId;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ModernSpecialtyGridItem(
                  item: item,
                  isUpdating: isUpdating,
                ),
              );
            },
          );
        }

        return const SliverToBoxAdapter(child: UnExpectedError());
      },
    );
  }
}

class ModernSpecialtyGridItem extends StatelessWidget {
  const ModernSpecialtyGridItem({
    super.key,
    required this.item,
    required this.isUpdating,
  });

  final SpecialtyAccess item;
  final bool isUpdating;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final name = Helper.isArabic(context)
        ? item.specialty.nameAr
        : item.specialty.nameEn;
    final bool isRestricted = item.visibility == "restricted";

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isRestricted
              ? [
                  const Color(
                    0xFFFF6B6B,
                  ).withAlpha(26), // Replaced withOpacity(0.1)
                  const Color(
                    0xFFFF8E53,
                  ).withAlpha(13), // Replaced withOpacity(0.05)
                ]
              : [
                  const Color(
                    0xFF4ECDC4,
                  ).withAlpha(26), // Replaced withOpacity(0.1)
                  const Color(
                    0xFF44A08D,
                  ).withAlpha(13), // Replaced withOpacity(0.05)
                ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isRestricted
              ? const Color(0xFFFF6B6B).withAlpha(
                  51,
                ) // Replaced withOpacity(0.2)
              : const Color(
                  0xFF4ECDC4,
                ).withAlpha(51), // Replaced withOpacity(0.2)
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isRestricted
                ? const Color(0xFFFF6B6B).withAlpha(
                    26,
                  ) // Replaced withOpacity(0.1)
                : const Color(
                    0xFF4ECDC4,
                  ).withAlpha(26), // Replaced withOpacity(0.1)
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withAlpha(13), // Replaced withOpacity(0.05)
            blurRadius: 10,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(230), // Replaced withOpacity(0.9)
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: width * 0.2,
                  height: width * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.kPrimaryColor1,
                        AppColors.kPrimaryColor2,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(
                          26,
                        ), // Replaced withOpacity(0.1)
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: NetworkImageWithState(
                        url: item.specialty.image ?? "",
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),

                Text(
                  name,
                  style: AppStyles.almaraiBold(context).copyWith(
                    color: const Color(0xFF2C3E50),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isRestricted
                        ? const Color(0xFFFF6B6B).withAlpha(
                            26,
                          ) // Replaced withOpacity(0.1)
                        : const Color(
                            0xFF4ECDC4,
                          ).withAlpha(26), // Replaced withOpacity(0.1)
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isRestricted
                          ? const Color(0xFFFF6B6B).withAlpha(
                              77,
                            ) // Replaced withOpacity(0.3)
                          : const Color(
                              0xFF4ECDC4,
                            ).withAlpha(77), // Replaced withOpacity(0.3)
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isRestricted
                                  ? const Color(0xFFFF6B6B)
                                  : const Color(0xFF4ECDC4),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isRestricted
                                ? context.tr.restricted
                                : context.tr.public,
                            style: AppStyles.almaraiRegular(context).copyWith(
                              color: isRestricted
                                  ? const Color(0xFFFF6B6B)
                                  : const Color(0xFF4ECDC4),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 12),

                      if (isUpdating)
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              isRestricted
                                  ? const Color(0xFFFF6B6B)
                                  : const Color(0xFF4ECDC4),
                            ),
                          ),
                        )
                      else
                        GestureDetector(
                          onTap: () {
                            final newVisibility = isRestricted
                                ? "public"
                                : "restricted";
                            context
                                .read<SpecialtyAccessCubit>()
                                .updateSpecialtyVisibility(
                                  specialtyAccessId: item.id,
                                  newVisibility: newVisibility,
                                );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: 50,
                            height: 26,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                colors: isRestricted
                                    ? [
                                        const Color(0xFFFF6B6B),
                                        const Color(0xFFFF8E53),
                                      ]
                                    : [
                                        const Color(0xFF4ECDC4),
                                        const Color(0xFF44A08D),
                                      ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      (isRestricted
                                              ? const Color(0xFFFF6B6B)
                                              : const Color(0xFF4ECDC4))
                                          .withAlpha(
                                            77,
                                          ), // Replaced withOpacity(0.3)
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: AnimatedAlign(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              alignment: isRestricted
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                width: 22,
                                height: 22,
                                margin: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  isRestricted
                                      ? Icons.lock_rounded
                                      : Icons.public_rounded,
                                  size: 14,
                                  color: isRestricted
                                      ? const Color(0xFFFF6B6B)
                                      : const Color(0xFF4ECDC4),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ShimmerLoadingGrid extends StatelessWidget {
  const _ShimmerLoadingGrid();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.85,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) =>
              Helper.buildShimmerBox(width: width * 0.4, height: width * 0.4),
          childCount: 6,
        ),
      ),
    );
  }
}

class NetworkImageWithState extends StatelessWidget {
  const NetworkImageWithState({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;

  bool get _invalidUrl => url.trim().isEmpty;

  @override
  Widget build(BuildContext context) {
    if (_invalidUrl) {
      return const Icon(
        Icons.medical_services_outlined,
        size: 36,
        color: AppColors.background,
      );
    }

    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(
          child: CircularProgressIndicator(color: Colors.white),
        );
      },
      errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.error_outline, size: 36, color: AppColors.error),
    );
  }
}
