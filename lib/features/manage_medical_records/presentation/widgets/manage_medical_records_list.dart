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
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (context, index) {
              final item = list[index];
              final bool isUpdating = item.id == updatingId;

              return _SpecialtyGridItem(item: item, isUpdating: isUpdating);
            },
          );
        }

        return const SliverToBoxAdapter(child: UnExpectedError());
      },
    );
  }
}

class _SpecialtyGridItem extends StatelessWidget {
  const _SpecialtyGridItem({required this.item, required this.isUpdating});

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

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor2,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          const BoxShadow(
            color: Colors.black54,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NetworkImageWithState(
            url: item.specialty.image ?? "",
            width: width * 0.18,
            height: width * 0.18,
            fit: BoxFit.contain,
          ),
          Text(
            name,
            style: AppStyles.almaraiBold(
              context,
            ).copyWith(color: AppColors.background, fontSize: 15),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isRestricted ? context.tr.restricted : context.tr.public,
                style: AppStyles.almaraiRegular(
                  context,
                ).copyWith(color: AppColors.background, fontSize: 12),
              ),
              const SizedBox(width: 8),
              if (isUpdating)
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    color: Colors.white,
                  ),
                )
              else
                Switch(
                  value: isRestricted,
                  onChanged: (newValue) {
                    final newVisibility = newValue ? "restricted" : "public";
                    context
                        .read<SpecialtyAccessCubit>()
                        .updateSpecialtyVisibility(
                          specialtyAccessId: item.id,
                          newVisibility: newVisibility,
                        );
                  },
                  activeColor: Colors.white,
                  activeTrackColor: AppColors.kPrimaryColor1,
                ),
            ],
          ),
        ],
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
