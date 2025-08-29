import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/routing/route_names.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/widgets/un_expected_error.dart';
import 'package:oxytocin/features/medical_records/presentation/viewmodels/specialties_cubit.dart';
import 'package:oxytocin/features/medical_records/presentation/viewmodels/specialties_state.dart';

class SpecialityListBuilder extends StatelessWidget {
  const SpecialityListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return BlocBuilder<SpecialtiesCubit, SpecialtiesState>(
      builder: (context, state) {
        if (state is SpecialtiesLoading) {
          return SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Helper.buildShimmerBox(
                  width: width * 0.4,
                  height: width * 0.4,
                  count: 3,
                ),
                Helper.buildShimmerBox(
                  width: width * 0.4,
                  height: width * 0.4,
                  count: 3,
                ),
              ],
            ),
          );
        } else if (state is SpecialtiesSuccess) {
          final list = state.specialties;
          return SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final item = list[index];
              final name = Helper.isArabic(context) ? item.nameAr : item.nameEn;
              final image = list[index].image;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    NavigationService().pushToNamedWithParams(
                      RouteNames.doctorListView,
                      extra: {'id': item.id, 'name': name},
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor2,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        NetworkImageWithState(
                          url: image ?? "",
                          width: width * 0.22,
                          height: width * 0.22,
                          fit: BoxFit.fitHeight,
                        ),
                        Text(
                          name,
                          style: AppStyles.almaraiBold(
                            context,
                          ).copyWith(color: AppColors.background, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const UnExpectedError();
        }
      },
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
      return const Icon(Icons.error_outline, size: 36);
    }

    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;

        final expected = loadingProgress.expectedTotalBytes;
        final loaded = loadingProgress.cumulativeBytesLoaded;
        final value = (expected != null && expected > 0)
            ? loaded / expected
            : null;

        return Center(
          child: SizedBox(
            width: 28,
            height: 28,
            child: CircularProgressIndicator(value: value, strokeWidth: 3),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.error_outline, size: 36, color: AppColors.error),
    );
  }
}
